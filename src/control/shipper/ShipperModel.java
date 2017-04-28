package control.shipper;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DuplicateKeyException;
import com.mongodb.WriteConcern;
import com.mongodb.WriteResult;

import mongo.database.ConnectMongo;

public class ShipperModel {
	public static DBCollection collection = new ConnectMongo().connect("shipper");

	// tìm tất cả shipper
	public DBCursor queryAllShipper() {
		DBCursor cursor = collection.find();
		return cursor;
	}

	public boolean insertShipper(BasicDBObject shipper) {
		try {
			collection.insert(shipper, WriteConcern.SAFE);
			return true;
		} catch (DuplicateKeyException ex) {
			return false;
		}
	}

	public boolean updateShipper(BasicDBObject shipper, String phone) {
		try {
			BasicDBObject searchQuery = new BasicDBObject().append("phone", phone);
			WriteResult wr = collection.update(searchQuery, shipper);
			if (wr.isUpdateOfExisting()) {
				return true;
			} else {
				return false;
			}
		} catch (DuplicateKeyException ex) {
			return false;
		}
	}

	public void deleteShipper(String phone) {
		BasicDBObject query = new BasicDBObject();
		query.put("phone", phone);
		collection.remove(query);
	}

	public String getStatus(String shipperID) {
		String result = "";
		BasicDBObject query = new BasicDBObject();
		query.put("phone", shipperID);
		DBCursor cursor = collection.find(query);
		if (cursor.hasNext()) {
			result = cursor.next().get("statusConfirm").toString();
		}
		return result;
	}

	public void updateStatusConfirm(String idShipper, String status) {
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append("statusConfirm", status)); // $set
																							// <=>
																							// update
		BasicDBObject searchQuery = new BasicDBObject().append("phone", idShipper);
		collection.update(searchQuery, newDocument);
	}

	public DBCursor listConfirm() {
		BasicDBObject query = new BasicDBObject();
		query.append("statusConfirm", "waiting");
		DBCursor cursor = collection.find(query);
		return cursor;
	}

	public JSONArray queryShipperStatus(String status) {
		JSONArray arrayShipper = new JSONArray();
		JSONObject shipper = new JSONObject();
		BasicDBObject query = new BasicDBObject();
		query.put("statusConfirm", status);
		DBCursor cursor = collection.find(query);
		while (cursor.hasNext()) {
			try {
				shipper = new JSONObject(cursor.next().toString());
				arrayShipper.put(shipper);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return arrayShipper;
	}

	public DBCursor queryShipper(String shipper) {
		BasicDBObject query = new BasicDBObject();
		query.append("phone", shipper);
		DBCursor cursor = collection.find(query);
		return cursor;
	}

	public boolean updateFunds(String phone, String newFunds) {
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append("funds", newFunds));
		BasicDBObject searchQuery = new BasicDBObject().append("phone", phone);
		WriteResult r = collection.update(searchQuery, newDocument);
		if (r.isUpdateOfExisting()) {
			return true;
		} else {
			return false;
		}
	}

	public String getCurrentFunds(String idShipper) {
		String result = "0";
		BasicDBObject shipper = new BasicDBObject();
		shipper.put("phone", idShipper);
		DBCursor cursor = collection.find(shipper);
		if (cursor.hasNext()) {
			result = cursor.next().get("funds").toString();
		}
		return result;
	}

	public void logChangeFunds(String user, String shipper, String time, double value) {
		DBCollection col = new ConnectMongo().connect("logChangeFunds");
		BasicDBObject log = new BasicDBObject();
		log.put("user", user);
		log.put("ShipperID", shipper);
		log.put("time", time);
		log.put("value", value);
		col.insert(log);
	}

	public boolean addFundsOfShipper(String idShipper, double fundsAdd, HttpSession session){
		boolean result = false;
		ShipperModel sm = new ShipperModel();
		String currentFunds = sm.getCurrentFunds(idShipper);
		double newFunds = Double.parseDouble(currentFunds) + fundsAdd;
		//Ghi log
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		String time = dateFormat.format(date).toString();
		new ShipperModel().logChangeFunds(session.getAttribute("username").toString(),idShipper, time, fundsAdd);
		result = sm.updateFunds(idShipper, newFunds+"");
		return result;
	}
	// tim kim shipper theo keyword
	public JSONArray searchShipper(String keyword) {
		JSONArray array = new JSONArray();
		DBCursor cursor = collection.find(new BasicDBObject("$text", new BasicDBObject("$search", keyword)));
		while (cursor.hasNext()) {
			array.put(cursor.next());
		}
		return array;
	}
	
	public static void main(String[] args) {
		ShipperModel sm = new ShipperModel();
		String date = new Date().toString();
		sm.logChangeFunds("test","1111", date, -20);
		// System.out.println(up);
	}
}
