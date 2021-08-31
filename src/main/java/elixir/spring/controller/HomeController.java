package elixir.spring.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import elixir.spring.model.*;
import elixir.validator.pps.LoginValidation;

@Controller
public class HomeController {

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		System.out.println("Home Page Requested, locale = " + locale);
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("Title", "Bangladesh House Building Finance Corporation");

		return "home";
	}

	@RequestMapping(value = "/UserHomePage.do", method = RequestMethod.POST)
	
	public String logInController(@Validated User user, Model model, HttpServletRequest request,Locale locale) {
		
		System.out.println("User Page Requested");
		model.addAttribute("userName", user.getUserName());
		model.addAttribute("password", user.getPassword());
		HttpSession sessionParam = request.getSession();
		Map<String, String> inmap = new HashMap<String, String>();
		Map<String, String> outmap= new HashMap<String, String>();
		String ViewName=null;
		inmap.put("user", user.getUserName());
		inmap.put("password", user.getPassword());
		LoginValidation lv=new LoginValidation();
		outmap=lv.LoginMethod(inmap);
		
		if(outmap.get("ERROR_MSG").equals("")) {
			sessionParam.setAttribute("User_Id", inmap.get("user"));
			sessionParam.setAttribute("USER_NAME ", outmap.get("USER_NAME"));
			sessionParam.setAttribute("BranchCode", outmap.get("USER_BRANCH"));
			sessionParam.setAttribute("CheckRole", outmap.get("CHECK_ROLE"));
			sessionParam.setAttribute("AuthRole", outmap.get("AUTH_ROLE"));				
			sessionParam.setMaxInactiveInterval(24*60* 60);				
			SimpleDateFormat sdf = new SimpleDateFormat("E, dd MMM yyyy HH:mm:ss z");
			String date = sdf.format(new Date());
			sessionParam.setAttribute("LogOnTime", "");
			sessionParam.setAttribute("LogOnDate", date);
			sessionParam.setAttribute("USER_ROLE", outmap.get("USER_ROLE"));
			sessionParam.setAttribute("BR_TYPE", outmap.get("BR_TYPE"));
			sessionParam.setAttribute("BRN_NAME", outmap.get("BRN_NAME"));
			if(outmap.get("BR_TYPE").equals("B")) {
				ViewName= "BranchOfficeUser";
			}
			else if(outmap.get("BR_TYPE").equals("Z")) {
				ViewName= "ZonalOfficeUser";
			}		
			else if(outmap.get("BR_TYPE").equals("R")) {
				ViewName= "RigionalOfficeUser";
			}
			else if(outmap.get("BR_TYPE").equals("H")||outmap.get("BR_TYPE").equals("E")) {
				
				if (outmap.get("USER_ROLE").equals("S")) {
					ViewName= "HeadOfficeICTUser";
				}
				else if (outmap.get("USER_ROLE").equals("F")||outmap.get("USER_ROLE").equals("G")||outmap.get("USER_ROLE").equals("g")) {
					ViewName= "HeadOfficeUser";
				}
				else if (outmap.get("USER_ROLE").equals("A")) {
					return "HeadOfficeHRMUser";
				}				
			}
			
		}else {
			ViewName="home";
			model.addAttribute("Error", "Error Message: "+outmap.get("ERROR_MSG")+"!!");
			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

			String formattedDate = dateFormat.format(date);

			model.addAttribute("serverTime", formattedDate);
			model.addAttribute("Title", "Bangladesh House Building Finance Corporation");
		}
		return ViewName;
	
		
	}

	@RequestMapping(value = "currentUserHomePage.do", method = RequestMethod.POST)
	public String currentUserHomePage(HttpSession sessionParam, Locale locale, Model model) {

		try {
			String Branch_code = sessionParam.getValue("BranchCode").toString();
			if (Branch_code != null) {
				if (Branch_code.equals("9999")) {
					return "HeadOfficeICTUser";
				}
				else if(Branch_code.equals("0600")) {
					return "BranchOfficeUser";
				}
				else if(Branch_code.equals("0100")) {
					return "HeadOfficeMISUser";				
				}
				else if(Branch_code.equals("0100Z")) {
					return "ZonalOfficeUser";
				}
				else if(Branch_code.equals("9998")) {
					return "HeadOfficeUser";
				}
				else {
					return "RigionalOfficeUser";
				}
			} else {
				
				Date date = new Date();
				sessionParam.invalidate();
				DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
				String formattedDate = dateFormat.format(date);
				model.addAttribute("serverTime", formattedDate);
				model.addAttribute("Title", "Bangladesh House Building Finance Corporation");
				return "home";
			}
		} catch (Exception e) {
			Date date = new Date();
			sessionParam.invalidate();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate);
			model.addAttribute("Title", "Bangladesh House Building Finance Corporation");
			return "home";
		}

	}

	@RequestMapping(value = "elixir.do", method = RequestMethod.POST)
	public String elixir(HttpServletRequest request, Locale locale, Model model) {

		try {
			HttpSession sessionParam = request.getSession();
			sessionParam.invalidate();

			Date date = new Date();
			DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
			String formattedDate = dateFormat.format(date);
			model.addAttribute("serverTime", formattedDate);
			model.addAttribute("Title", "Bangladesh House Building Finance Corporation");

		} catch (Exception e) {

		}
		return "home";

	}

}
