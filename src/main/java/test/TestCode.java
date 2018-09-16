package test;

import org.apache.commons.codec.binary.Base64;
import org.junit.Test;

public class TestCode {
	@Test
	public void testPwd(){
		String str1="123456";
		Base64 base64=new Base64();
		byte[] encode = base64.encode(str1.getBytes());
		String string1 = new String(encode);
		System.out.println(string1);
		byte[] decode = base64.decode(string1.getBytes());
		String string2 = new String(decode);
		System.out.println(string2);
	}
}
