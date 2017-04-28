package control.tracker;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.api.ApiModel;
import control.order.OrderModel;
import control.shipper.ShipperModel;

@Controller
@RequestMapping(value = "/tracker")
public class TrackerControl {

	// ham chuyen den trang lay vi tri hien tai
	@RequestMapping(value = "/shareLocation")
	public String getLocation(HttpSession session) {
		// kiem tra user neu chua dang nhap thi chuyen ve trang dang nhap
		// System.out.println("user: "+session.getAttribute("username")+" this
		// null");
		if ((session.getAttribute("username")) == null) {
			return "login/loginForm";
		}
		return "tracker/getLocation";
	}

	// Tra ve trang mapTracker hien thi ban do
	@RequestMapping(value = "/mapLocation")
	public String mapLocation(Model model, HttpServletRequest request, HttpServletResponse res, HttpSession session) {
		// Nhan toa do tu xac nhan cua nguoi dung
		String strLat = request.getParameter("lat");
		String strLng = request.getParameter("lng");
		// Goi toa do sang trang hien thi
		model.addAttribute("lat", strLat);
		model.addAttribute("lng", strLng);
		return "tracker/map";
	}

	// Tra ve trang mapTracker hien thi ban do
	@RequestMapping(value = "/showMap")
	public String getPosition(Model model, HttpServletRequest request, HttpServletResponse res, HttpSession session) {
		// Nhan toa do tu xac nhan cua nguoi dung
		String strLat = request.getParameter("lat") + "";
		String strLng = request.getParameter("lng") + "";
		TrackerModelMongoDB trackerModel = new TrackerModelMongoDB();
		boolean resultUpdate = trackerModel.updateLatLng(session.getAttribute("username") + "", strLat, strLng);

		// Goi toa do sang trang hien thi
		model.addAttribute("lat", strLat);
		model.addAttribute("lng", strLng);

		return "tracker/mapTracker";
		// return "homepage";
	}

	@RequestMapping(value = "/mapTracker")
	public String mapTracker(Model model) {
		model.addAttribute("lat", 10.030901);
		model.addAttribute("lng", 105.768846);
		// return "tracker/mapTracker";
		return "tracker/mapTracker";
	}

	@RequestMapping(value = "/trackUser/username={username}")
	public String mapTrackerUser(Model model, @PathVariable String username) throws JSONException {
		// Lay vi tri user de khoi tap center cua Map
		JSONArray array = new ApiModel().getUserKaa(username);
		JSONObject obj = new JSONObject(array.get(array.length() - 1).toString());
		double lat = obj.getJSONObject("event").getDouble("lat");
		double lng = obj.getJSONObject("event").getDouble("lng");

		model.addAttribute("username", username);
		model.addAttribute("lat", lat);
		model.addAttribute("lng", lng);
		// System.out.println(username);
		// return "tracker/mapTracker";
		return "tracker/trackingUserKaa";
	}

	@RequestMapping(value = "/road")
	public String findRoad(Model model) {
		model.addAttribute("lat", 10.030901);
		model.addAttribute("lng", 105.768846);
		// return "tracker/mapTracker";
		return "road/findRoad";
	}

	// Danh sach user tracking
	@RequestMapping(value = "/listUserTracking")
	public String listUserTracking(Model model, HttpSession session) throws JSONException {
		if (session.getAttribute("userType").toString().equals("center")) {
			// JSONArray list = new ApiModel().getListUserKaa();
			DBCursor cursor = new ShipperModel().queryAllShipper();
			List<DBObject> list = cursor.toArray();
			model.addAttribute("list", list);
		} else {
			JSONArray list = new OrderModel().getShipperOfProducer(session.getAttribute("username").toString());
			model.addAttribute("list", list);
		}
		model.addAttribute("lat", 10.030901);
		model.addAttribute("lng", 105.768846);
		return "tracker/listUserTracking";
	}

	/*
	 * //API tra ve danh sach cac user trong csdl
	 * 
	 * @RequestMapping(value = "/getAllUser", method = RequestMethod.GET,
	 * produces = "application/json")
	 * 
	 * @ResponseBody public ResponseEntity<String> getAllUser(Model model)
	 * throws JSONException {
	 * 
	 * //Mysql //JSONArray js = new TrackerModel().showAllMarkerJson(); //String
	 * str = js.toString();
	 * 
	 * //mongoDB DBCursor db = new TrackerModelMongoDB().queryAllUser();
	 * List<DBObject> list=db.toArray(); String str = list.toString();
	 * 
	 * return new ResponseEntity<String>(str, HttpStatus.OK); }
	 * 
	 * //API cap nhat vi tri cua user
	 * 
	 * @RequestMapping(value =
	 * "/updateLocationAPI/user={user}&lat={lat}&lng={lng}/", method =
	 * RequestMethod.GET, produces = "application/json")
	 * 
	 * @ResponseBody public ResponseEntity<String> updateLocationAPI(Model
	 * model, @PathVariable String user,
	 * 
	 * @PathVariable String lat, @PathVariable String lng){
	 * 
	 * boolean resultUpdate = new TrackerModelMongoDB().updateLatLng(user, lat,
	 * lng); String str; if (resultUpdate){ str = "true"; } else { str =
	 * "false"; } System.out.println(str); return new
	 * ResponseEntity<String>(str, HttpStatus.OK); }
	 * 
	 */
	@RequestMapping(value = "testPost")
	public void testPost(Model model, HttpServletRequest request) {
		String str = request.getParameter("test");
		System.out.println("String " + str);
	}
}
