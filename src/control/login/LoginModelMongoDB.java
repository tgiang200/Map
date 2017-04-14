package control.login;

import java.net.InetAddress;
import java.net.UnknownHostException;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;

public class LoginModelMongoDB {
	// ket noi mongodb
	public static MongoClient mongoClient = new MongoClient(
			new MongoClientURI("mongodb://user1:user1@localhost/admin"));
	// chon csdl "tracker"
	public static DB db = mongoClient.getDB("tracker");
	// Chon bang "user" trong csdl
	public static DBCollection collection = db.getCollection("user");

	public boolean login(String username, String password) {
		BasicDBObject whereQuery = new BasicDBObject();
		whereQuery.put("username", username);
		whereQuery.put("password", password);
		DBCursor cursor = collection.find(whereQuery);
		if (cursor.hasNext()) {
			return true;
		} else {
			return false;
		}
	}

	
	
	public static void main(String[] args) {
		LoginModelMongoDB lm = new LoginModelMongoDB();
		boolean result = lm.login("user2", "user2");
		System.out.println(result);
		try {
			System.out.println(InetAddress.getLocalHost().getHostAddress());
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
