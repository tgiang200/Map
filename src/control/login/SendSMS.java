package control.login;

import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.twilio.sdk.TwilioRestClient;
import com.twilio.sdk.TwilioRestException;
import com.twilio.sdk.resource.factory.MessageFactory;
import com.twilio.sdk.resource.instance.Message;

public class SendSMS {
	public boolean sendPasswordToSMS(String toPhone, String body) {

		String ACCOUNT_SID = "ACf1b9d702b9d343909bfb1b454c56116e";
		String AUTH_TOKEN = "6b57deb8ce05285b208c3ca463875262";
		
		// convert phone from 0 to +84
		String phone = "+"+toPhone;
		phone = phone.replace("+0", "+84");

		TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);

		// Build the parameters
		List<NameValuePair> params = new ArrayList<NameValuePair>();
		params.add(new BasicNameValuePair("To", phone));// "+841219688266"));
		params.add(new BasicNameValuePair("From", "+14847342833 "));
		params.add(new BasicNameValuePair("Body", body));

		MessageFactory messageFactory = client.getAccount().getMessageFactory();
		Message message;
		try {
			message = messageFactory.create(params);
			System.out.println(message.getSid());
			System.out.println(phone);
			System.out.println(body);
			return true;
		} catch (TwilioRestException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}
	
	public static void main(String [] args){
		System.out.println(new SendSMS().sendPasswordToSMS("01656503696", "123456789329849324783"));
	}
}
