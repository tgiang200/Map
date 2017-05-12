package control.communication;

import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mongodb.DBCursor;

@Controller
@RequestMapping(value = "/call")
public class CallControl {
	@RequestMapping(value="/callPage")
	public String callPage(Model model, HttpSession session) throws JSONException{
		String userType = session.getAttribute("userType").toString();
		String name = session.getAttribute("username").toString();
		//JSONObject acc = new CallModel().getSIPAccount(userType, name);
		//String SIPUsername = acc.getString("");
		String SIPAcc = new CallModel().getSIPAccount(userType, name);
		model.addAttribute("SIPUsername", SIPAcc);
		model.addAttribute("SIPPasswork", SIPAcc+SIPAcc);
		return "communication-api/demo";
	}
}
