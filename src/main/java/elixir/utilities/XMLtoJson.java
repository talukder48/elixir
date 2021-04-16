package elixir.utilities;

import net.sf.json.JSON;
import net.sf.json.xml.XMLSerializer;


public class XMLtoJson {
	public static void XMLConversion (String xml) throws Exception {
		XMLSerializer xmlSerializer = new XMLSerializer();
		JSON json = xmlSerializer.read(xml);
		System.out.println(json.toString(2));
	}
	
}