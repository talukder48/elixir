package elixir.report.ics;
import java.util.Map;


public class PensionPaymentSystemReport {
	public byte[] MonthlyPensionPaymentSystemReport(Map DataMap) {
		String str = "byte array size example";
		byte DataBytes[] = str.getBytes();
		System.out.println(DataMap);
		return DataBytes;
	}	

}
