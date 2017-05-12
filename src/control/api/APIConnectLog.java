package control.api;

import java.security.NoSuchAlgorithmException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;

@Controller
@RequestMapping(value = "/log")
public class APIConnectLog {

	// API tra ve vi tri cua mot user
	@RequestMapping(value = "/getUserTrack/{username}/{salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getUserTrack(Model model, HttpSession session, HttpServletRequest request,
			@PathVariable String username, @PathVariable String salt) throws NoSuchAlgorithmException {

		String verify = new Sha1Digest().sha1("getUserTrack" + "1234");
		String str;
		// if (verify.equals(salt)) {
		if (true) {
			// Goi ham getUser tu model: getUserKaaApi() || getUserKaa()
			JSONArray jsonArray = new APIConnectLog().getUser(username);
			// List<DBObject> list = db.toArray();
			str = jsonArray.toString();
		} else {
			str = null;
		}
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API tra ve danh sach user de tracking
	@RequestMapping(value = "/getListUserTrack/{salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getListUserTrack(Model model, @PathVariable String salt)
			throws NoSuchAlgorithmException {
		// kiem tra salt
		String verify = new Sha1Digest().sha1("");
		JSONArray jsonArray = new JSONArray();
		if (!verify.equals(salt)) {
			jsonArray = new ApiModel().getListUserKaa();
		}
		String str = jsonArray.toString();
		System.out.println(str);
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API tra ve tat ca cac user trong csdl cung vi tri de hien thi len ban do
	@RequestMapping(value = "/getAlltUserTrack/{salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getAllUserTrack(Model model, @PathVariable String salt)
			throws NoSuchAlgorithmException {
		// kiem tra salt
		// String verify = new Sha1Digest().sha1("");
		JSONArray jsonArray = new JSONArray();
		if (true) {
			jsonArray = new APIConnectLog().getOnwork();
			// jsonArray = new ApiModel().getAlltUserKaaApi();
		}
		String str = jsonArray.toString();
		System.out.println(str);
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	
	
	
	
	
	
	
	
	
	
	public DBCollection connectKaaLog(String col) {
		DBCollection collection = null;
		// ket noi mongodb
		Mongo mongo = new Mongo("192.168.43.10", 27017);
		// chon csdl "tracker"
		DB db = mongo.getDB("kaa");
		// Chon bang "user" trong csdl
		collection = db.getCollection(col);
		return collection;
	}

	public static DBCollection collectionKaa = new APIConnectLog().connectKaaLog("logs_18693008741969774929");

	public JSONArray getOnwork() {
		JSONArray array = new JSONArray();
		Date now2 = new Date();
		long nowMilliseconds = now2.getTime();
		DBCursor cursor = collectionKaa.find();
		while (cursor.hasNext()) {
			JSONObject obj;
			try {
				obj = new JSONObject(cursor.next().toString());
				
				if (nowMilliseconds-obj.getJSONObject("header").getJSONObject("timestamp").getLong("long")>10500){
					array.put(obj);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// System.out.println(cursor.next());

		}
		System.out.println(array);
		return array;
	}

	public JSONArray getUser(String username) {
		BasicDBObject query = new BasicDBObject();
		query.put("event.username", username);
		JSONArray array = new JSONArray();
		DBCursor cursor = collectionKaa.find(query);
		while (cursor.hasNext()) {
			JSONObject obj;
			try {
				obj = new JSONObject(cursor.next().toString());
				array.put(obj);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// System.out.println(cursor.next());

		}
		System.out.println(array);
		return array;
	}

	public static void main(String[] agrs) {
		JSONArray array = new APIConnectLog().getUser("B1304623");
		Date now2 = new Date();
		long nowMilliseconds = now2.getTime();
		System.out.println(nowMilliseconds);
	}
}
