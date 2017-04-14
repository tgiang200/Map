package control.homepage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller(value = "/")
public class Homepage {
	@RequestMapping(value = "/homepage")
	public String homepage(){
		return "homepage";
	}
}
