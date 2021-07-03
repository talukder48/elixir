package elixir.validator.pps;


import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class BulkSMSService {
	private static final char[] HEX_UPPER = "0123456789ABCDEF".toCharArray();
    private static final char[] HEX_LOWER = "0123456789abcdef".toCharArray();
	private static String encodeValue(String value) throws UnsupportedEncodingException {
	    return URLEncoder.encode(value, StandardCharsets.UTF_8.toString());
	}
	public static String convertStringToHex(String str, boolean lowercase) {
        char[] HEX_ARRAY = lowercase ? HEX_LOWER : HEX_UPPER;
        byte[] bytes = str.getBytes(StandardCharsets.UTF_8);
        char[] hex = new char[bytes.length * 2];

        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;               
            hex[j * 2] = HEX_ARRAY[v >>> 4];       
            hex[j * 2 + 1] = HEX_ARRAY[v & 0x0F];  
        }
        return new String(hex);
    }
	public static String sendsms(String msisdn, String sms_string) {
		try {		
			Map<String, String> requestParams = new HashMap<>();
		    requestParams.put("user", "BHBFCeHLS");
		    requestParams.put("pass", "41>5R63p");
		    requestParams.put("sid", "BHBFCeHLSBng");
		    requestParams.put("sms",  convertStringToHex(sms_string,true));
		    requestParams.put("msisdn", msisdn);
		    requestParams.put("csmsid", "909");
			
		    String encodedURL = requestParams.keySet().stream().map(key -> {
				try {
					return key + "=" + encodeValue(requestParams.get(key));
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
				return key;
			}).collect(Collectors.joining("&", "http://sms.sslwireless.com/pushapi/dynamic/server.php?", ""));
			
		    try {
				
	            URL url = new URL(encodedURL);	            
	            HttpURLConnection uc = (HttpURLConnection)url.openConnection();
	            System.out.println(uc.getResponseMessage());

	               uc.disconnect();

		    } catch(Exception ex) {
		        System.out.println(ex.getMessage());
		    }
						
			return "x";
		} catch (Exception ex) {
			return "ok";
		}
	}
	 
}
