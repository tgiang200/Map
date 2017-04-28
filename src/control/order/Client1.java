//package control.order;
//
//import java.io.BufferedReader;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//import java.util.List;
//
//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;
//import org.json.simple.parser.JSONParser;
//import org.json.simple.parser.ParseException;
//import org.kaaproject.kaa.common.dto.ApplicationDto;
//import org.kaaproject.kaa.common.dto.NotificationDto;
//import org.kaaproject.kaa.common.dto.NotificationSchemaDto;
//import org.kaaproject.kaa.common.dto.NotificationTypeDto;
//import org.kaaproject.kaa.common.dto.TopicDto;
//import org.kaaproject.kaa.server.common.admin.AdminClient;
//
//import org.slf4j.LoggerFactory;
//import ch.qos.logback.classic.Level;
//import ch.qos.logback.classic.Logger;
//
//public class Client1 {
//	private static String hostIP = "192.168.3.135";
//	private static String applicationToken = "18693008741969774929";
//	private String urlREST = "http://http://" + hostIP + ":8008/user/";
//	
//	// private static String notificationResource1 =
//	// "{\"alertMessage\":\"Hello\"}";
//	// private static String notificationResource2 =
//	// "{\"_id\":\"1\",\"customerAddress\":\"vanh
//	// dai\",\"type\":\"user\",\"distance\":\"2km\",\"meansure\":\"no\",\"shippingPrice\":\"ship\",\"producerAddress\":\"no\",\"discribe\":\"don
//	// hang la\"}";
//
//	public static void main(String[] args) {
//		try {
//			Client1 client1 = new Client1();
//			client1.sendAllNotification("12", "22", "32", "42", "52", 6, 7, "82");
//			
//			// AdminClient client = new AdminClient(hostIP, 8080);
//			// client.login("devuser", "devuser123");
//			// List<ApplicationDto> apps = client.getApplications();
//			// System.out.println(apps);
//			// NotificationDto notification = new NotificationDto();
//			// notification.setApplicationId(client1.getApplicationId());
//			// notification.setSchemaId(client1.getSchemasId());
//			// notification.setNfVersion(2);
//			// notification.setTopicId(client1.getTopicMandatoryId());
//			// notification.setType(NotificationTypeDto.USER);
//			// client.sendUnicastNotification(notification, clientKeyHash,
//			// "notification", notificationResource2);
//			//
//			// AdminClient client = new AdminClient(hostIP, 8080);
//			// client.login("devuser", "devuser123");
//
//			// NotificationDto notification =
//			// {"applicationId":"65536","schemaId":"65541","topicId":"32768","type":"USER"};
//			// String notificationResource =
//			// "{\"alertMessage\":\""+content+"\"}";
//
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	public void sendAllNotification(String id, String customerAdd, String producerAdd, String type, String measure,
//			long i, long j, String discribe) {
//		try {
//			AdminClient client = new org.kaaproject.kaa.server.common.admin.AdminClient(hostIP, 8080);
//			client.login("devuser", "devuser123");
//			NotificationDto notification = new NotificationDto();
//			notification.setApplicationId(getApplicationId());
//			notification.setSchemaId(getSchemasId());
//			notification.setNfVersion(2);
//			notification.setTopicId(getTopicMandatoryId());
//			notification.setType(NotificationTypeDto.USER);
//			String content = "{\"id\":\"" + id + "\",\"customerAdd\":\"" + customerAdd + "\",\"producerAdd\":\""
//					+ producerAdd + "\"," + "\"measure\":\"" + measure + "\",\"type\":\"" + type + "\",\"distance\":"
//					+ i + ",\"shippingPrice\":" + j + ",\"discribe\":\"" + discribe + "\"}";
//			client.sendNotification(notification, "notification", content);
//			System.out.println("Send........................................");
//			
//		} catch (Exception ex) {
//
//		}
//	}
//
//	public void sendUnicastNotification(String userName, String id, String customerAdd, String producerAdd, String type,
//			String measure, long distance, long shippingPrice, String discribe) throws Exception {
//
//		String jsonArr = sendGet(urlREST + userName);
//		String clientKeyHash = getEndpointKeyHash(getHeader(jsonArr));
//		AdminClient client = new AdminClient(hostIP, 8080);
//		client.login("devuser", "devuser123");
//		NotificationDto notification = new NotificationDto();
//		notification.setApplicationId(getApplicationId());
//		notification.setSchemaId(getSchemasId());
//		notification.setNfVersion(2);
//		notification.setTopicId(getTopicMandatoryId());
//		notification.setType(NotificationTypeDto.USER);
//		String content = "{\"id\":\"" + id + "\",\"customerAdd\":\"" + customerAdd + "\",\"producerAdd\":\""
//				+ producerAdd + "\"," + "\"measure\":\"" + measure + "\",\"type\":\"" + type + "\",\"distance\":"
//				+ distance + ",\"shippingPrice\":" + shippingPrice + ",\"discribe\":\"" + discribe + "\"}";
//		client.sendUnicastNotification(notification, clientKeyHash, "notification", content);
//
//	}
//
//	public String sendGet(String url) throws Exception {
//
//		URL url1 = new URL(url);
//		HttpURLConnection conn = (HttpURLConnection) url1.openConnection();
//		conn.setRequestMethod("GET");
//		conn.setRequestProperty("Accept", "application/json");
//		if (conn.getResponseCode() != 200) {
//			throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
//		}
//		BufferedReader br = new BufferedReader(new InputStreamReader((conn.getInputStream())));
//
//		String output;
//		String jsonArr = "";
//		while ((output = br.readLine()) != null) {
//			jsonArr += output;
//		}
//		return jsonArr;
//	}
//
//	public String getHeader(String jsonArr) throws ParseException {
//
//		JSONParser parser = new JSONParser();
//		JSONArray jA = (JSONArray) parser.parse(jsonArr);
//		JSONObject jO = (JSONObject) jA.get(0);
//		String header = (String) jO.get("header");
//
//		return "[" + header + "]";
//	}
//
//	public String getEndpointKeyHash(String jsonArr) throws ParseException {
//
//		JSONParser parser = new JSONParser();
//		JSONArray jA = (JSONArray) parser.parse(jsonArr);
//		JSONObject jO = (JSONObject) jA.get(0);
//		JSONObject jOEndpointKeyHash = (JSONObject) jO.get("endpointKeyHash");
//		String endpointKeyHash = (String) jOEndpointKeyHash.get("string");
//
//		return endpointKeyHash;
//	}
//
//	public String getTopicMandatoryId() throws Exception {
//		AdminClient client = new AdminClient(hostIP, 8080);
//		client.login("devuser", "devuser123");
//		List<TopicDto> topics = client.getTopicsByApplicationToken(applicationToken);
//		String id = topics.get(0).getId();
//		return id;
//	}
//
//	public String getTopicOptionalId() throws Exception {
//		AdminClient client = new AdminClient("192.168.1.86", 8080);
//		client.login("devuser", "devuser123");
//		List<TopicDto> topics = client.getTopicsByApplicationToken(applicationToken);
//		String id = topics.get(1).getId();
//		return id;
//	}
//
//	public String getApplicationId() throws Exception {
//		AdminClient client = new AdminClient(hostIP, 8080);
//		client.login("devuser", "devuser123");
//		ApplicationDto app = client.getApplicationByApplicationToken(applicationToken);
//		String id = app.getId();
//		return id;
//	}
//
//	public String getSchemasId() throws Exception {
//		AdminClient client = new AdminClient(hostIP, 8080);
//		client.login("devuser", "devuser123");
//		List<NotificationSchemaDto> schemas = client.getNotificationSchemasByAppToken(applicationToken);
//		String id = schemas.get(4).getId();
//		return id;
//	}
//
//}
