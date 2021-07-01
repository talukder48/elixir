/***************************************************************
* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/

package elixir.validator.pps;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import elixir.utilities.DatabaseUtility;


public class PRMSValidator {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public PRMSValidator() {
		ResultMap.clear();
	}
	public Map<String, String> BranchKeyPress(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select * from PRMS_MBRANCH t where t.brn_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs=null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("branch_code").toString());
			 rs = stmt.executeQuery();
			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "Branch Code does not Exists!");
			} else {
				ResultMap.put("BRN_NAME", rs.getString("BRN_NAME"));
				ResultMap.put("BRN_ADDRESS", rs.getString("BRN_ADDRESS"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> EmployeeIdValidation(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT E.EMP_NAME, S.EMP_BRN_CODE || ' - '|| ( SELECT M.BRN_NAME FROM PRMS_MBRANCH M WHERE M.BRN_CODE = S.EMP_BRN_CODE) AS EMP_BRN_CODE, S.NEW_BASIC, S.DESIG" + "  FROM PRMS_EMP_SAL S"
				+ "  JOIN PRMS_EMPLOYEE E" + "    ON (S.EMP_ID = E.EMP_ID)" + " WHERE E.EMP_ID = ?";
		Connection con = ob.GetConnection();
		ResultSet rs=null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("EmployeeId").toString());
			 rs = stmt.executeQuery();
			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "Employee Id not Found!");
			} else {
				ResultMap.put("NAME", rs.getString("EMP_NAME"));
				ResultMap.put("BRANCH_CODE", rs.getString("EMP_BRN_CODE"));
				ResultMap.put("BASIC_SAL", rs.getString("NEW_BASIC"));
				ResultMap.put("DESIGNATION", rs.getString("DESIG"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> Reportlog(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.sp_log_tracing(?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("User_Id").toString());
			cstmt.setString(3, DataMap.get("P_BRANCH").toString());
			cstmt.setString(4, DataMap.get("P_YEAR").toString());
			cstmt.setString(5, DataMap.get("P_MONTH").toString());
			cstmt.setString(6, DataMap.get("P_DEDUCTION_TYPE").toString());
			cstmt.setString(7, "RPT");
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(8);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Reportlog!");
			} else
				ResultMap.put("SUCCESS", "Reportlog Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> IncentiveProcessProcessRun(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_incentive.sp_incentive_process_by_branch(?,?,?)");
			cstmt.setString(1, DataMap.get("financialYear").toString());
			cstmt.setString(2, DataMap.get("UserBranchCode").toString());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(3);
			if (error != null) {
				ResultMap.put("ERROR_MSG", " Error in IncentiveProcessProcessRun");
			} else
				ResultMap.put("SUCCESS", "Reportlog Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
}
