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
	public String logInController(@Validated User user, Model model,HttpServletRequest request) {
		System.out.println("User Page Requested");
		model.addAttribute("userName", user.getUserName());
		model.addAttribute("password", user.getPassword());	
		HttpSession sessionParam = request.getSession();				
		sessionParam.putValue("BranchCode", "0600");
		
		if (user.getUserName().equals("1457")) {
			return "PensionUserHomePage";
		}
		else if(user.getUserName().equals("1000")) {
			return "AccountingUserHomePages";
		}
		else return "HrmUserHomePage";
		
	}
	
	
	
}
