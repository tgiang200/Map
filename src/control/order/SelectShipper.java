package control.order;

import java.util.Random;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.mongodb.DBCursor;

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
			while (true){
				// New da ton tai shipper trong don hang
				if (orderModel.verifyShipperOrder(orderID)){
					System.out.print("Da chon shipper cho don hang");
					break;
				} else {
					String strLat = order.getJSONObject("producer").getString("lat");
					String strLng = order.getJSONObject("producer").getString("lng");
					listOnwork = orderModel.getListShipper(strLat, strLng);
					numShipper = new Random().nextInt(listOnwork.length()+1) - 1;
					if (!listOnwork.isNull(numShipper)){
						// Send message den shipper
						String message = "Da goi yeu cau van chuyen don hang "+orderID+" den shipper "+listOnwork.getJSONObject(numShipper).getJSONObject("event").getString("username");
						new Message().sendMessage(message);
					} else {
						System.out.println("No shipper near producer");
					}
				}
				
				Thread.sleep(10000); //Thoi gian cho phan hoi tu shipper
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void main(String [] args){
		
	}
}
