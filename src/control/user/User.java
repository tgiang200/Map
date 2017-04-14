package control.user;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.tracker.TrackerModelMongoDB;

@Controller
@RequestMapping(value="/user")
public class User {
	@RequestMapping(value="/{username}")
	public String infoUser(Model model, @PathVariable String username){
		//String username="user1";
		DBCursor cursor = new TrackerModelMongoDB().queryUser(username);
		List<DBObject> list = cursor.toArray();
		String str = list.toString();
		model.addAttribute("user", str);
		return "user/infoUser";
	}
}
