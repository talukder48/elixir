package elixir.spring.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import elixir.model.pps.PensionerAllwance;
@Controller
public class PensionController {
	
	@RequestMapping(value = "addPensionData.Do", method = RequestMethod.POST)
	public String AddPensionAllwanceData(@Validated PensionerAllwance allwance, Model model,BindingResult result, SessionStatus status) {
			System.out.println(allwance.getRemarks()+allwance.getNothiNo());			
			result.rejectValue("EmployeeName", "EmployeeName");
			model.addAttribute("Message", "Data Sucessfully Updated for ");
		return "PPS/PensionAllwanceDataUpdate";
	}
}
