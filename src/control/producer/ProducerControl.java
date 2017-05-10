package control.producer;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.api.ApiModel;
import control.api.Sha1Digest;
import control.login.LoginModel;
import control.login.SendSMS;

@Controller
@RequestMapping(value = "/producer")
public class ProducerControl {

	@RequestMapping(value = "/formRegister")
	public String formRegister() {
		return "producer/registerProducer";
	}

	@RequestMapping(value = "/register")
	public String registerProducer(Model model, HttpServletRequest request, HttpServletResponse respone)
			throws UnsupportedEncodingException, JSONException {
		request.setCharacterEncoding("UTF-8");
		String fullName = request.getParameter("fullname");
		String address = request.getParameter("address");
		String idCard = request.getParameter("idCard");
		String storeName = request.getParameter("storeName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String facebook = request.getParameter("facebook");
		String businessType = request.getParameter("businessType");
		// String password = request.getParameter("password");
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String status = "waiting";
		String groupID = request.getParameter("groupId");

		// tao password
		String password = new ApiModel().createCode();

		BasicDBObject producer = new BasicDBObject();

		producer.put("_id", phone);
		producer.put("fullname", fullName);
		producer.put("address", address);
		producer.put("idCard", idCard);
		producer.put("storeName", storeName);
		producer.put("phone", phone);
		producer.put("email", email);
		producer.put("facebook", facebook);
		producer.put("businessType", businessType);
		producer.put("password", password);
		producer.put("lat", lat);
		producer.put("lng", lng);
		producer.put("statusConfirm", status);
		producer.put("groupID", groupID);
		
		JSONObject SIP = new LoginModel().getAccountSIP();
		String SIPAccount = SIP.getString("account");
		
		producer.put("SIPAccount", SIPAccount);
		
		boolean resultInsert = new ProducerModel().insertProducer(producer);
		if (resultInsert) {
			// Goi password bang sms
			boolean b = new SendSMS().sendPasswordToSMS(phone, password);
			model.addAttribute("result", "Đăng kí thành công, đang chờ duyệt");
		} else {
			model.addAttribute("result", "Số điện thoại đã được sử dụng để đăng kí");
		}
		return "producer/resultRegister";
	}

	@RequestMapping(value = "/api/post")
	public ResponseEntity<String> registerProducerPost(HttpServletRequest request) {
		String producer = request.getParameter("producer");
		System.out.println(producer.toString());
		return new ResponseEntity<String>("success".toString(), HttpStatus.OK);
	}

	// API dang ki producer
	@RequestMapping(value = "/api/registerProducer/phone={phone}&fullname={fullname}&address={address}&idCard={idCard}&"
			+ "storeName={storeName}&email={email}&facebook={facebook}&businessType={businessType}&lat={lat}&lng={lng}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> apiRegister(Model model, HttpServletRequest request, @PathVariable String phone,
			@PathVariable String fullname, @PathVariable String address, @PathVariable String idCard,
			@PathVariable String storeName, @PathVariable String email, @PathVariable String facebook,
			@PathVariable String businessType, @PathVariable String lat, @PathVariable String lng) throws JSONException {
		String status = "waiting";
		JSONObject respone = new JSONObject();
		// // tao password
		// String password = new ApiModel().createCode();
		// // Goi password bang sms
		// String phoneVN = "+" + phone;
		// phoneVN = phoneVN.replace("+0", "+84"); // doi dau so dien thoai sang
		// +84
		// boolean resultSendSMS = new ProducerModel().sendSMS(phoneVN,
		// password);
		// if (resultSendSMS) {
		BasicDBObject producer = new BasicDBObject();

		producer.put("_id", phone);
		producer.put("fullname", fullname);
		producer.put("address", address.replace("..", "/"));
		producer.put("idCard", idCard);
		producer.put("storeName", storeName);
		producer.put("phone", phone);
		producer.put("email", email);
		producer.put("facebook", facebook);
		producer.put("businessType", businessType);
		//producer.put("password", password);
		producer.put("lat", lat);
		producer.put("lng", lng);
		producer.put("statusConfirm", status);
		
		JSONObject SIP = new LoginModel().getAccountSIP();
		String SIPAccount = SIP.getString("account");
		
		producer.put("SIPAccount", SIPAccount);
		
		String password = new ApiModel().createCode();
		
		boolean result = new ProducerModel().insertProducer(producer);
		if (result) {
			// Goi password bang sms
			boolean b = new SendSMS().sendPasswordToSMS(phone, password);
			respone.put("result", "success");
			respone.put("message", "success");
			
		} else {
			respone.put("result", "failed");
			respone.put("message", "Phone is existing");
		}
		// } else {
		// respone.put("result", "failed");
		// respone.put("message", "Cannot send SMS");
		// }
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	// API tra ve danh sach cac producer va vi tri trong csdl
	@RequestMapping(value = "/post/api/registerProducer={producerStr}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<String> apiRegisterPost(Model model, @PathVariable String producerStr,
			HttpServletRequest request) throws JSONException {
		// JSONObject producerJson = (JSONObject)
		// request.getAttribute("producer");
		// DBObject dbObject = (DBObject) producerJson;
		// BasicDBObject producer = (BasicDBObject) dbObject;
		// String status = "waiting";
		// producer.put("_id", producer.get("phone"));
		// producer.put("status", status);
		JSONObject respone = new JSONObject();
		boolean result = true;// new ProducerModel().insertProducer(producer);
		if (result) {
			respone.put("result", producerStr);
		} else {
			respone.put("result", "failed");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	@RequestMapping(value = "/producerID={idProducer}")
	public String infoProducer(Model model, @PathVariable String idProducer) {
		ProducerModel producerModel = new ProducerModel();
		String statusConfirm = producerModel.getStatus(idProducer);
		if (statusConfirm.equals("waiting") || statusConfirm.equals("confirming")) {
			String phone = idProducer;
			// Lay thong tin producer duoc xac nhan
			DBCursor cursor = producerModel.queryProducer(phone);
			List<DBObject> list = cursor.toArray();
			String str = list.toString();
			model.addAttribute("producer", str);
			// Chuyển trạng thái xác nhận của producer sang "confirming"
			producerModel.updateStatusConfirm(phone, "confirming");
			// tra ve trang thong tin chi tiet de tien hanh xac nhan
			return "producer/infoProducer";
		} else {
			String phone = idProducer;
			// Lay thong tin producer duoc xac nhan
			DBCursor cursor = producerModel.queryProducer(phone);
			List<DBObject> list = cursor.toArray();
			String str = list.toString();
			model.addAttribute("producer", str);
			// Chuyen trang thai xac nhan cua producer sang "confirming"
			// producerModel.updateStatusConfirm(phone, "confirming");
			// tra ve trang thong tin chi tiet de tien hanh xac nhan
			return "producer/infoProducer";
		}
	}

	@RequestMapping(value = "/listConfirm")
	public String listConfirm(Model model, HttpServletRequest request, HttpServletResponse respone,
			HttpSession session) {
		// Kiem tra sesion
		boolean verify = new LoginModel().verifySessionCenter(session.getAttribute("userType").toString());
		if (!verify) {
			return "user/permissionDeny";
		}
		// Lay thong tin cac producer can duoc xac nhan
		DBCursor cursor = new ProducerModel().listConfirm();
		List<DBObject> list = cursor.toArray();
		String str = list.toString();
		model.addAttribute("producer", str);
		return "producer/listConfirmProducer";
	}

	@RequestMapping(value = "/listProducerConfirmed")
	public String listProducerConfirmed(Model model, HttpServletRequest request, HttpServletResponse respone,
			HttpSession session) {
		// Kiem tra sesion
		boolean verify = new LoginModel().verifySessionCenter(session.getAttribute("userType").toString());
		if (!verify) {
			return "user/permissionDeny";
		}

		// Lay thong tin cac producer can duoc xac nhan
		JSONArray list = new ProducerModel().queryProducerStatus("confirmed");
		String str = list.toString();
		model.addAttribute("producer", str);
		return "producer/listProducerConfirmed";
	}

	@RequestMapping(value = "/resultConfirm/action={action}&producerID={idProducer}")
	public String resultConfirm(Model model, @PathVariable String action, @PathVariable String idProducer,
			HttpSession session) {
		// Kiem tra sesion
		boolean verify = new LoginModel().verifySessionCenter(session.getAttribute("userType").toString());
		if (!verify) {
			return "user/permissionDeny";
		}
		String phone = idProducer;
		ProducerModel producerModel = new ProducerModel();
		// System.out.println(phone);
		if (action.equals("confirmed")) {
			// doi trang thai thanh da xac nhan
			producerModel.updateStatusConfirm(phone, "confirmed");
		} else if (action.equals("notConfirm")) {
			// doi trang thai thanh tu choi
			producerModel.updateStatusConfirm(phone, "notConfirm");
			producerModel.deleteProducer(idProducer);
		} else {
			// khi action la cancel thi tra ve trang thai dang cho xac nhan
			producerModel.updateStatusConfirm(phone, "waiting");
		}

		DBCursor cursor = producerModel.queryAllProducer();
		List<DBObject> list = cursor.toArray();
		String str = list.toString();
		model.addAttribute("producer", str);

		return "/producer/redirectListConfirm";
	}

	// API tra ve danh sach cac producer va vi tri trong csdl
	@RequestMapping(value = "/getAllProducer/{salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getAllProducer(Model model, @PathVariable String salt) throws NoSuchAlgorithmException {
		//kiem tra salt
		String verify = new Sha1Digest().sha1("getAllUser"+"1234");
		String str;
		if (verify.equals(salt)){
			DBCursor cursor = new ProducerModel().queryAllProducer();
			List<DBObject> list = cursor.toArray();
			str = list.toString();
		}
		else {
			str = null;
		};
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// Xem vi tri tat ca producer tren ban do
	@RequestMapping(value = "/mapProducer")
	public String mapProducer(Model model) {
		model.addAttribute("lat", 10.030901);
		model.addAttribute("lng", 105.768846);
		return "producer/mapProducer";
	}

	@RequestMapping(value = "createOrder")
	public String createOrder(Model model, HttpSession session) throws JSONException {
		// Kiem tra sesion
		boolean verify = new LoginModel().verifySessionProducer(session.getAttribute("userType").toString());
		if (!verify) {
			return "user/permissionDeny";
		}
		String producerID = (String) session.getAttribute("username");
		DBCursor cursor = new ProducerModel().queryProducer(producerID);
		JSONObject producer = new JSONObject();
		if (cursor.hasNext()) {
			producer = new JSONObject(cursor.next().toString());
			model.addAttribute("latProducer", producer.getString("lat"));
			model.addAttribute("lngProducer", producer.getString("lng"));
		}
		return "producer/createOrder";
	}

	@RequestMapping(value = "/update")
	public String updateProducer(Model model, HttpServletRequest request, HttpServletResponse respone,
			HttpSession session)throws UnsupportedEncodingException {
		// Kiem tra sesion
		boolean verify = new LoginModel().verifySessionProducer(session.getAttribute("userType").toString());
		if (!verify) {
			return "user/permissionDeny";
		}
		request.setCharacterEncoding("UTF-8");
		String fullName = request.getParameter("fullname");
		String address = request.getParameter("address");
		String idCard = request.getParameter("idCard");
		String storeName = request.getParameter("storeName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String facebook = request.getParameter("facebook");
		String businessType = request.getParameter("businessType");
		String password = request.getParameter("password");
		String lat = request.getParameter("lat");
		String lng = request.getParameter("lng");
		String status = "waiting";

		BasicDBObject producer = new BasicDBObject();

		producer.put("phone", phone);
		producer.put("fullname", fullName);
		producer.put("address", address);
		producer.put("idCard", idCard);
		producer.put("storeName", storeName);
		producer.put("email", email);
		producer.put("facebook", facebook);
		producer.put("businessType", businessType);
		producer.put("password", password);
		producer.put("lat", lat);
		producer.put("lng", lng);
		producer.put("statusConfirm", status);

		boolean resultInsert = new ProducerModel().updateProducer(producer, phone);
		if (resultInsert) {
			model.addAttribute("result", "Cập nhật thành công, đăng nhập lại để tiếp tục");
		} else {
			model.addAttribute("result", "Không thể cập nhật thông tin, vui lòng thử lại sau");
		}

		return "producer/resultRegister";
	}

}
