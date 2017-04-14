package control.producer;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DuplicateKeyException;
import com.mongodb.WriteConcern;

import mongo.database.ConnectMongo;

public class ProducerModel {
	public static DBCollection collection = new ConnectMongo().connect("producer");
	
	public DBCursor queryAllProducer(){
		DBCursor cursor = collection.find();
		return cursor;
	}
	
	public boolean insertProducer(BasicDBObject producer){
		try {
			collection.insert(producer,WriteConcern.SAFE);
			return true;
		} catch (DuplicateKeyException ex){
			return false;
		}
	}

	public void deleteProducer(String phone){
		BasicDBObject query = new BasicDBObject();
		query.put("phone", phone);
		collection.remove(query);
	}
	
	public void updateStatusConfirm(String phone, String status){
		BasicDBObject newDocument = new BasicDBObject();
		newDocument.append("$set", new BasicDBObject().append("statusConfirm", status)); //$set <=> update 
		BasicDBObject searchQuery = new BasicDBObject().append("phone", phone);
		collection.update(searchQuery, newDocument);
	}
	
	public DBCursor listConfirm(){
		BasicDBObject query = new BasicDBObject();
		query.put("statusConfirm", "waiting");
		DBCursor cursor = collection.find(query);
		return cursor;
	}
	
	public JSONArray queryProducerStatus(String status){
		JSONArray arrayProducer = new JSONArray();
		JSONObject producer = new JSONObject();
		BasicDBObject query = new BasicDBObject();
		query.put("statusConfirm", status);
		DBCursor cursor = collection.find(query);
		while (cursor.hasNext()){
			try {
				producer = new JSONObject(cursor.next().toString());
				arrayProducer.put(producer);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return arrayProducer;
	}
	
	public String getStatus(String producerID){
		String result = "";
		BasicDBObject query = new BasicDBObject();
		query.put("phone", producerID);
		DBCursor cursor = collection.find(query);
		if (cursor.hasNext()){
			result = cursor.next().get("statusConfirm").toString();
		}
		return result;
	}
	
	//Tìm producer theo số điện thoại
	public DBCursor queryProducer(String phone){
		BasicDBObject query = new BasicDBObject();
		query.append("phone", phone);
		DBCursor cursor = collection.find(query);
		return cursor;
	}
	
	public static void main(String [] args) throws JSONException{
		ProducerModel pm = new ProducerModel();
		//new ProducerModel().updateStatusProducer("12345","waiting");
//		while (cursor.hasNext()){
//			//BasicDBObject obj = (BasicDBObject) (cursor.next().get("_id"));
//			System.out.println(cursor.next()); 
//		}
		JSONArray array = pm.queryProducerStatus("waiting");
		for (int i=0; i<array.length(); i++){
			System.out.println(array.getJSONObject(i).toString());
		}
		System.out.println("complete");
	}
}
