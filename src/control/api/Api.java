package control.api;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.order.OrderModel;
import control.producer.ProducerModel;
import control.shipper.ShipperModel;
import control.tracker.TrackerModelMongoDB;

@Controller
@RequestMapping(value = "/api")
public class Api {

	// API đăng nhập
	@RequestMapping(value = "/login/userType={user}&username={username}&password={password}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> login(Model model, @PathVariable String user, @PathVariable String username,
			@PathVariable String password, HttpSession session) throws JSONException {

		String userType = user;
		boolean resultLogin = false;
		ApiModel ap = new ApiModel();
		JSONObject userObject = new JSONObject();
		if (userType.equals("center")) {
			resultLogin = ap.login(username, password);
		}
		if (userType.equals("producer")) {
			resultLogin = ap.loginProducer(username, password);
			if (resultLogin){
				DBCursor cursor = new ProducerModel().queryProducer(username);
				userObject = new JSONObject(cursor.next().toString());
			}
		}
		if (userType.equals("shipper")) {
			resultLogin = ap.loginShipper(username, password);
			if (resultLogin){
				DBCursor cursor = new ShipperModel().queryShipper(username);
				userObject = new JSONObject(cursor.next().toString());
			}
		}
		// tao doi tuong json luu ket qua tra ve cho client
		JSONObject obj = new JSONObject();
		if (resultLogin) {
			session.setAttribute("username", username);
			session.setAttribute("userType", userType);
			//obj = ap.resultRespone("success", " login success");
			obj.put("result","success");
			obj.put("message", "login success");
			obj.put("user", userObject);
		} else {
			model.addAttribute("message", "Username or password incorrect");
			obj = ap.resultRespone("failed", "Username or password incorrect");
		}
		String str = obj.toString();
		System.out.println(str);
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// Kiem tra sdt trong csdl
	@RequestMapping(value = "/forgot/userType={userType}&phone={phone}")
	@ResponseBody
	public String verifyPhoneInDB(@PathVariable String userType, @PathVariable String phone) throws JSONException {
		JSONObject respone = new JSONObject();
		ApiModel ap = new ApiModel();
		String code;
		boolean result = ap.verifyPhoneInDB(userType, phone);
		System.out.println(userType + "-" + phone);
		if (result) {
			code = ap.createCode();
			respone.put("result", "true");
			respone.put("code", code);
			respone.put("message", "Phone existed in database");
		} else {
			code = ap.createCode();
			respone.put("result", "false");
			respone.put("code", code);
			respone.put("message", "Phone didnt exist in database");
		}
		// return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
		return respone.toString();
	}

	// API doi mat khau
	@RequestMapping(value = "/changePassword/userType={userType}&phone={phone}&newPassword={newPassword}")
	public ResponseEntity<String> changePassword(@PathVariable String userType, @PathVariable String phone,
			@PathVariable String newPassword) {
		ApiModel ap = new ApiModel();
		boolean resultChange = ap.changePassword(userType, phone, newPassword);
		JSONObject respone = new JSONObject();
		if (resultChange) {
			respone = ap.resultRespone("true", "Password is changed");
		} else {
			respone = ap.resultRespone("false", "Phone incorrect");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	// API xac nhan van chuyen tu shipper
	@RequestMapping(value = "/order/confirmTransport/idShipper={idShipper}&idOrder={idOrder}")
	public ResponseEntity<String> confirmTransport(@PathVariable String idShipper, @PathVariable String idOrder) {
		boolean resultConfirm = new control.order.OrderModel().updateShipper(idOrder, idShipper);
		ApiModel ap = new ApiModel();
		JSONObject respone = new JSONObject();
		if (resultConfirm) {
			// Cap nhan trang thai dang giao hang cho don hang
			new control.order.OrderModel().updateStatus(idOrder, "transporting");
			respone = ap.resultRespone("true", "Confirmed");
		} else {
			respone = ap.resultRespone("false", "Cannot confirm");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	// API dang nhap voi ma hoa sha1
	@RequestMapping(value = "/login/username={username}&salt={salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> loginSalt(Model model, @PathVariable String username, @PathVariable String salt,
			HttpSession session) throws JSONException {

		// kiem tra salt duoc goi va check salt
		boolean resultLogin = new ApiModel().checkSaltPass("login", username, salt);
		// tao doi tuong json luu ket qua tra ve cho client
		JSONObject obj = new JSONObject();
		ApiModel ap = new ApiModel();

		if (resultLogin) {
			session.setAttribute("username", username);
			obj = ap.resultRespone("success", " login success");
		} else {
			model.addAttribute("message", "Username or password incorrect");
			obj = ap.resultRespone("failed", "Username or password incorrect");
		}
		String str = obj.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API dang xuat
	@RequestMapping(value = "/logout/username={username}&salt={salt}/", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> logout(Model model, @PathVariable String username, @PathVariable String salt,
			HttpSession session) throws JSONException {
		ApiModel ap = new ApiModel();
		boolean resultLogout = ap.checkSaltPass("logout", username, salt);
		JSONObject obj = new JSONObject();
		if (resultLogout) {
			session.removeAttribute("username");
			obj = ap.resultRespone("success", "logout success");
		} else {
			obj = ap.resultRespone("failed", "cannot close session");
		}
		String str = obj.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API dang xuat
	@RequestMapping(value = "/logout/username={username}&password={password}/", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> logoutSalt(Model model, @PathVariable String username, @PathVariable String password,
			HttpSession session) throws JSONException {
		ApiModel ap = new ApiModel();
		boolean resultLogout = ap.login(username, password);
		JSONObject obj = new JSONObject();
		if (resultLogout) {
			session.removeAttribute("username");
			obj = ap.resultRespone("success", "logout success");
		} else {
			obj = ap.resultRespone("failed", "cannot close session");
		}
		String str = obj.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	@RequestMapping(value = "/testApi/user={user}&lat={lat}&lng={lng}/", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> test(Model model, @PathVariable String user, @PathVariable String lat,
			@PathVariable String lng) throws JSONException {
		JSONObject obj = new JSONObject();
		obj.put("result", "true");
		obj.put("message", "success");
		obj.put("data", user + " - " + lat + " - " + lng);
		String str = obj.toString();
		System.out.println(str);
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API cap nhat vi tri cua user
	@RequestMapping(value = "/updateLocation/username={username}&lat={lat}&lng={lng}&salt={salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> updateLocation(Model model, @PathVariable String username, @PathVariable String lat,
			@PathVariable String lng, @PathVariable String salt, HttpSession session) throws JSONException {

		JSONObject obj = new JSONObject();
		ApiModel ap = new ApiModel();
		// kiem tra salt tu clien
		String clientSalt = salt;
		boolean checkSalt = new ApiModel().checkSaltPass("updateLocation", username, clientSalt);
		if (checkSalt) {
			TrackerModelMongoDB tm = new TrackerModelMongoDB();
			boolean resultUpdate = tm.updateLatLng(username, lat, lng);
			if (resultUpdate) {
				obj = ap.resultRespone("sucess", "Update success");
			} else {
				obj = ap.resultRespone("failed", "Cannot update in database");
			}
		} else {
			session.setAttribute("username", username);
			obj = ap.resultRespone("failed", "Salt incorrect");
		}
		String str = obj.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API tra ve danh sach cac user va vi tri trong csdl
	@RequestMapping(value = "/getAllUser/username={username}&salt={salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getAllUser(Model model, HttpSession session, HttpServletRequest request,
			@PathVariable String username, @PathVariable String salt) throws JSONException {

		// kiem tra salt tu client
		String clientSalt = salt;
		boolean checkSalt = new ApiModel().checkSalt("getAllUser", username, clientSalt);

		String str;
		if (checkSalt) {
			DBCursor db = new TrackerModelMongoDB().queryAllUser();
			List<DBObject> list = db.toArray();
			str = list.toString();
		} else {
			JSONObject js = new ApiModel().resultRespone("failed", "cannot retrieve data");
			str = js.toString();
		}

		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

}
