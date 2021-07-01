/***************************************************************
* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/

package elixir.utilities;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.StringTokenizer;


public class ProjectUtils {	
	
public static LinkedList TransactionSplite(String TransactionStream) {
	LinkedList<Map> transactionclause = new LinkedList<Map>();
	String[] sentance = TransactionStream.split("<sentance>"); 
    for (String clause : sentance) {
    	String[] clauseString = clause.split("<clause>");     	
    	Map<String, String> map = new HashMap<String, String>();   	
    	for (String cell : clauseString) {
    		String[] cellString = cell.split("<cell>");     		
    		try {
    			map.put(cellString[0], cellString[1]); 
    		}    		 
    		catch(Exception e) {
    			map.put(cellString[0], ""); 
    		}
       }
    	transactionclause.add(map);  	
    }        
    return transactionclause;
}
	
	public static LinkedList TransactionTokenizer(String TransactionStream) {
		LinkedList<Map> transactionclause = new LinkedList<Map>();

		try {
			StringTokenizer trantoken = new StringTokenizer(TransactionStream, "@");

			while (trantoken.hasMoreTokens()) {
				String actualElement = trantoken.nextToken();
				StringTokenizer columntoken = new StringTokenizer(actualElement, "*");
				Map<String, String> map = new HashMap<String, String>();

				while (columntoken.hasMoreElements()) {
					String acttoken = columntoken.nextToken();
					StringTokenizer atttok = new StringTokenizer(acttoken, "=");
					if (atttok.countTokens() != 2) {
						throw new RuntimeException("Unexpeced format");
					}
					String key = atttok.nextToken();
					String value = atttok.nextToken();
					map.put(key, value);
				}
				// System.out.println(map);
				transactionclause.add(map);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage().toString());
		}

		return transactionclause;
	}
	
	public static Map  DataTokenizer(String DataStream)
    {
		Map<String, String> map = new HashMap<String, String>();
		map.put("Error", "NA");
		try {
			
			StringTokenizer st = new StringTokenizer(DataStream, "$");
	    	
	    	while ( st.hasMoreElements() ) {

	    	    String actualElement = st.nextToken();
	    	    StringTokenizer et = new StringTokenizer(actualElement, "*");
	    	    if ( et.countTokens() != 2 ) {
	    	        throw new RuntimeException("Unexpeced format");
	    	    }
	    	    String key = et.nextToken();
	    	    String value = et.nextToken();
	    	    map.put(key, value);
	    	}
			
			
		}catch (Exception e) {
			map.put("Error", "Unexpected Format");
		}
    	
    	return map;
    }  
	
	public static Map  SubStringTokenizer(String DataStream)
    {
    	StringTokenizer st = new StringTokenizer(DataStream, "!");
    	Map<String, String> map = new HashMap<String, String>();
    	while ( st.hasMoreElements() ) {

    	    String actualElement = st.nextToken();
    	    StringTokenizer et = new StringTokenizer(actualElement, ":");
    	    if ( et.countTokens() != 2 ) {
    	        throw new RuntimeException("Unexpeced format");
    	    }
    	    String key = et.nextToken();
    	    String value = et.nextToken();
    	    map.put(key, value);
    	}
    	return map;
    }  
	
	public static String GetProjectPath(String dumbString) {
		String reportPath="";
		dumbString=dumbString.replace("\\", "-");
		dumbString=dumbString.replace(".", "");
		String[] arrOfStr=dumbString.split("-");		
		reportPath=arrOfStr[0];
		for (int i=1;i<arrOfStr.length;i++) {
			if(arrOfStr[i].equals("metadata")) 
				break;
			reportPath+="\\"+arrOfStr[i];				
		}
		reportPath+="\\"+arrOfStr[arrOfStr.length-1];	
	return 	reportPath;
}
}
