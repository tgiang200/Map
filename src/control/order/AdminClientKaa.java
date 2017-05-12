package control.order;


import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.kaaproject.kaa.common.dto.ApplicationDto;
import org.kaaproject.kaa.common.dto.EndpointGroupDto;
import org.kaaproject.kaa.common.dto.EndpointProfileSchemaDto;
import org.kaaproject.kaa.common.dto.NotificationDto;
import org.kaaproject.kaa.common.dto.NotificationSchemaDto;
import org.kaaproject.kaa.common.dto.NotificationTypeDto;
import org.kaaproject.kaa.common.dto.ProfileFilterDto;
import org.kaaproject.kaa.common.dto.ProfileFilterRecordDto;
import org.kaaproject.kaa.common.dto.TopicDto;
import org.kaaproject.kaa.common.dto.TopicTypeDto;
import org.kaaproject.kaa.common.dto.UpdateStatus;
import org.kaaproject.kaa.server.common.admin.AdminClient;

import Decoder.BASE64Encoder;

public class AdminClientKaa {
	private  static String hostIP = "192.168.43.133";
	private static String applicationToken = "11067412692148090898";
	private static String urlREST = "http://192.168.43.135:8008/user/";
//	private static String notificationResource1 = "{\"alertMessage\":\"Hello\"}";
	private static String id = "2";
	private static String customerAdd = "3";
	private static String producerAdd = "4";
	private static String type= "5";
	private static String measure = "6";
	private static long distance = 7;
	private static long shippingPrice = 8;
	private static String discribe = "9";
	
	private static String contentNoti = "{\"id\":\""+id+"\",\"customerAdd\":\""+customerAdd+"\",\"producerAdd\":\""+producerAdd+"\","
			+ "\"type\":\""+type+"\",\"measure\":\""+measure+"\",\"distance\":"+distance+",\"shippingPrice\":"+shippingPrice+",\"discribe\":\""+discribe+"\"}";
	public static void main(String[] args){
		try {
			AdminClientKaa client1 = new AdminClientKaa();
			AdminClient client = new AdminClient(hostIP, 8080);
			client.login("devuser", "devuser123");
			String r = new AdminClientKaa().sendGet(urlREST+"B1208725");
			String h = client1.getHeader(r);
			String end = client1.getEndpointKeyHash(h);
			System.out.println(end);
			System.out.println(r);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void createGroup(String groupName) throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<EndpointGroupDto> endpointGroups = client.getEndpointGroupsByAppToken(applicationToken);
		int i = endpointGroups.get(endpointGroups.size()-1).getWeight();
		EndpointGroupDto endpointGroupDto = new EndpointGroupDto();
		endpointGroupDto.setApplicationId(getApplicationId());
		endpointGroupDto.setName(groupName);
		endpointGroupDto.setDescription("");
		endpointGroupDto.setWeight(i+1);
		client.editEndpointGroup(endpointGroupDto);
		createTopicNoti(groupName);
		createProfileFilter(groupName);
		List<TopicDto> topics = client.getTopicsByApplicationToken(applicationToken);
		String topicID = topics.get(topics.size()-1).getId();
		client.addTopicToEndpointGroup(getEndpointGroupID(), topicID);
	}
	public void createProfileFilter(String groupName) throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<EndpointProfileSchemaDto> profileSchemas = client.getProfileSchemas(applicationToken);
		ProfileFilterDto profileFilter = new ProfileFilterDto();
		profileFilter.setApplicationId(getApplicationId());
		profileFilter.setEndpointProfileSchemaId(profileSchemas.get(3).getId());
		profileFilter.setEndpointGroupId(getEndpointGroupID());
		profileFilter.setDescription("");
		profileFilter.setBody("(workingPlace != null) and workingPlace.equals(\""+groupName+"\")");
		profileFilter.setStatus(UpdateStatus.INACTIVE);
		client.editProfileFilter(profileFilter);
		List<ProfileFilterRecordDto> list = client.getProfileFilterRecords(getEndpointGroupID(), true);
		String profileFilterId = list.get(0).getInactiveStructureDto().getId();
		client.activateProfileFilter(profileFilterId);
	}
	public void createTopicNoti(String groupName) throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		TopicDto topicDto = new TopicDto();
		topicDto.setApplicationId(getApplicationId());
		topicDto.setName(groupName);
		topicDto.setType(TopicTypeDto.MANDATORY);
		topicDto.setDescription("");
		client.createTopic(topicDto);
	}
	public String getEndpointGroupID() throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<EndpointGroupDto> endpointGroups = client.getEndpointGroupsByAppToken(applicationToken);
		String id = endpointGroups.get((endpointGroups.size()-1)).getId();
		return id;
	}
	public void sendNotificationGroup(int groupId, String content) throws Exception{
		
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");	
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setApplicationId(getApplicationId());
		notificationDto.setSchemaId(getSchemasId());
		notificationDto.setNfVersion(4);
		notificationDto.setTopicId(getTopicByGroup(groupId));
		notificationDto.setType(NotificationTypeDto.USER);
		client.sendNotification(notificationDto, "notification", content);
		
	}
	public void sendAllNotification(String content) throws Exception{
		
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");	
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setApplicationId(getApplicationId());
		notificationDto.setSchemaId(getSchemasId());
		notificationDto.setNfVersion(4);
		notificationDto.setTopicId(getTopicMandatoryId());
		notificationDto.setType(NotificationTypeDto.USER);
		client.sendNotification(notificationDto, "notification", content);
		
	}
	public void sendUnicastNotification(String userName, String content) throws Exception{
		
		String jsonArr = sendGet(urlREST+userName);
		String clientKeyHash = getEndpointKeyHash(getHeader(jsonArr));
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		NotificationDto notificationDto = new NotificationDto();
		notificationDto.setApplicationId(getApplicationId());
		notificationDto.setSchemaId(getSchemasId());
		notificationDto.setNfVersion(4);
		notificationDto.setTopicId(getTopicMandatoryId());
		notificationDto.setType(NotificationTypeDto.USER);
		
		client.sendUnicastNotification(notificationDto, clientKeyHash, "notification", content);
		
	}
//	public String sendGet(String url) throws Exception{
//		
//		URL url1 = new URL(url);
//		HttpURLConnection conn = (HttpURLConnection) url1.openConnection();
//		conn.setRequestMethod("GET");
//		conn.setRequestProperty("Accept", "application/json");
//		if (conn.getResponseCode() != 200) {
//			throw new RuntimeException("Failed : HTTP error code : "
//					+ conn.getResponseCode());
//		}
//		BufferedReader br = new BufferedReader(new InputStreamReader(
//			(conn.getInputStream())));
//		
//		String output;
//		String jsonArr = "";
//		while ((output = br.readLine()) != null) {
//			jsonArr+=output;
//		}
//		return jsonArr;
//	}
//	
	public String sendGet(String strUrl) {
		String result = "";
		try {
			URL url = new URL(strUrl);
			byte[] auth = "user1:password1".getBytes();
			String encoding = new BASE64Encoder().encode(auth);

			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");
			connection.setDoOutput(true);
			connection.setConnectTimeout(30000);
			connection.setRequestProperty("Authorization", "Basic " + encoding);
			InputStream content = (InputStream) connection.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(content));
			String line;
			while ((line = in.readLine()) != null) {
				result = result + line;
				// System.out.println(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		//JSONArray array = new JSONArray(result);
		
		return result;
	}
	public String getHeader(String jsonArr) throws ParseException{
		
		JSONParser parser = new JSONParser();
		JSONArray jA = (JSONArray) parser.parse(jsonArr);
		JSONObject jO = (JSONObject) jA.get(0);
		String header = (String) jO.get("header");
		
		return "["+header+"]";
	}
	public String getEndpointKeyHash(String jsonArr) throws ParseException{
		
		JSONParser parser = new JSONParser();
		JSONArray jA = (JSONArray) parser.parse(jsonArr);
		JSONObject jO = (JSONObject) jA.get(0);
		JSONObject jOEndpointKeyHash = (JSONObject) jO.get("endpointKeyHash");
		String endpointKeyHash = (String) jOEndpointKeyHash.get("string");
		
		return endpointKeyHash;
	}
	public String getTopicMandatoryId() throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<TopicDto> topics = client.getTopicsByApplicationToken(applicationToken);
		String id = topics.get(0).getId();
		return id;
	}
	public String getTopicByGroup(int groupID) throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<EndpointGroupDto> endpointGroups = client.getEndpointGroupsByAppToken(applicationToken);
		String endpointGroupId = endpointGroups.get((groupID)).getId();
		List<TopicDto> topics = client.getTopicsByEndpointGroupId(endpointGroupId);
		String id = topics.get(0).getId();
		return id;
	}
//	public String getTopicOptionalId() throws Exception{
//		AdminClient client = new AdminClient("192.168.1.86", 8080);
//		client.login("devuser", "devuser123");
//		List<TopicDto> topics = client.getTopicsByApplicationToken(applicationToken);
//		String id = topics.get(1).getId();
//		return id;
//	}
	public String getApplicationId() throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		ApplicationDto app =  client.getApplicationByApplicationToken(applicationToken);
		String id = app.getId();
		return id;
	}
	public String getSchemasId() throws Exception{
		AdminClient client = new AdminClient(hostIP, 8080);
		client.login("devuser", "devuser123");
		List<NotificationSchemaDto> schemas = client.getNotificationSchemasByAppToken(applicationToken);
		String id = schemas.get(3).getId();
		return id;
	}
	
}
