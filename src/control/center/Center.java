package control.center;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.producer.ProducerModel;

@Controller
@RequestMapping(value ="/center")
public class Center {
	@RequestMapping(value = "/listConfirmProducer")
	public String listConfirmProducer(Model model){
		DBCursor cursor = new ProducerModel().listConfirm();
		List<DBObject> list = cursor.toArray();
		String listProducer = list.toString();
		model.addAttribute("listProducer", listProducer);
		return "center/listConfirmProducer";
	}
}
