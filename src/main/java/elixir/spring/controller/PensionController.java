package elixir.spring.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import elixir.model.pps.PensionerAllwance;
@Controller
public class PensionController {
	
	@RequestMapping(value = "addPensionData.Do", method = RequestMethod.POST)
	public String logInController(@Validated PensionerAllwance allwance, Model model,HttpServletRequest request) {
			System.out.println(allwance.getRemarks());
			model.addAttribute("Message", "Data Sucessfully Updated");
		return "PPS/PensionAllwanceDataUpdate";
	}
}
