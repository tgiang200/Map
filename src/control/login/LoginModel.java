package control.login;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.mongodb.BasicDBObject;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;

import mongo.database.ConnectMongo;

public class LoginModel {
	public static DBCollection collectionCode = new ConnectMongo().connect("code");
	
	public boolean sendMail(String sendMailTo, String bodyMail) {
		boolean result = false;
		
		final String username = "tgiang002@gmail.com";
		final String password = "2266226602";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("tgiang002@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(sendMailTo));
			message.setSubject("Mang xã hội vận chuyển hàng hóa");
			message.setText(bodyMail);

			Transport.send(message);

			result = true;
			//System.out.println("Done");
			
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		return result;
	}
	
	public void insertCode(String phone, String code){
		BasicDBObject obj = new BasicDBObject(); 
		obj.put("phone", phone);
		obj.put("code", code);
		collectionCode.insert(obj);
	}
	
	public void deleteCode(String phone){
		BasicDBObject obj = new BasicDBObject(); 
		obj.put("phone", phone);
		collectionCode.remove(obj);
	}
	
	public String createCode(){
		String code = (new Random().nextInt(9999-1000)+1000)+"";
		return code;
	}
	
	public boolean verifyCode(String phone, String code){
		boolean result = false;
		BasicDBObject obj = new BasicDBObject();
		obj.put("phone", phone);
		obj.put("code", code);
		DBCursor cursor = collectionCode.find(obj);
		if (cursor.hasNext()){
			result = true;
		}
		return result;
	}
	
	public static void main(String [] args){
		//for (int i=0;i<=20;i++){
			new LoginModel().sendMail("giangb1304545@student.ctu.edu.vn", "test");
		//}
	}
}
