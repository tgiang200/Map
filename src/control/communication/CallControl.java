package control.communication;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/call")
public class CallControl {
	@RequestMapping(value="/callPage")
	public String callPage(){
		return "communication-api/demo";
	}
}
