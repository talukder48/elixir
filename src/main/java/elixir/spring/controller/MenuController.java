package elixir.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MenuController {
	@RequestMapping(value = "addEmployeeRecord.do")
	public String addEmployeeRecord() {
		return "HRM/AddEmployeeRecord";		
	}
	@RequestMapping(value = "addIncrementRecord.do")
	public String addIncrementRecord() {
		return "HRM/AddIncrementRecord";		
	}
	@RequestMapping(value = "addLeaveRecord.do")
	public String addLeaveRecord() {
		return "HRM/AddLeaveRecord";		
	}
	@RequestMapping(value = "addPromotionRecord.do")
	public String addPromotionRecord() {
		return "HRM/AddPromotionRecord";		
	}
	@RequestMapping(value = "addSuspendRecord.do")
	public String addSuspendRecord() {
		return "HRM/AddSuspendRecord";		
	}
	@RequestMapping(value = "addTransferRecord.do")
	public String addTransferRecord() {
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
	@RequestMapping(value = "PensionMonthlyReportView.do")
	public String PensionMonthlyReport() {
		return "PPS/PensionMonthlyReport";		
	}
	@RequestMapping(value = "PensionYearlyReportview.do")
	public String PensionYearlyReport() {
		return "PPS/PensionYearlyReport";		
	}
	@RequestMapping(value = "PensionBonusReportView.do")
	public String PensionBonusReportView() {
		return "PPS/PensionBonusReportView";		
	}
	
	
	@RequestMapping(value = "AccountingVoucherEntryPages.do")
	public String AccountingVoucherEntryPages() {
		return "AIS/AccountingVoucherEntry";		
	}
	@RequestMapping(value = "TransactionEntryValidation.do")
	public String TransactionEntryValidation() {
		return "AIS/TransactionEntryValidation";		
	}
	@RequestMapping(value = "NewGlOpeningPages.do")
	public String NewGlOpeningPages() {
		return "AIS/NewGlOpeningPages";		
	}
	@RequestMapping(value = "VouherViewReport.do")
	public String VouherViewReport() {
		return "AIS/VouherViewReport";		
	}
	@RequestMapping(value = "CashBookViewReport.do")
	public String CashBookViewReport() {
		return "AIS/CashBookViewReport";		
	}
	@RequestMapping(value = "GLStatementViewReport.do")
	public String GLStatementViewReport() {
		return "AIS/GLStatementViewReport";		
	}
	@RequestMapping(value = "GLRegisterViewReport.do")
	public String GLRegisterViewReport() {
		return "AIS/GLRegisterViewReport";		
	}
	@RequestMapping(value = "TrailBalanceViewReport.do")
	public String TrailBalanceViewReport() {
		return "AIS/TrailBalanceViewReport";		
	}
	
}
