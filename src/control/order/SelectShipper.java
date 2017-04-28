package control.order;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.test.context.web.WebAppConfiguration;

import com.mongodb.DBCursor;

@WebAppConfiguration
public class SelectShipper extends Thread{
	String orderID;
	boolean result = false;
	JSONArray listOnwork = new JSONArray();
	SelectShipper(){
		
	}
	SelectShipper(String orderID){
		this.orderID=orderID;
	}
	public void run(){
		DBCursor cursor = new OrderModel().queryOrder(orderID); 
		JSONObject order = new JSONObject();
		OrderModel orderModel = new OrderModel();
		while (cursor.hasNext()){
			try {
				order = new JSONObject(cursor.next().toString());
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		try {
			int numShipper;
			int timeSend = 0; //so lan goi order cho shipper
			double radiusFind = 1; //ban kinh tim shipper km
			while (true){
				// New da ton tai shipper trong don hang
//				if (orderModel.verifyShipperOrder(orderID)){
//					System.out.print("Da chon shipper cho don hang");
//					break;
//				} else {
//					String strLat = order.getJSONObject("producer").getString("lat");
//					String strLng = order.getJSONObject("producer").getString("lng");
//					listOnwork = orderModel.getListShipper(strLat, strLng, radiusFind);
//					timeSend = timeSend+1;
//					if ((timeSend%5==0)&&(radiusFind<5)){
//						radiusFind=radiusFind+0.5; //tang ban kinh do tim len 500m , toi da 5km
//					}
//					numShipper = new Random().nextInt(listOnwork.length()+1) - 1;
//					if (!listOnwork.isNull(numShipper)){
//						// Send message den shipper
//						String message = "Da goi yeu cau van chuyen don hang "+orderID+" den shipper "+listOnwork.getJSONObject(numShipper).getJSONObject("event").getString("username");
//						//new Message().sendMessage(message);
//						new Message().sendOrder(order.get("_id").toString(), order.getString("customerAddress"), order.getString("address"), 
//								order.getString("type"), order.getString("meansure"), Long.parseLong(order.getString("distance")), Long.parseLong(order.getString("price")), order.getString("discribe"));
//					} else {
//						System.out.println("No shipper near producer");
//					}
//				}
				long d = Long.parseLong(order.getString("distance"));
				long p = Long.parseLong(order.getString("shippingPrice"));
				String id = order.getJSONObject("_id").getString("$oid");
				String customerAdd = order.getString("customerAddress");
				String producerAdd = order.getJSONObject("producer").getString("address"); 
				String type = order.getString("type");
				String meansure = order.getString("meansure");  
				String discribe = order.getString("describe");
				
				//new Client1().sendAllNotification(id, customerAdd, producerAdd, type, meansure, d, p, discribe);
				//Client1 client1 = new Client1();
				//client1.sendAllNotification(id, customerAdd, producerAdd, type, meansure, d, p, discribe);
				
				Thread.sleep(60000); //Thoi gian cho phan hoi tu shipper
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
//		} catch (JSONException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	public static void main(String [] args){
		
	}
}
