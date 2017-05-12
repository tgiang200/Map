package control.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.order.OrderModel;
import control.producer.ProducerModel;
import control.shipper.ShipperModel;
import control.tracker.TrackerModelMongoDB;
import mongo.database.ConnectMongo;

@Controller
@RequestMapping(value="/user")
public class User {
	@RequestMapping(value="/userType={userType}&username={username}")
	public String infoUser(Model model, @PathVariable String username,@PathVariable String userType) throws JSONException{
		if (userType.equals("center")){
			model.addAttribute("user", username);
			return "user/infoCenter";
		}
		if (userType.equals("producer")){
			DBCursor cursor= new ProducerModel().queryProducer(username);
			if(cursor.hasNext()){
				JSONObject obj = new JSONObject(cursor.next().toString());
				model.addAttribute("phone", obj.getString("phone"));
				model.addAttribute("idCard", obj.getString("idCard"));
				model.addAttribute("email", obj.getString("email"));
				model.addAttribute("fullname", obj.getString("fullname"));
				model.addAttribute("address", obj.getString("address"));
				//model.addAttribute("dateOfBirth", obj.getString("dateOfBirth"));
				model.addAttribute("storeName", obj.getString("storeName"));
				model.addAttribute("facebook", obj.getString("facebook"));
				model.addAttribute("businessType", obj.getString("businessType"));
				model.addAttribute("password", obj.getString("password"));
				model.addAttribute("lat", obj.getString("lat"));
				model.addAttribute("lng", obj.getString("lng"));
			}
			return "user/infoProducer";
		}
		
		if (userType.equals("shipper")){
			DBCursor cursor= new ShipperModel().queryShipper(username);
			if(cursor.hasNext()){
				JSONObject obj = new JSONObject(cursor.next().toString());
				model.addAttribute("phone", obj.getString("phone"));
				model.addAttribute("email", obj.getString("email"));
				model.addAttribute("fullname", obj.getString("fullname"));
				model.addAttribute("address", obj.getString("address"));
				model.addAttribute("idCard", obj.getString("idCard"));
				model.addAttribute("dateOfBirth", obj.getString("dateOfBirth"));
				model.addAttribute("facebook", obj.getString("facebook"));
				model.addAttribute("vehicle", obj.getString("vehicle"));
				model.addAttribute("vehicleNumber", obj.getString("vehicleNumber"));
				//model.addAttribute("convey", obj.getString("convey"));
				model.addAttribute("password", obj.getString("password"));
				model.addAttribute("funds", obj.getString("funds"));
				return "user/infoShipper";
			}
		}
		return "login/loginForm";
	}
	
	@RequestMapping (value="/search") 
	public String search(Model model, HttpServletRequest request){
		String keyword = request.getParameter("keyword");
		JSONArray prodcuer = new ProducerModel().searchProducer(keyword);
		JSONArray shipper = new ShipperModel().searchShipper(keyword);
		JSONArray order = new OrderModel().searchOrder(keyword);
		model.addAttribute("producer", prodcuer.toString());
		model.addAttribute("shipper", shipper.toString());
		model.addAttribute("order", order.toString());
		System.out.println(order);
		return "search/resultSearch";
	}
	
	public boolean verifySessionCenter(String ss){
		if (ss.equals("center")){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifySessionProducerCenter(String ss){
		if (ss.equals("producer")||ss.equals("center")){
			return true;
		} else {
			return false;
		}
	}
	
	public boolean verifySessionShipper(String ss){
		if (ss.equals("shipper")){
			return true;
		} else {
			return false;
		}
	}
	

}
