package mongo.database;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

import control.producer.ProducerModel;

public class ConnectMongo {
	public DBCollection connect(String collectionConnect) {
		// ket noi mongodb
		MongoClient mongoClient = new MongoClient(new MongoClientURI("mongodb://user1:user1@localhost/admin"));
		// chon csdl "tracker"
		DB db = mongoClient.getDB("tracker");
		// Chon bang "user" trong csdl
		DBCollection collection = db.getCollection(collectionConnect);

		return collection;
	}

	public DBCollection connectKaa(String col) {
		DBCollection collection = null;
		// ket noi mongodb
		Mongo mongo = new Mongo("localhost", 27017);
		// chon csdl "tracker"
		DB db = mongo.getDB("kaa");
		// Chon bang "user" trong csdl
		collection = db.getCollection(col);
		return collection;
	}


	
	
	//------------------------------------------------------------------------------
	public DBCursor queryAllOnwork() {
		DBCollection collection = new ConnectMongo().connectKaa("logs_24978294676695149906");
		DBCursor cursor = collection.find();
		return cursor;
	}

	public static void main(String[] args) throws JSONException {
		DBCursor cursor = new ConnectMongo().queryAllOnwork();
		JSONArray array = new JSONArray();
		BasicDBObject obj = new BasicDBObject();
		while (cursor.hasNext()) {
			obj = (BasicDBObject) cursor.next().get("event");
			array.put(obj);
		}
		System.out.println(array);
		//JSONObject obj = new JSONObject(array.toString()); 
//		for (int i=0; i<array.length(); i++){
//			if (array.getJSONObject(i).get("userName").equals("user2")){
//				System.out.println(array.getJSONObject(i).get("userName"));
//			}
//		}
		//System.out.println(array.toString());
	}

}
