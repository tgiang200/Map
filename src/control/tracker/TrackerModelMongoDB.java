package control.tracker;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.WriteResult;

import mongo.database.ConnectMongo;

public class TrackerModelMongoDB {
	// Chon bang "user" trong csdl
	public static DBCollection collection = new ConnectMongo().connect("user");

	// ham insert du lieu
	public void insertUser(BasicDBObject document) {
		collection.insert(document);
	}

	// ham truy van du lieu
	public DBCursor queryAllUser() {
		BasicDBObject sort = new BasicDBObject();
		sort.append("name", 1);
		DBCursor cursor = collection.find().sort(sort);
		return cursor;
	}

	public boolean updateLatLng(String user, String lat, String lng) {
		BasicDBObject whereQuery = new BasicDBObject();
		BasicDBObject whereUpdate = new BasicDBObject();
		BasicDBObject LatLng = new BasicDBObject();
		whereQuery.put("name", user);
		LatLng.put("lat", lat);
		LatLng.put("lng", lng);
		whereUpdate.append("$set", LatLng);
		WriteResult r = collection.update(whereQuery, whereUpdate);
		if (r.isUpdateOfExisting()) {
			return true;
		} else {
			return false;
		}
	}

	// tim kim theo username
	public DBCursor queryUser(String username) {
		BasicDBObject whereQuery = new BasicDBObject();
		whereQuery.put("name", username);
		DBCursor cursor = collection.find(whereQuery);
		return cursor;
	}

	// ham update du lieu
	public void updateUser(String keyObject, String value, String keyUpdate, String valueUpdate) {
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append(keyUpdate, valueUpdate)); // $set
																						// <=>
																						// update
		BasicDBObject searchQuery = new BasicDBObject().append(keyObject, value);
		collection.update(searchQuery, newDocument);
	}

	// ham delete du lieu
	public void deleteUser(String key, String value) {
		BasicDBObject document = new BasicDBObject();
		document.put(key, value);
		collection.remove(document);
	}

	// ham cap nhat Array latlng
	public boolean pushLatLng(String username, String lat, String lng) {
		BasicDBObject newDocument = new BasicDBObject();
		BasicDBObject latLng = new BasicDBObject();
		latLng.put("latArray", lat);
		latLng.put("lngArray", lng);
		newDocument.append("$push", latLng); // $push <=> them vao mang
		BasicDBObject searchQuery = new BasicDBObject().append("name", username);
		WriteResult r = collection.update(searchQuery, newDocument);
		;
		if (r.isUpdateOfExisting()) {
			return true;
		} else {
			return false;
		}

	}

	public boolean pushLatLng(String username, String[] lat, String[] lng) {
		BasicDBObject newDocument = new BasicDBObject();
		BasicDBObject latLng = new BasicDBObject();
		BasicDBObject latArr = new BasicDBObject();
		BasicDBObject lngArr = new BasicDBObject();
		latArr.append("$each", lat);
		lngArr.append("$each", lng);
		latLng.put("latArray", latArr);
		latLng.put("lngArray", lngArr);
		newDocument.append("$push", latLng); // $push <=> them vao mang
		BasicDBObject searchQuery = new BasicDBObject().append("name", username);
		WriteResult r = collection.update(searchQuery, newDocument);
		;
		if (r.isUpdateOfExisting()) {
			return true;
		} else {
			return false;
		}

	}

	public static void main(String[] args) {
		TrackerModelMongoDB d = new TrackerModelMongoDB();
		BasicDBObject document = new BasicDBObject();
		// document.put("name", "user3");
		// document.put("password", "user3");
		// document.put("status", "on");
		// document.put("lat", "");
		// document.put("lng", "");
		// // d.insertUser(document);
		// // d.updateUser("name", "user2", "status", "off");
		// // d.deleteUser("password", "user3");
		// // System.out.println("updated");
		// //boolean b = d.updateLatLng("user1", "10.028695754628739",
		// "105.7643999999999");
		// String[] lat = {"1","2"};
		// String[] lng = {"1","2"};
		// d.pushLatLng("user1", lat, lng);
		
		DBCursor cursor = d.queryAllUser();
		System.out.println("result");
		System.out.println(cursor.hasNext());
		while (cursor.hasNext()) {
			System.out.println(cursor.next());
		}

	}
}
