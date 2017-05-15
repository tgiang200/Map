package control.order;

import java.util.Date;

import org.bson.types.ObjectId;
import org.hibernate.mapping.Collection;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.LoggerFactory;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DuplicateKeyException;
import com.mongodb.WriteConcern;
import com.mongodb.WriteResult;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.LoggerContext;
import mongo.database.ConnectMongo;

public class OrderModel {
	public static DBCollection collectionOrder = new ConnectMongo().connect("order");
	public static DBCollection collectionShipper = new ConnectMongo().connect("shipper");

	public boolean insertOrder(BasicDBObject order) {
		try {
			collectionOrder.insert(order, WriteConcern.SAFE);
			return true;
		} catch (DuplicateKeyException ex) {
			return false;
		}
	}

	// Lay danh sach order dang cho xac nhan / tìm shipper
	public DBCursor listConfirm() {
		BasicDBObject query = new BasicDBObject();
		query.append("status", "waitingConfirm");
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	public DBCursor listFindingShipper() {
		BasicDBObject query = new BasicDBObject();
		query.append("status", "findingShipper");
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	public DBCursor listOrderCompleted() {
		BasicDBObject query = new BasicDBObject();
		query.append("status", "completed");
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	// tim kim order theo keyword
	public JSONArray searchOrder(String keyword) {
		JSONArray array = new JSONArray();
		JSONObject object = new JSONObject();
		DBCursor cursor = collectionOrder.find(new BasicDBObject("$text", new BasicDBObject("$search", keyword)));
		while (cursor.hasNext()) {
			try {
				object = new JSONObject(cursor.next().toString());
				array.put(object);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//System.out.println(cursor.next());
		}
		return array;
	}

	// Lay danh sach order dang duoc van chuyen
	public DBCursor listConfirmTransporting() {
		BasicDBObject query = new BasicDBObject();
		query.append("status", "transporting");
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	// Lay danh sach order da van chuyen
	public DBCursor listConfirmTransported() {
		BasicDBObject query = new BasicDBObject();
		query.append("status", "transported");
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	// Lay chi tiet order
	public DBCursor queryOrder(String idOrder) {
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		return cursor;
	}

	// lay trang thai don hang
	public String getOrderStatus(String idOrder) {
		String status = "";
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		if (cursor.hasNext()) {
			status = cursor.next().get("status").toString();
		}
		return status;
	}

	public DBCursor queryAllOrder() {
		DBCursor cursor = collectionOrder.find();
		return cursor;
	}

	public DBCursor queryAllOrderOfProducer(String idProducer) {
		BasicDBObject query = new BasicDBObject();
		query.append("producer.phone", idProducer);
		DBCursor cursor = collectionOrder.find(query);
		return cursor;
	}

	// kiem tra trang thai don hang
	public String verifyStatusOrder(String idOrder) {
		String status = "";
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		if (cursor.hasNext()) {
			status = (String) cursor.next().get("status");
		}
		return status;
	}

	// Cap nhat trang thai order
	public boolean updateStatus(String idOrder, String status) {
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append("status", status)); // $set
																					// <=>
																					// update
		ObjectId id = new ObjectId(idOrder);
		BasicDBObject searchQuery = new BasicDBObject().append("_id", id);
		WriteResult writeResult = collectionOrder.update(searchQuery, newDocument);
		int resultN = writeResult.getN();
		if (resultN > 0) {
			return true;
		} else {
			return false;
		}
	}

	// Cap nhat shipper cho don hang
	public boolean updateShipper(String idOrder, String shipperID) {
		boolean result = false;
		BasicDBObject shipperObject = new BasicDBObject();
		BasicDBObject queryShipper = new BasicDBObject();
		queryShipper.append("phone", shipperID);
		DBCursor cursor = collectionShipper.find(queryShipper);
		if (cursor.hasNext()) {
			shipperObject = (BasicDBObject) cursor.next();
			BasicDBObject newShipper = new BasicDBObject();
			newShipper.append("$set", new BasicDBObject().append("shipper", shipperObject)); // $set
																								// <=>
																								// update
			ObjectId id = new ObjectId(idOrder);
			BasicDBObject searchQuery = new BasicDBObject().append("_id", id);
			WriteResult writeResult = collectionOrder.update(searchQuery, newShipper);
			int resultN = writeResult.getN();
			if (resultN > 0) {
				result = true;
			}
		}
		return result;

	}

	// Cap nhat shipper cho don hang
	public boolean deleteShipper(String idOrder, String shipper) throws JSONException {
		boolean result = false;
		BasicDBObject shipperObject = new BasicDBObject();
		String shipperID = new OrderModel().getShipperIDFromOrder(idOrder);
		if (!shipper.equals(shipperID)){
			return false;
		}
		BasicDBObject newShipper = new BasicDBObject();
		newShipper.append("$set", new BasicDBObject().append("shipper", shipperObject));
		ObjectId id = new ObjectId(idOrder);
		BasicDBObject searchQuery = new BasicDBObject().append("_id", id);
		WriteResult writeResult = collectionOrder.update(searchQuery, newShipper);
		int resultN = writeResult.getN();
		if (resultN > 0) {
			result = true;
		}
		return result;

	}

	// Kiem tra shipper cua don hang
	public boolean verifyShipperOrder(String idOrder) {
		boolean result = false;
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		JSONObject order = new JSONObject();
		while (cursor.hasNext()) {
			try {
				order = new JSONObject(cursor.next().toString());
				if (order.getJSONObject("shipper").has("phone")) {
					result = true;
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	// quet tim shipper trong pham vi 2km
	public JSONArray getListShipper(String producerLat, String producerLng, double radius) {
		double pLat = Double.parseDouble(producerLat);
		double pLng = Double.parseDouble(producerLng);
		double sLat, sLng, d;
		JSONArray arrayShipper = new JSONArray();
		JSONObject shipperObj = new JSONObject();
		DBCollection collection = new ConnectMongo().connectKaa("logs_24978294676695149906"); // ket
																								// noi
																								// den
																								// kaa
		DBCursor cursor = collection.find();
		while (cursor.hasNext()) {
			try {
				shipperObj = new JSONObject(cursor.next().toString());
				sLat = shipperObj.getJSONObject("event").getDouble("lat");
				sLng = shipperObj.getJSONObject("event").getDouble("lng");
				;
				d = distance(pLat, pLng, sLat, sLng);
				// System.out.println(d);
				if (d < radius) {
					arrayShipper.put(shipperObj);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return arrayShipper;
	}

	public void findingShipper(String idOrder) {
		SelectShipper sp = new SelectShipper(idOrder);
		sp.start();
	}

	// ham tinh khoang cach giua 2 diem
	public static double distance(double lat1, double lng1, double lat2, double lng2) {

		final int R = 6371; // Radius of the earth

		Double latDistance = Math.toRadians(lat2 - lat1);
		Double lonDistance = Math.toRadians(lng2 - lng1);
		Double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2) + Math.cos(Math.toRadians(lat1))
				* Math.cos(Math.toRadians(lat2)) * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
		Double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		double distance = R * c; // km
		distance = Math.pow(distance, 2);

		return Math.sqrt(distance);
	}

	// Lay gia van chuyen tu gia xang
	public double getPriceTransport(String vehicle) {
		double price = 0;
		DBCollection collectionPrice = new ConnectMongo().connect("transportPrice");
		DBCursor cursor = collectionPrice.find();
		while (cursor.hasNext()) {
			price = Double.parseDouble(cursor.next().get(vehicle).toString());
		}
		return price;
	}

	public String getPriceOrder(String idOrder) {
		String price = "0";
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		if (cursor.hasNext()) {
			price = (String) cursor.next().get("shippingPrice");
		}
		return price;
	}

	public String getShipperIDFromOrder(String idOrder) throws JSONException {
		String shipper = "";
		BasicDBObject obj = new BasicDBObject();
		ObjectId id = new ObjectId(idOrder);
		obj.put("_id", id);
		DBCursor cursor = collectionOrder.find(obj);
		if (cursor.hasNext()) {
			JSONObject s = new JSONObject(cursor.next().toString());
			shipper = s.getJSONObject("shipper").getString("phone");
			// shipper = (String) cursor.next().get("shipper").toString();
		}
		return shipper;
	}
	
	public JSONArray getShipperOfProducer(String producerID) throws JSONException{
		JSONArray array =  new JSONArray();
		JSONObject shipper = new JSONObject();
		BasicDBObject query =  new BasicDBObject();
		BasicDBObject in = new BasicDBObject();
		String [] status = {"transporting", "transported", "completed"};
		query.put("producer.phone", producerID);
		in.put("$in", status);
		query.put("status", in);
		DBCursor cursor = collectionOrder.find(query);
		while (cursor.hasNext()){
			shipper = new JSONObject(cursor.next().get("shipper").toString());
			array.put(shipper);
		}
		return array;
	}
	public static void main(String[] args) throws JSONException {
		OrderModel od = new OrderModel();
//		// DBCursor cursor = od.queryAllOrderOfProducer("012");
//		// while (cursor.hasNext()){
//		//System.out.println(od.deleteShipper("58f0e64c9fd5a3250852a1f0", "11111"));
//		// }
		od.findingShipper("58f0da329fd5a3250867610b");
		
	}

}
