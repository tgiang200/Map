package control.api;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Sha1Digest {
	public static String sha1(String input) throws NoSuchAlgorithmException {
        MessageDigest mDigest = MessageDigest.getInstance("SHA1");
        byte[] result = mDigest.digest(input.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < result.length; i++) {
            sb.append(Integer.toString((result[i] & 0xff) + 0x100, 16).substring(1));
        }         
        return sb.toString();
    }
	
	public boolean checkSha1(String str1, String str2){
		if (str1.equals(str2)){
			return true;
		} else {
			return false;
		}
	}
	
	public static void main(String []args) throws NoSuchAlgorithmException{
		Sha1Digest sd = new Sha1Digest();
		String a1 = sha1("getAllUseruser11234");
		String a2 = sha1("abc");
		System.out.println(a1);
	}
}
