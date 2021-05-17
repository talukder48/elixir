package elixir.spring.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.google.gson.Gson;
import elixir.utilities.CommonSessionFacade;
import elixir.utilities.ConversionUtility;

@Controller
public class AjaxCallController {
	String ResponseMessage=null;
	@RequestMapping(value = "/CommomAjaxCallHandler", method = RequestMethod.POST,produces = "application/json")
	public  void AjaxCallHandlerPost(HttpServletRequest req,HttpServletResponse res) {	
		Map<String, String> OutputMap = new HashMap<String, String>();		
		Map<String, String> InputMap = new HashMap<String, String>();
		try {
			InputMap=ConversionUtility.JasonStringToHashMap(req.getParameter("DataString").toString());
			OutputMap = CommonSessionFacade.SessionFacade(InputMap);						
		} catch (Exception e1) {
			e1.printStackTrace();
		}				

		Gson gsonObj = new Gson();
		ResponseMessage = gsonObj.toJson(OutputMap);
		PrintWriter out = null;
		try {
			out = res.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(ResponseMessage);
	}	
	
	@RequestMapping(value = "/CommomAjaxCallHandler", method = RequestMethod.GET,produces = "application/json")
	public  void AjaxCallHandlerGet(HttpServletRequest req,HttpServletResponse res) {	
		Map<String, String> OutputMap = new HashMap<String, String>();		
		Map<String, String> InputMap = new HashMap<String, String>();
		try {
			InputMap=ConversionUtility.JasonStringToHashMap(req.getParameter("DataString").toString());
			OutputMap = CommonSessionFacade.SessionFacade(InputMap);						
		} catch (Exception e1) {
			e1.printStackTrace();
		}				

		Gson gsonObj = new Gson();
		ResponseMessage = gsonObj.toJson(OutputMap);
		PrintWriter out = null;
		try {
			out = res.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(ResponseMessage);
	}
	
}
