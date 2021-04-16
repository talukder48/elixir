package elixir.spring.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;

import elixir.spring.model.User;
import elixir.utilities.XMLtoJson;

@Controller
public class AjaxCallController {
	
	@RequestMapping(value = "/CommomAjaxCallHandler", method = RequestMethod.POST,produces = "application/json")
	public  void AjaxCallHandlerPost(HttpServletRequest req,HttpServletResponse res) {
		System.out.println("Ajax Call");
		System.out.println(req.getParameter("data"));
		Map<String, String> OutputMap = new HashMap<String, String>();		
		try {
			XMLtoJson.XMLConversion(req.getParameter("data").toString());
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		OutputMap.put("ERROR_MSG", "");
		String GsonString = "";
		Gson gsonObj = new Gson();
		 GsonString = gsonObj.toJson(OutputMap);
		PrintWriter out = null;
		try {
			out = res.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		out.println(GsonString);
	}	
	
	@RequestMapping(value = "/CommomAjaxCallHandler", method = RequestMethod.GET,produces = "application/json")
	public  void AjaxCallHandlerGet(HttpServletRequest req,HttpServletResponse res) {
		System.out.println("Ajax Call");
		System.out.println(req.getParameter("data"));
		Map<String, String> OutputMap = new HashMap<String, String>();
		OutputMap.put("ERROR_MSG", "");
		String GsonString = "";
		Gson gsonObj = new Gson();
		 GsonString = gsonObj.toJson(OutputMap);
		PrintWriter out = null;
		try {
			out = res.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		out.println(GsonString);
	}
	
}
