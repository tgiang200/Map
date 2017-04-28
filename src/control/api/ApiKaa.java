package control.api;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/apiKaa")
public class ApiKaa {

	// API tra ve danh sach cac user va vi tri trong csdl
	@RequestMapping(value = "/getUserTrack/{username}/{salt}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getUserTrack(Model model, HttpSession session, HttpServletRequest request,
			@PathVariable String username, @PathVariable String salt) throws NoSuchAlgorithmException {
		
		String verify = new Sha1Digest().sha1("getUserTrack"+"1234");
		String str;
		if (verify.equals(salt)){
			// Goi ham getUser tu model: getUserKaaApi() || getUserKaa()
			JSONArray jsonArray = new ApiModel().getUserKaa(username);
			// List<DBObject> list = db.toArray();
			str = jsonArray.toString();
		} else {
			str= null;
		}
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API tra ve danh sach cac user va vi tri trong csdl
	@RequestMapping(value = "/geAlltUserTrack", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getAllUserTrack(Model model) {
		JSONArray jsonArray = new ApiModel().getAllUserKaaApi();
		// List<DBObject> list = db.toArray();
		String str = jsonArray.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}

	// API tra ve danh sach cac user va vi tri trong csdl
	@RequestMapping(value = "/getUserTrackApi/{username}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> getAllUserTrackApi(Model model, HttpSession session, HttpServletRequest request,
			@PathVariable String username) throws IOException {
		JSONArray jsonArray = new ApiModel()
				.readJsonFromUrl("http://localhost:8080/Map/apiKaa/getUserTrack/" + username);
		String str = jsonArray.toString();
		return new ResponseEntity<String>(str, HttpStatus.OK);
	}
}
