package control.tracker;

public class Test{
	public static void main(String [] args){
		String phone = "01234";
		String phoneS = "+"+phone;
		phoneS = phoneS.replace("+0", "+84");
		System.out.println("main: "+phoneS);
	}	
}
