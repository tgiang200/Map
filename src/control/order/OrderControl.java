package control.order;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;

import control.producer.ProducerModel;
import control.shipper.ShipperModel;
import control.user.User;

@Controller
@RequestMapping(value = "/order")
public class OrderControl {

	@RequestMapping(value = "/createOrder")
	public String createOrder(Model model, HttpServletRequest request, HttpSession session) 
							throws UnsupportedEncodingException {
		request.setCharacterEncoding("UTF-8");
		String producerID = (String) session.getAttribute("username");
		String type = request.getParameter("type"); // loai hang
		String customerName = request.getParameter("name");
		String customerAddress = request.getParameter("address");
		String customerPhone = request.getParameter("phone");
		String meansure = request.getParameter("meansure"); // thong tin do luong
		String vehicleType = request.getParameter("vehicle"); // loai phuong tien van chuyen
		String describe = request.getParameter("describe"); // mo ta them
		String price = request.getParameter("price"); // gia van chuyen
		String distance = request.getParameter("distance"); // khoang cach van chuyen km
		String status = "waitingConfirm"; // trang thai đơn hàng

		// get thoi gian hien tai = thoi gian tao don hang
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		String timeCreate = dateFormat.format(date).toString();
		// Get producer tao don hang
		DBCursor producerCursor = new ProducerModel().queryProducer(producerID);
		while (producerCursor.hasNext()) {
			BasicDBObject producer = (BasicDBObject) producerCursor.next();

			// tao doi tuong order
			BasicDBObject order = new BasicDBObject();
			BasicDBObject shipper = new BasicDBObject();
			order.put("producer", producer);
			order.put("shipper", shipper);
			order.put("type", type);
			order.put("customerName", customerName);
			order.put("customerAddress", customerAddress);
			order.put("customerPhone", customerPhone);
			order.put("meansure", meansure);
			order.put("vehicleType", vehicleType);
			order.put("describe", describe);
			order.put("price", describe);
			order.put("timeCreate", timeCreate);
			order.put("status", status);
			order.put("shippingPrice", price);
			order.put("distance", distance);

			boolean result = new OrderModel().insertOrder(order);
			if (result) {
				model.addAttribute("result", "Đơn hàng đã được tạo");
			} else {
				model.addAttribute("result", "Đã có lỗi xảy ra, vui lòng thử lại");
			}

		}
		return "producer/resultCreateOrder";
	}

	// API dang ki order
	@RequestMapping(value = "/api/createOrder/producerID={producerID}&type={type}&customerAddress={address}&customerName={customerName}&customerPhone={customerPhone}&"
			+ "meansure={meansure}&vehicleType={vehicleType}&describe={describe}&shippingPrice={shippingPrice}&distance={distance}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> apiCreate(Model model, HttpServletRequest request, @PathVariable String producerID,
			@PathVariable String type, @PathVariable String address, @PathVariable String customerName,
			@PathVariable String customerPhone, @PathVariable String meansure, @PathVariable String vehicleType,
			@PathVariable String describe, @PathVariable String shippingPrice, @PathVariable String distance)
			throws JSONException {

		JSONObject respone = new JSONObject();
		String status = "waitingConfirm"; // trang thai order
		// get thoi gian hien tai = thoi gian tao don hang
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		String timeCreate = dateFormat.format(date).toString();

		// Get producer tao don hang
		DBCursor producerCursor = new ProducerModel().queryProducer(producerID);
		while (producerCursor.hasNext()) {
			BasicDBObject producer = (BasicDBObject) producerCursor.next();

			// tao doi tuong order
			BasicDBObject order = new BasicDBObject();
			BasicDBObject shipper = new BasicDBObject();
			order.put("producer", producer);
			order.put("shipper", shipper);
			order.put("type", type);
			order.put("customerName", customerName);
			order.put("customerAddress", address.replace("..", "/"));
			order.put("customerPhone", customerPhone);
			order.put("meansure", meansure);
			order.put("vehicleType", vehicleType);
			order.put("describe", describe);
			// order.put("price", price);
			order.put("timeCreate", timeCreate);
			order.put("status", status);
			order.put("shippingPrice", shippingPrice);
			order.put("distance", distance);

			boolean result = new OrderModel().insertOrder(order);
			if (result) {
				respone.put("result", "success");
				respone.put("result", "created");
			} else {
				respone.put("result", "failed");
				respone.put("message", "failed");
			}
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	@RequestMapping(value = "/listConfirm")
	public String listConfirm(Model model, HttpSession session) {
		boolean ss = new User().verifySessionCenter(session.getAttribute("userType").toString());
		if (!ss){
			return "/Map/user/permissionDeny";
		}
		DBCursor cursor = new OrderModel().listConfirm();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/listOrderConfirm";
	}

	@RequestMapping(value = "/listAllOrder")
	public String listAllOrder(Model model, HttpSession session) {
		boolean ss = new User().verifySessionCenter(session.getAttribute("userType").toString());
		if (!ss){
			return "/Map/user/permissionDeny";
		}
		DBCursor cursor = new OrderModel().queryAllOrder();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/allOrder";
	}

	@RequestMapping(value = "/listTransporting")
	public String listConfirmTransporting(Model model) {
		DBCursor cursor = new OrderModel().listConfirmTransporting();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/listOrderTransporting";
	}

	@RequestMapping(value = "/listConfirmTransported")
	public String listConfirmTransported(Model model) {
		DBCursor cursor = new OrderModel().listConfirmTransported();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/listOrderConfirmTransported";
	}
	
	@RequestMapping(value = "/orderFindingShipper")
	public String orderFindingShipper(Model model) {
		DBCursor cursor = new OrderModel().listFindingShipper();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/orderFindingShipper";
	}
	
	@RequestMapping(value = "/orderCompleted")
	public String orderComplete(Model model) {
		DBCursor cursor = new OrderModel().listOrderCompleted();
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/orderComplete";
	}

	// Thong tin chi tiet order
	@RequestMapping(value = "/orderID={idOrder}")
	public String infoOrder(Model model, @PathVariable String idOrder) {
		String id = idOrder;
		OrderModel orderModel = new OrderModel();
		// Lay trang thai don hang
		String status = orderModel.getOrderStatus(idOrder);
		if (status.equals("waitingConfirm") || status.equals("waitingShipper")) {
			// Lay thong tin producer duoc xac nhan
			DBCursor cursor = orderModel.queryOrder(id);
			List<DBObject> list = cursor.toArray();
			String str = list.toString();
			model.addAttribute("order", str);
			// Chuyen trang thai xac nhan cua producer sang "confirming"
			orderModel.updateStatus(id, "comfirming");
			// tra ve trang thong tin chi tiet de tien hanh xac nhan
			return "order/detailOrder";
		} else {
			// Lay thong tin producer duoc xac nhan
			DBCursor cursor = orderModel.queryOrder(id);
			List<DBObject> list = cursor.toArray();
			String str = list.toString();
			model.addAttribute("order", str);
			// Chuyen trang thai xac nhan cua producer sang "confirming"
			//orderModel.updateStatus(id, "waitingShipper");
			// tra ve trang thong tin chi tiet de tien hanh xac nhan
			return "order/detailOrder";
		}
	}

	// Thong tin chi tiet order
	@RequestMapping(value = "/transporting/orderID={idOrder}")
	public String infoOrderTránporting(Model model, @PathVariable String idOrder) {
		String id = idOrder;
		OrderModel orderModel = new OrderModel();
		// Lay thong tin producer duoc xac nhan
		DBCursor cursor = orderModel.queryOrder(id);
		List<DBObject> list = cursor.toArray();
		String str = list.toString();
		model.addAttribute("order", str);
		// Chuyen trang thai xac nhan cua producer sang "confirming"
		// orderModel.updateStatus(id, "waitingShipper");
		// tra ve trang thong tin chi tiet de tien hanh xac nhan
		return "order/detailOrderTransporting";
	}

	@RequestMapping(value = "/findingShipper/action={action}&orderID={idOrder}")
	public String findShipper(Model model, @PathVariable String action, @PathVariable String idOrder) {
		OrderModel orderModel = new OrderModel();
		String statusOrder = new OrderModel().verifyStatusOrder(idOrder);
		if (action.equals("confirmed")) {
			orderModel.findingShipper(idOrder);
			orderModel.updateStatus(idOrder, "findingShipper");
		} else if (action.equals("notConfirm")) {
			orderModel.updateStatus(idOrder, "notConfirm");
		} else {
			orderModel.updateStatus(idOrder, "waitingConfirm");
		}
		return "order/redirectListOrder";
	}

	// API chap nhan giao hang tu shipper
	@RequestMapping(value = "/accept/shipperID={shipperID}&idOrder={idOrder}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> transportOrder(@PathVariable String shipperID, @PathVariable String idOrder)
			throws JSONException {
		OrderModel orderModel = new OrderModel();
		JSONObject respone = new JSONObject();
		boolean hasShipper = orderModel.verifyShipperOrder(idOrder);
		if (!hasShipper){
			boolean result = orderModel.updateShipper(idOrder, shipperID);
			if (result) {
				//lay thong tin don hang goi den cho shipper
				respone.put("result", "success");
				respone.put("message", "success");
				orderModel.updateStatus(idOrder, "transporting");
				DBCursor cursor = orderModel.queryOrder(idOrder);
				if (cursor.hasNext()){
					JSONObject object = new JSONObject(cursor.next().toString());
					respone.put("producerName", object.getJSONObject("producer").getString("fullname"));
					respone.put("producerPhone", object.getJSONObject("producer").getString("phone"));
					respone.put("producerStore", object.getJSONObject("producer").getString("storeName"));
					respone.put("producerAddress", object.getJSONObject("producer").getString("address"));
					respone.put("idOrder", object.getJSONObject("_id").getString("$oid"));
				}
			} else {
				respone.put("result", "failed");
				respone.put("message", "error");
			}
		} else {
			respone.put("result", "failed");
			respone.put("message", "Has shipper");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}
	
	
	// API chap xoa xac nhan giao hang hang tu shipper
		@RequestMapping(value = "/delete/shipperID={shipperID}&idOrder={idOrder}", method = RequestMethod.GET, produces = "application/json")
		@ResponseBody
		public ResponseEntity<String> deleteTransportOrder(@PathVariable String shipperID, @PathVariable String idOrder)
				throws JSONException {
			OrderModel orderModel = new OrderModel();
			JSONObject respone = new JSONObject();
			boolean resultDelete = orderModel.deleteShipper(idOrder, shipperID);
			if (resultDelete){
				orderModel.findingShipper(idOrder);
				orderModel.updateStatus(idOrder, "findingShipper");
				respone.put("result", "success");
				respone.put("message", "Cancelled");
			} else {
				respone.put("result", "failed");
				respone.put("message", "Has shipper");
			}
			return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
		}

	// API xac nhan da giao hang cua shipper
	@RequestMapping(value = "/transported/shipperID{shipperID}&idOrder={idOrder}", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<String> transported(@PathVariable String shipperID, @PathVariable String idOrder)
			throws JSONException {
		OrderModel orderModel = new OrderModel();
		JSONObject respone = new JSONObject();
		boolean result = orderModel.updateStatus(idOrder, "transported");
		if (result) {
			respone.put("result", "success");
			respone.put("message", "success");
		} else {
			respone.put("result", "failed");
			respone.put("message", "error");
		}
		return new ResponseEntity<String>(respone.toString(), HttpStatus.OK);
	}

	// xac nhan da hoan thanh giao dich tu TTDK
	@RequestMapping(value = "/completeOrder/idOrder={idOrder}/")
	public String completeOrder(@PathVariable String idOrder) throws JSONException {
		OrderModel orderModel = new OrderModel();
		ShipperModel shipperModel = new ShipperModel();
		orderModel.updateStatus(idOrder, "completed");
		// tru quy cua shipper
		//Lay gia tri cua don hang
		String price = orderModel.getPriceOrder(idOrder);
		String shipperID = orderModel.getShipperIDFromOrder(idOrder);
		System.out.println(shipperID);
		String currentFunds = shipperModel.getCurrentFunds(shipperID);
		String newFunds = (Float.parseFloat(currentFunds)-Float.parseFloat(price)/10)+"";
		boolean update = shipperModel.updateFunds(shipperID, newFunds);
		//ghi lai log
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date date = new Date();
		String time = dateFormat.format(date).toString();
		float value = Float.parseFloat(newFunds)-Float.parseFloat(currentFunds);
		shipperModel.logChangeFunds(shipperID, time, value);
	
		return "order/redirectTransported";
	}
	
	@RequestMapping(value="orderOfProducer/producer={idProducer}")
	public String orderOfProducer(Model model, @PathVariable String idProducer){
		DBCursor cursor = new OrderModel().queryAllOrderOfProducer(idProducer);
		List<DBObject> list = cursor.toArray();
		String listOrder = list.toString();
		model.addAttribute("listOrder", listOrder);
		return "order/allOrderOfProducer";
	}
}
