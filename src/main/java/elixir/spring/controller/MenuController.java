package elixir.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuController {
	@RequestMapping(value = "HRM/addEmployeeRecord.do")
	public String AddEmployeeMenuParser() {
		return "HRM/AddEmployeeRecord";		
	}
	@RequestMapping(value = "HRM/addIncrementRecord.do")
	public String AddIncrementMenuParser() {
		return "HRM/AddIncrementRecord";		
	}
	@RequestMapping(value = "HRM/addLeaveRecord.do")
	public String AddLeaveMenuParser() {
		return "HRM/AddLeaveRecord";		
	}
	@RequestMapping(value = "HRM/addPromotionRecord.do")
	public String AddPromotionMenuParser() {
		return "HRM/AddPromotionRecord";		
	}
	@RequestMapping(value = "HRM/addSuspendRecord.do")
	public String AddSuspendMenuParser() {
		return "HRM/AddSuspendRecord";		
	}
	@RequestMapping(value = "HRM/addTransferRecord.do")
	public String AddTransferMenuParser() {
		return "HRM/AddTransferRecord";		
	}
	
	
	
	
	
	@RequestMapping(value = "PensionNothiDataUpdate.do")
	public String PensionNothiDataUpdate() {
		return "PPS/PensionNothiDataUpdate";		
	}
	@RequestMapping(value = "PensionInharitanceDataUpdate.do")
	public String PensionInharitanceDataUpdate() {
		return "PPS/PensionInharitanceDataUpdate";		
	}
	@RequestMapping(value = "PensionAllwanceDataUpdate.do")
	public String PensionAllwanceDataUpdate() {
		return "PPS/PensionAllwanceDataUpdate";		
	}
	@RequestMapping(value = "PensionDeductionDataUpdate.do")
	public String PensionDeductionDataUpdate() {
		return "PPS/PensionDeductionDataUpdate";		
	}	
	@RequestMapping(value = "PensionMonthlyReport.do")
	public String PensionMonthlyReport() {
		return "PPS/PensionMonthlyReport";		
	}
	@RequestMapping(value = "PensionYearlyReport.do")
	public String PensionYearlyReport() {
		return "PPS/PensionYearlyReport";		
	}
	
	
	@RequestMapping(value = "AccountingVoucherEntryPages.do")
	public String AccountingVoucherEntryPages() {
		return "AIS/AccountingVoucherEntry";		
	}
	
	@RequestMapping(value = "NewGlOpeningPages.do")
	public String NewGlOpeningPages() {
		return "AIS/NewGlOpeningPages";		
	}
	
}
