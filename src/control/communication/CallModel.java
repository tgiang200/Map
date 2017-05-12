package control.communication;

import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

import mongo.database.ConnectMongo;

public class CallModel {
	public String getSIPAccount(String userType, String name) throws JSONException {
		JSONObject acc = new JSONObject();
		JSONObject user = new JSONObject();
		String SIPAcc = "";
		if (userType.equals("center")) {
			DBCollection c = new ConnectMongo().connect("user");
			BasicDBObject query = new BasicDBObject();
			query.put("username", name);
			DBCursor cursor = c.find(query);
			while (cursor.hasNext()) {
				user = new JSONObject(cursor.next().toString());
				SIPAcc = user.getString("SIPAccount");
			}
		}
		if (userType.equals("producer")) {
			DBCollection c = new ConnectMongo().connect("producer");
			DBCursor cursor = c.find();
			while (cursor.hasNext()) {
				user = new JSONObject(cursor.next().toString());
				// acc = user.getJSONObject("SIPAccount");
				SIPAcc = user.getString("SIPAccount");
			}
		}
		if (userType.equals("shipper")) {
			DBCollection c = new ConnectMongo().connect("shipper");
			DBCursor cursor = c.find();
			while (cursor.hasNext()) {
				user = new JSONObject(cursor.next().toString());
				// acc = user.getJSONObject("SIPAccount");
				SIPAcc = user.getString("SIPAccount");
			}
		}

		return SIPAcc;
	}

	public void createSIPAccount() {
		DBCollection col = new ConnectMongo().connect("SIPAccount");
		for (int i = 21; i < 41; i++) {
			BasicDBObject acc = new BasicDBObject();
			acc.put("account", "user" + i);
			acc.put("password", "user" + i + "user" + i);
			acc.put("status", "false");
			col.insert(acc);

		}
	}

	public static void main(String args[]) throws JSONException {
		new CallModel().createSIPAccount();
		// System.out.println(acc);
	}
}
