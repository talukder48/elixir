package elixir.spring.controller;

import java.text.DateFormat;
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

	@RequestMapping(value = "/UserHomePage.Do", method = RequestMethod.POST)
	public String logInController(@Validated User user, Model model, HttpServletRequest request) {
		System.out.println("User Page Requested");
		model.addAttribute("userName", user.getUserName());
		model.addAttribute("password", user.getPassword());
		HttpSession sessionParam = request.getSession();

		sessionParam.putValue("User_Id", user.getUserName());
		if (user.getUserName().equals("1000")) {
			sessionParam.putValue("BranchCode", "0600");
			return "BranchOfficeUser";
		} else if (user.getUserName().equals("1001")) {
			sessionParam.putValue("BranchCode", "9999");
			return "HeadOfficeUser";
		} else if (user.getUserName().equals("1002")) {
			sessionParam.putValue("BranchCode", "0100");
			return "HeadOfficeMISUser";
		}else if (user.getUserName().equals("1003")) {
			sessionParam.putValue("BranchCode", "0100Z");
			return "ZonalOfficeUser";
		}
		else {
			sessionParam.putValue("BranchCode", "0101R");
			return "RigionalOfficeUser";
		}
			
	}

	@RequestMapping(value = "currentUserHomePage.do", method = RequestMethod.POST)
	public String currentUserHomePage(HttpSession sessionParam, Locale locale, Model model) {

		try {
			String Branch_code = sessionParam.getValue("BranchCode").toString();
			if (Branch_code != null) {
				if (Branch_code.equals("9999")) {
					return "HeadOfficeUser";
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
