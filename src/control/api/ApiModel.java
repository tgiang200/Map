package control.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.WriteResult;

import control.tracker.TrackerModelMongoDB;
import mongo.database.ConnectMongo;

public class ApiModel {
	DBCollection collection = new ConnectMongo().connect("user");
	DBCollection collectionProducer = new ConnectMongo().connect("producer");
	DBCollection collectionShipper = new ConnectMongo().connect("shipper");
	DBCollection collectionKaa = new ConnectMongo().connectKaa("logs_24978294676695149906");
	public final String saltKey = "1234";
	
	//Get password from username
	public String getPassword(String username){
		String password=null;
		TrackerModelMongoDB tm = new TrackerModelMongoDB();
		DBCursor cursor = tm.queryUser(username);
		while (cursor.hasNext()) {
		    BasicDBObject obj = (BasicDBObject) cursor.next();
		    password = obj.getString("password");
		}
		return password;
	}
	
	
	public boolean login(String username, String password){
			BasicDBObject whereQuery = new BasicDBObject();
			whereQuery.put("username", username);
			whereQuery.put("password", password);
			DBCursor cursor = collection.find(whereQuery);
			return cursor.hasNext();
	}

	public boolean loginProducer(String username, String password){
		BasicDBObject whereQuery = new BasicDBObject();
		whereQuery.put("phone", username);
		whereQuery.put("password", password);
		DBCursor cursor = collectionProducer.find(whereQuery);
		return cursor.hasNext();
	}
	
	public boolean loginShipper(String username, String password){
		BasicDBObject whereQuery = new BasicDBObject();
		whereQuery.put("phone", username);
		whereQuery.put("password", password);
		DBCursor cursor = collectionShipper.find(whereQuery);
		return cursor.hasNext();
	}
	
	public boolean verifyPhoneInDB(String userType, String phone){
		boolean result = false;
		BasicDBObject whereQuery = new BasicDBObject();
		whereQuery.put("phone", phone);
		if (userType.equals("producer")){
			DBCursor cursor = collectionProducer.find(whereQuery);
			result = cursor.hasNext();
		} 
		if (userType.equals("shipper")){
			DBCursor cursor = collectionShipper.find(whereQuery);
			result = cursor.hasNext();
		} 
		return result;
	}
	
	public boolean changePassword(String userType, String phone, String newPassword){
		boolean result=false;
		BasicDBObject whereQuery = new BasicDBObject();
		BasicDBObject whereUpdate = new BasicDBObject();
		BasicDBObject password = new BasicDBObject();
		whereQuery.put("phone", phone);
		password.put("password", newPassword);
		whereUpdate.append("$set", password);
		if (userType.equals("producer")){
			WriteResult r = collectionProducer.update(whereQuery, whereUpdate);
			if (r.isUpdateOfExisting()){
				result=true;
			}
		}
		if (userType.equals("shipper")){
			WriteResult r = collectionShipper.update(whereQuery, whereUpdate);
			if (r.isUpdateOfExisting()){
				result=true;
			}
		}
		return result;
	}
	
	public String createCode(){
		Random rand = new Random();
		int  n = rand.nextInt(9999) + 1;
		return n+"";
	}
	
	public boolean checkSalt(String apiMethod, String username, String clientSalt){
		boolean result = false;
		Sha1Digest s = new Sha1Digest();
		try {
			String salt = Sha1Digest.sha1(apiMethod+username+saltKey);
			result = s.checkSha1(salt, clientSalt);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean checkSaltPass(String apiMethod, String username, String clientSalt){
		String password = getPassword(username);
		boolean result = false;
		Sha1Digest s = new Sha1Digest();
		try {
			String salt = Sha1Digest.sha1(apiMethod+username+password+saltKey);
			result = s.checkSha1(salt, clientSalt);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	public JSONObject resultRespone(String result, String message){
		JSONObject js = new JSONObject();
		try {
			js.put("result", result);
			js.put("message", message);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return js;
	}
	
	
	//lay tat ca user tu csdl
	public DBCursor getAllUserTrack(){
		DBCollection collection = new ConnectMongo().connect("user");
		DBCursor cursor = collection.find();
		return cursor;
	}
	
	
	//Kaa
	//--------------------------------------------------------------------------------
	
	//Lay du lieu TRUC TIEP tu csdl
	// GET user theo name de tracking
	public JSONArray getUserKaa(String name){
		BasicDBObject obj = new BasicDBObject();
		obj.put("event.username", name);
		JSONArray jsonArray = new JSONArray();
		DBCursor cursor = collectionKaa.find(obj);
		while (cursor.hasNext()){
			jsonArray.put(cursor.next());
			//System.out.println(cursor.next());
		}
		return jsonArray;
	}
	
	// GET danh sach user co trong csdl
	public JSONArray getListUserKaa(){
		JSONArray array = new JSONArray();
		List<String> list = collectionKaa.distinct("event.username");
		for (int i=0; i<list.size(); i++){
			array.put(list.get(i).toString());
		}
		return array;
	}
	
	
	// GET user onwork with timestamp
	public void listOnwork(){
		Date date = new Date();
		Timestamp t = new Timestamp(date.getYear(),date.getMonth(),date.getDate(),date.getHours(),date.getMinutes(),date.getSeconds(),10);
		System.out.println(t);
	}
	
	
	// Lay tu API
	// API get 1 user de ve duong di
	public JSONArray getUserKaaApi(String name){
		JSONArray array = new JSONArray();
		try {
			array = new ApiModel().readJsonFromUrl("http://192.168.0.116:8008/user/"+name);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return array;
	}
	
	// API get vi tri user onwork
	public JSONArray getAllUserKaaApi(){
		JSONArray array = new JSONArray();
		try {
			array = new ApiModel().readJsonFromUrl("http://172.30.40.154:8008/users");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return array;
	}
	
	// readAll 
	public static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
            sb.append((char) cp);
        }
        return sb.toString();
    }
	
	//GET JSON from API
	public JSONArray readJsonFromUrl(String url) throws IOException {
        // String s = URLEncoder.encode(url, "UTF-8");
        // URL url = new URL(s);
        InputStream is = new URL(url).openStream();
        JSONArray json = null;
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            json = new JSONArray(jsonText);
        } catch (JSONException e) {
            e.printStackTrace();
        } finally {
            is.close();
        }
        return json;
    }
	
	
	
	
	
	//---------------------------------------------------------------------------------------
	public static void main(String [] args) throws IOException, JSONException{
//		JSONArray array = new ApiModel().readJsonFromUrl("http://192.168.43.135:8008/user/my");
//		System.out.println("start");
//		for (int i=0; i<array.length(); i++){
//			System.out.println(array.get(i));
//		}
//		//JSONArray array = new ApiModel().getUserKaa("user1");
//		for (int i=0; i<array.length(); i++){
//			System.out.println(array.get(i));
//		}
		boolean r = new ApiModel().changePassword("shipper", "0123", "abc");
		System.out.println(r);
	}
}
