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
	
	@RequestMapping(value = "addEducationQualification.do")
	public String addEducationQualification() {
		return "HRM/addEducationQualification";		
	}
	
	@RequestMapping(value = "addProfessionalData.do")
	public String addProfessionalData() {
		return "HRM/addProfessionalData";		
	}
	@RequestMapping(value = "addTraningData.do")
	public String addTraningData() {
		return "HRM/addTraningData";		
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
	
	
	@RequestMapping(value = "VoucherEntryHeadWise.do")
	public String VoucherEntryHeadWise() {
		return "AIS/evoucherentrysearch";		
	}
	@RequestMapping(value = "VoucherEntryItemWise.do")
	public String VoucherEntryItemWise() {
		return "AIS/evoucherentryitemwise";		
	}
	
	@RequestMapping(value = "TransactionEntryValidation.do")
	public String TransactionEntryValidation() {
		return "AIS/etransactionvalidation";		
	}
	
	@RequestMapping(value = "BranchWiseItemsCreation.do")
	public String BranchWiseItemsCreation() {
		return "AIS/ebranchwiseitemcreation";		
	}	
	
	@RequestMapping(value = "NewGlOpeningPages.do")
	public String NewGlOpeningPages() {
		return "AIS/ebranchaccountopen";		
	}
	
	@RequestMapping(value = "GLOpeningBalance.do")
	public String GLOpeningBalance() {
		return "AIS/eglopeningbalance";		
	}
	
	
	
	@RequestMapping(value = "VouherViewReport.do")
	public String VouherViewReport() {
		return "AIS/VouherViewReport";		
	}
	@RequestMapping(value = "ViewCashBookReport.do")
	public String ViewCashBookReport() {
		return "AIS/ViewCashBookReport";		
	}
	@RequestMapping(value = "ViewGeneralLedgerStatementReport.do")
	public String ViewGeneralLedgerStatementReport() {
		return "AIS/ViewGeneralLedgerStatementReport";		
	}
	
	
		@RequestMapping(value = "viewBranchReconciliation.do")
	public String viewBranchReconciliation() {
		return "AIS/viewBranchReconciliation";		
	}
	
	@RequestMapping(value = "viewGLRegisterReport.do")
	public String viewGLRegisterReport() {
		return "AIS/viewGLRegisterReport";		
	}
	@RequestMapping(value = "ViewFinancialReport.do")
	public String viewTrailBalanceReport() {
		return "AIS/ViewFinancialReport";		
	}
	
	
	@RequestMapping(value = "addEmployeeBasicData.do")
	public String addEmployeeBasicData() {
		return "PRMS/addEmployeeBasicData";		
	}
	@RequestMapping(value = "addEmployeeAllowanceData.do")
	public String addEmployeeAllowanceData() {
		return "PRMS/addEmployeeAllowanceData";		
	}
	@RequestMapping(value = "addEmployeeDeductionData.do")
	public String addEmployeeDeductionData() {
		return "PRMS/addEmployeeDeductionData";		
	}
	
	@RequestMapping(value = "addAnnualIncrementData.do")
	public String addAnnualIncrementData() {
		return "PRMS/addAnnualIncrement";		
	}
	@RequestMapping(value = "addEmployeeIncentiveData.do")
	public String addEmployeeIncentiveData() {
		return "PRMS/addEmployeeIncentiveData";		
	}
	@RequestMapping(value = "ViewMonthlySalaryReport.do")
	public String ViewMonthlySalaryReport() {
		return "PRMS/ViewMonthlySalaryReport";		
	}	
	@RequestMapping(value = "ViewFestivalBonusReport.do")
	public String ViewFestivalBonusReport() {
		return "PRMS/ViewFestivalBonusReport";		
	}
	
	@RequestMapping(value = "ViewIncentiveReport.do")
	public String ViewIncentiveReport() {
		return "PRMS/ViewIncentiveReport";		
	}
	
	@RequestMapping(value = "ViewSalaryCertificate.do")
	public String ViewSalaryCertificate() {
		return "PRMS/ViewSalaryCertificate";		
	}
	
	@RequestMapping(value = "misLoanSanctionAndDisbursement.do")
	public String misLoanSanctionAndDisbursement() {
		return "MIS/misLoanSanctionAndDisbursement";		
	}
	@RequestMapping(value = "misLoanRecovery.do")
	public String misLoanRecovery() {
		return "MIS/misLoanRecovery";		
	}
	
	@RequestMapping(value = "misAuditObjectionDisposal.do")
	public String misAuditObjectionDisposal() {
		return "MIS/misAuditObjectionDisposal";		
	}
	
	@RequestMapping(value = "misKharidabariData.do")
	public String misKharidabariData() {
		return "MIS/misKharidabariData";		
	}
	@RequestMapping(value = "misCourtCaseSettlementData.do")
	public String misCourtCaseSettlementData() {
		return "MIS/misCourtCaseSettlementData";		
	}
	@RequestMapping(value = "misFaultyLoanCaseDeedReturn.do")
	public String misFaultyLoanCaseDeedReturn() {
		return "MIS/misFaultyLoanCaseDeedReturn";		
	}
	@RequestMapping(value = "viewMISReport.do")
	public String viewMISReport() {
		return "MIS/viewMISReport";		
	}
	
	@RequestMapping(value = "viewAdvanceReport.do")
	public String viewAdvanceReport() {
		return "ELMS/viewAdvanceReport";		
	}
	@RequestMapping(value = "viewSalaryDeductionReport.do")
	public String viewSalaryDeductionReport() {
		return "ELMS/viewSalaryDeductionReport";		
	}
}
