package elixir.report.ics;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class PensionPaymentSystem {
	String ResponseMessage=null;
	@RequestMapping(value = "/PensionPaymentSystemReport", method = RequestMethod.POST,produces = "application/json")
	public  void PensionPaymentSystemReport(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("ok");
		
	}	

}
