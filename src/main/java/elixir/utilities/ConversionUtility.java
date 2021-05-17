package elixir.utilities;
import java.util.Map;
import com.google.gson.Gson;

public class ConversionUtility {
	public static Map JasonStringToHashMap (String jasonString) throws Exception {		
		Gson gson = new Gson();
		Map map = gson.fromJson(jasonString, Map.class);
		System.out.println(map);
		return map;
	}
	
}