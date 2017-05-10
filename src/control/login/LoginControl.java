package control.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.DBCursor;

import control.api.ApiModel;
import control.producer.ProducerModel;
import control.shipper.ShipperModel;


@Controller
@RequestMapping(value = "/account")
public class LoginControl {
	@RequestMapping(value = "/loginForm")
	public String loginForm(){
		return "login/loginForm";
	}
	
	@RequestMapping(value = "/login")
	public String login(Model model, HttpServletRequest request, HttpServletResponse res, HttpSession session){
		
		//System.out.println("start....");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		
//		System.out.println(username);
//		System.out.println(password);
//		System.out.println(userType);
		boolean resultLogin = false;
		ApiModel ap = new ApiModel(); 
		if (userType.equals("center")){
			resultLogin = ap.login(username, password);
		}
		if (userType.equals("producer")){
			resultLogin = ap.loginProducer(username, password);
		}
		if (userType.equals("shipper")){
			resultLogin = ap.loginShipper(username, password);
		}
		// tao doi tuong json luu ket qua tra ve cho client
		JSONObject obj = new JSONObject();
		
		if (resultLogin) {
			session.setAttribute("username", username);
			session.setAttribute("userType", userType);
			session.setAttribute("password", password);
			return "login/loginSuccess";
		} else {
			model.addAttribute("message","<script>alert(\"Tài khoản hoặc mật khẩu không chính xác\");</script>");
			return "login/redirectLoginForm";
		}
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpSession session){
		session.removeAttribute("username");
		return "login/loginForm";
	}
	
	@RequestMapping (value="/forgotPassword/userType={userType}phone={phone}")
	public String forgotPassword(Model model, @PathVariable String phone, @PathVariable String userType){
		LoginModel l = new LoginModel();
		String mail="";
		if (userType.equals("producer")){
			DBCursor cursor = new ProducerModel().queryProducer(phone);
			if (cursor.hasNext()){
				mail=cursor.next().get("email").toString();
			}
		} 
		
		if (userType.equals("shipper")){
			DBCursor cursor = new ShipperModel().queryShipper(phone);
			if (cursor.hasNext()){
				mail=cursor.next().get("email").toString();
			}
		} 
		
		if (!mail.equals("")){
			String code = l.createCode();
			l.insertCode(phone, code);
			//l.sendMail(mail, code);
			model.addAttribute("result", "Mã xác nhận đã được gởi đến email");
		}
		return "login/inputCode";
	}
	
	//forgot password page
	@RequestMapping (value="forgotPassword")
	public String forgotForm(){
		return "login/forgotPassword";
	}
	
	
	// tạo code
	@RequestMapping(value="/getCodeEmail")
	public String getCodeEmail(Model model, HttpServletRequest request){
		LoginModel loginModel = new LoginModel();
		String phone = request.getParameter("username");
		String email = request.getParameter("email");
		String userType = request.getParameter("userType");
		//Kiem tra thong tin tai khoan co hop le hay khong
		boolean acc = loginModel.verifyPhoneEmail(phone, email, userType);
		if (acc){
			String code = loginModel.createCode();
			boolean sendMail = loginModel.sendMail(email, code);
			//loginModel.insertCode(phone, code);
			boolean updatePassword = loginModel.updatePassword(phone, code, userType);
			model.addAttribute("result", "Mật khẩu mới đã được gởi đến email của bạn");
			//model.addAttribute("phone", phone);
		} else {
			model.addAttribute("result", "Thông tin tài khoảng không chính xác");
		}
		return "login/resultGetNewPassword";
	}
	
	@RequestMapping(value="/getCodePhone")
	public String getCodePhone(Model model, HttpServletRequest request){
		LoginModel loginModel = new LoginModel();
		String phone = request.getParameter("username");
		//String email = request.getParameter("email");
		String userType = request.getParameter("userType");
		//Kiem tra thong tin tai khoan co hop le hay khong
		boolean acc = loginModel.verifyPhone(phone, userType);
		if (acc){
			String code = loginModel.createCode();
			boolean sendMail = new SendSMS().sendPasswordToSMS(phone, code);
			//loginModel.insertCode(phone, code);
			boolean updatePassword = loginModel.updatePassword(phone, code, userType);
			model.addAttribute("result", "Mật khẩu mới đã được gởi đến số điện thoại của bạn");
			//model.addAttribute("phone", phone);
		} else {
			model.addAttribute("result", "Thông tin tài khoảng không chính xác");
		}
		return "login/resultGetNewPassword";
	}
	
	
	@RequestMapping(value="/api/getCodePhone/userType={typeUser}&username={username}")
	@ResponseBody
	public ResponseEntity<String> getCodePhoneAPI(Model model, HttpServletRequest request, @PathVariable String typeUser,
			@PathVariable String username) throws JSONException{
		LoginModel loginModel = new LoginModel();
		String phone = username;
		String userType = typeUser;
		JSONObject respone = new JSONObject();
		//Kiem tra thong tin tai khoan co hop le hay khong
		boolean acc = loginModel.verifyPhone(phone, userType);
		if (acc){
			String code = loginModel.createCode();
			boolean sendMail = new SendSMS().sendPasswordToSMS(phone, code);
			boolean updatePassword = loginModel.updatePassword(phone, code, userType);
			respone.put("result", "success");
			respone.put("message","success");
			
		} else {
			respone.put("result", "failed");
			respone.put("message","phone not exist");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}
	
	// kiểm tra code
	@RequestMapping (value="/verifyCode/phone={phone}&code={code}")
	public String verifyCode(Model model, @PathVariable String phone, @PathVariable String code){
		LoginModel l = new LoginModel();
		boolean verifyCode = l.verifyCode(phone, code);
		if (verifyCode){
			model.addAttribute("result", "Đăng kí thành công! Đang chờ duyêt");
			l.deleteCode(phone);
			return "login/loginForm";
		} else {
			model.addAttribute("result", "success");
			model.addAttribute("message", "Mã xác nhận không đúng");
			model.addAttribute("phone", phone);
			return "producer/resultRegister";
		}
	}
}
