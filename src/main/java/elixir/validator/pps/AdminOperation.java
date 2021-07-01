package elixir.validator.pps;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import elixir.utilities.DatabaseUtility;


public class AdminOperation  {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public AdminOperation() {
		ResultMap.clear();
	}
	public Map<String, String> EmployeeInfoUpdation(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_EMPLOYEE_UPDATION(?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("new_branch").toString());
			cstmt.setString(3, DataMap.get("new_basic").toString());
			cstmt.setString(4, DataMap.get("new_designation").toString());
			cstmt.setString(5, DataMap.get("effective_date").toString());
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(6);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Updating Employee Information!");
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
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
	public Map<String, String> PfActivationIMethod(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.sp_emp_activation(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("ActivationType").toString());
			cstmt.setString(3, DataMap.get("effective_date").toString());
			cstmt.setString(4, DataMap.get("AttachedBranch").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  PF Activation Method!");
			} else
				ResultMap.put("SUCCESS", "PF Activation Successfully Updated!");
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

	public Map<String, String> AddNewEmployee(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {

			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_NEW_EMPLOYEE_INSERTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeId").toString());
			cstmt.setString(2, DataMap.get("EmployeeName").toString());
			cstmt.setString(3, DataMap.get("BranchCode").toString());
			cstmt.setString(4, DataMap.get("Designation").toString());
			cstmt.setString(5, DataMap.get("JoiningDate").toString());
			cstmt.setString(6, DataMap.get("DeptCode").toString());
			cstmt.setString(7, DataMap.get("GenderType").toString());
			cstmt.setString(8, DataMap.get("BloodGrp").toString());
			cstmt.setString(9, DataMap.get("Rhfactor").toString());
			cstmt.setString(10, DataMap.get("DOB").toString());
			cstmt.setString(11, DataMap.get("contactNo").toString());
			cstmt.setString(12, DataMap.get("TIN").toString());
			cstmt.setString(13, DataMap.get("email").toString());
			cstmt.setString(14, DataMap.get("SeniorityCode").toString());
			cstmt.setString(15, DataMap.get("Address").toString());
			cstmt.setString(16, DataMap.get("EntdBy").toString());
			cstmt.setString(17, DataMap.get("ReligionType").toString());
			cstmt.setString(18, DataMap.get("HighestDegree").toString());
			cstmt.setString(19, DataMap.get("homeDist").toString());
			cstmt.setString(20, DataMap.get("NID").toString());
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(21);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AddNewEmployee!\n" + error);
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
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
	
	public Map<String, String> FetchEmpData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DatabaseUtility ob = new DatabaseUtility();
			ResultSet rs=null;
			String sql = "SELECT EMP_BRN_CODE,      " + "       EMP_NAME," + "       DESIG_CODE ,"
					+ "       TO_CHAR(JOINING_DATE,'dd-mon-yyyy') JOINING_DATE," + "       GENDER," + "       BLOOD_GRP,"
					+ "       RHFACTOR," + "       TIN_NO," + "       EMAIL," + "       CONTACT_NO,"
					+ "       TO_CHAR(DOB,'dd-mon-yyyy') DOB," + "       ADDRESS," + "       RELIGION," + "       EMP_DEPT_CODE,"
					+ "	DESIG_SENIORITY_CODE, HIGHEST_DEGREE,HOME_DISTRICT,NID " + "  FROM PRMS_EMPLOYEE E" + "  JOIN PRMS_EMP_SAL S"
					+ "    ON (E.EMP_ID = S.EMP_ID)" + " WHERE E.EMP_ID = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
				 rs = stmt.executeQuery();
				if (rs.next()) {
					if (rs.getString("EMP_BRN_CODE").equals(DataMap.get("UserBranchCode").toString())|| DataMap.get("UserBranchCode").toString().equals("9999")) {
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
							} catch (Exception e) {
								System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
							}
						}
					} else {
						ResultMap.put("ERROR_MSG", "Employee doesn't belong to this Branch!");
					}
				}
				System.out.println(ResultMap);
			} catch (SQLException e) {
				ResultMap.put("ERROR_MSG", "Error in FetchEmpData");
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
		}		
		return ResultMap;
	}
}
