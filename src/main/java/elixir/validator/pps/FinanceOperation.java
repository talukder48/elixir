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


public class FinanceOperation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public FinanceOperation() {
		ResultMap.clear();
	}

	public Map<String, String> UpdateInitProfile(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String sql1 = "UPDATE PRMS_EMP_SAL E SET E.NEW_BASIC=?,E.PF_DEDUCTION_PCT=?,E.BANK_ACC=?,ACC_NO_ACTIVE='Y' WHERE E.EMP_ID=?";
			stmt = con.prepareStatement(sql1);
			stmt.setString(1, DataMap.get("basicPay").toString());
			stmt.setString(2, DataMap.get("PFDeduct").toString());
			stmt.setString(3, DataMap.get("bankACNo").toString());
			stmt.setString(4, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();

			String sql2 = "UPDATE PRMS_EMP_SAL_HIST E SET E.NEW_BASIC=?, E.PF_DEDUCTION_PCT=?, E.BANK_ACC=?,ACC_NO_ACTIVE='Y' WHERE E.EMP_ID=?"
					+ " AND E.EFT_SERIAL=(SELECT MAX(E.EFT_SERIAL) FROM PRMS_EMP_SAL_HIST E WHERE E.EMP_ID=?)";
			stmt = con.prepareStatement(sql2);
			stmt.setString(1, DataMap.get("basicPay").toString());
			stmt.setString(2, DataMap.get("PFDeduct").toString());
			stmt.setString(3, DataMap.get("bankACNo").toString());
			stmt.setString(4, DataMap.get("EmployeeId").toString());
			stmt.setString(5, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();

			String sql3 = "UPDATE PRMS_DEDUC D  SET D.INCOME_TAX=? WHERE D.EMP_ID=?";
			stmt = con.prepareStatement(sql3);
			stmt.setString(1, DataMap.get("taxDeduct").toString());
			stmt.setString(2, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Data Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Employee's Profile");
			e.printStackTrace();
		} finally {
			try {
				con.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> UpdateAllowance(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String query = "UPDATE PRMS_ALLOWANCE" + "   SET TEL_ALLOWANCE       = ?,"
					+ "       TRANS_ALLOWANCE     = ?," + "       EDU_ALLOWANCE       = ?,"
					+ "       WASH_ALLOWANCE      = ?," + "       ENTERTAIN_ALLOWANCE = ?,"
					+ "       DOMES_ALLOWANCE     = ?," + "       OTHER_ALLOWANCE     = ?,"
					+ "       HILL_ALLWNC         = ?," + "       ARREAR              = ?,"
					+ "       REMARKS             = ?," + "		  HR_AREAR_ALW		  = ?"
					+ " WHERE EMP_ID = ?";
			stmt = con.prepareStatement(query);
			stmt.setString(1, DataMap.get("telephone").toString());
			stmt.setString(2, DataMap.get("transport").toString());
			stmt.setString(3, DataMap.get("education").toString());
			stmt.setString(4, DataMap.get("wash").toString());
			stmt.setString(5, DataMap.get("entertainment").toString());
			stmt.setString(6, DataMap.get("domestic").toString());
			stmt.setString(7, DataMap.get("others").toString());
			stmt.setString(8, DataMap.get("hillAllwnc").toString());
			stmt.setString(9, DataMap.get("arrear").toString());
			stmt.setString(10, DataMap.get("remarksOthers").toString());
			stmt.setString(11, DataMap.get("arrearHR").toString());
			stmt.setString(12, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();

			String SQL = "UPDATE PRMS_EMP_SAL " + "   SET ARREAR_BASIC= ?" + " WHERE EMP_ID = ?";
			stmt = con.prepareStatement(SQL);
			stmt.setString(1, DataMap.get("arrearBasic").toString());
			stmt.setString(2, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();

			ResultMap.put("SUCCESS", "Data Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Employee's Allowance");
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> UpdateDeduction(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "UPDATE PRMS_DEDUC" + "   SET CAR_FARE            = ?," + "       CAR_USE             = ?,"
				+ "       GAS_BILL            = ?," + "       WATER_BILL          = ?,"
				+ "       ELECT_BILL          = ?," + "       NEWS_PAPER          = ?,"
				+ "       COMP_DEDUC          = ?," + "       MCYCLE_DEDUC        = ?,"
				+ "       TEL_EXCESS_BILL     = ?," + "       HBADV_DEDUC_PERCENT = ?,"
				+ "		  HB_ADV_DEDUC		  = ?," + " 	  PFADV_DEDUC		  = ?,"
				+ "       OTHER_DEDUC         = ?," + "       REMARKS             = ?" + ",HR_AREAR_DED=?  WHERE EMP_ID = ? ";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("carFare").toString());
			stmt.setString(2, DataMap.get("carUse").toString());
			stmt.setString(3, DataMap.get("gasBill").toString());
			stmt.setString(4, DataMap.get("waterBill").toString());
			stmt.setString(5, DataMap.get("electricBill").toString());
			stmt.setString(6, DataMap.get("newspaper").toString());
			stmt.setString(7, DataMap.get("computer").toString());
			stmt.setString(8, DataMap.get("motorcycle").toString());
			stmt.setString(9, DataMap.get("telephoneExcess").toString());
			stmt.setString(10, DataMap.get("hbAdvPct").toString());			
			stmt.setString(11, DataMap.get("hbAdvManual").toString());
			stmt.setString(12, DataMap.get("pfAdvance").toString());			
			stmt.setString(13, DataMap.get("others").toString());
			stmt.setString(14, DataMap.get("remarksOthers").toString());
			stmt.setString(15, DataMap.get("arearHR").toString());
			stmt.setString(16, DataMap.get("EmployeeId").toString());
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Data Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Employee's Deduction");
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}


	public Map<String, String> FetchEmpInitData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT (SELECT EM.EMP_NAME FROM PRMS_EMPLOYEE EM WHERE EM.EMP_ID = E.EMP_ID) EMP_NAME, E.NEW_BASIC,"
					+ " (SELECT S.EMP_BRN_CODE FROM PRMS_EMP_SAL S WHERE S.EMP_ID = E.EMP_ID) EMP_BRN_CODE,"
					+ " (SELECT NVL(D.INCOME_TAX, 0) FROM PRMS_DEDUC D WHERE D.EMP_ID = E.EMP_ID) TAX,"
					+ " NVL(E.PF_DEDUCTION_PCT, 0) PF_DEDUCTION_PCT," + " E.BANK_ACC" + " FROM PRMS_EMP_SAL E"
					+ " WHERE E.EMP_ID = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
				rs = stmt.executeQuery();
				if (!rs.next()) {
					ResultMap.put("ERROR_MSG", "Employee Id not Found!");
				} else {
					if (rs.getString("EMP_BRN_CODE").equals(DataMap.get("UserBranchCode").toString())
							|| DataMap.get("UserBranchCode").toString().equals("9999")) {
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? ""
												: rs.getObject(i).toString());
							} catch (Exception e) {
								System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
							}
						}
					} else {
						ResultMap.put("ERROR_MSG", "Employee doesn't belong to this Branch!");
					}
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
		}
		return ResultMap;
	}

	public Map<String, String> FetchAllowanceData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DatabaseUtility ob = new DatabaseUtility();
			ResultSet rs =null;
			ResultSetMetaData rsmd=null;
			String sql = "SELECT (SELECT EM.EMP_NAME FROM PRMS_EMPLOYEE EM WHERE EM.EMP_ID = D.EMP_ID) EMP_NAME,"
					+ " (SELECT S.EMP_BRN_CODE FROM PRMS_EMP_SAL S WHERE S.EMP_ID = D.EMP_ID) EMP_BRN_CODE,"
					+ "NVL(TEL_ALLOWANCE, 0) TEL_ALLOWANCE,NVL(TRANS_ALLOWANCE, 0) TRANS_ALLOWANCE, NVL(EDU_ALLOWANCE, 0) EDU_ALLOWANCE,"
					+ "NVL(WASH_ALLOWANCE, 0) WASH_ALLOWANCE,NVL(PENSION_ALLOWANCE, 0) PENSION_ALLOWANCE,"
					+ "NVL(ENTERTAIN_ALLOWANCE, 0) ENTERTAIN_ALLOWANCE,NVL(DOMES_ALLOWANCE, 0) DOMES_ALLOWANCE,NVL(HILL_ALLWNC,0) HILL_ALLWNC,"
					+ "NVL(OTHER_ALLOWANCE, 0) OTHER_ALLOWANCE,NVL(ARREAR, 0) ARREAR,REMARKS,(SELECT NVL(S.ARREAR_BASIC,0) FROM PRMS_EMP_SAL S WHERE S.EMP_ID=D.EMP_ID) ARREAR_BASIC "
					+ ",NVL(HR_AREAR_ALW,0) HR_AREAR_ALW FROM PRMS_ALLOWANCE D" + " WHERE D.EMP_ID = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
				 rs = stmt.executeQuery();
				if (!rs.next()) {
					ResultMap.put("ERROR_MSG", "Employee Id not Found!");
				} else {
					if (rs.getString("EMP_BRN_CODE").equals(DataMap.get("UserBranchCode").toString()) || DataMap.get("UserBranchCode").toString().equals("9999")) {
						 rsmd = rs.getMetaData();
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
		}		
		return ResultMap;
	}

	public Map<String, String> FetchDeductionData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		if (DataMap.get("UserBranchCode").toString().equals(null) || DataMap.get("UserBranchCode").toString().equals("")
				|| DataMap.get("UserBranchCode").toString() == "" || DataMap.get("UserBranchCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT (SELECT EMP_NAME FROM PRMS_EMPLOYEE WHERE EMP_ID = D.EMP_ID) EMP_NAME,"
					+ "		  NVL(CAR_FARE, 0) CAR_FARE," + "       NVL(CAR_USE, 0) CAR_USE,"
					+ "       NVL(GAS_BILL, 0) GAS_BILL," + "       NVL(WATER_BILL, 0) WATER_BILL,"
					+ "       NVL(ELECT_BILL, 0) ELECT_BILL," + "       NVL(NEWS_PAPER, 0) NEWS_PAPER,"
					+ "       NVL(COMP_DEDUC, 0) COMP_DEDUC," + "       NVL(MCYCLE_DEDUC, 0) MCYCLE_DEDUC,"
					+ "		  NVL(HB_ADV_DEDUC,0)	HB_ADV_DEDUC, NVL(PFADV_DEDUC	,0)	 PFADV_DEDUC,"
					+ "       NVL(TEL_EXCESS_BILL, 0) TEL_EXCESS_BILL,"
					+ "       NVL(HBADV_DEDUC_PERCENT, 0) HBADV_DEDUC_PERCENT," + "       NVL(OTHER_DEDUC, 0) OTHER_DEDUC,"
					+ "       REMARKS,"
					+ "		  (SELECT S.EMP_BRN_CODE FROM PRMS_EMP_SAL S WHERE S.EMP_ID = D.EMP_ID) EMP_BRN_CODE"
					+ ", NVL(HR_AREAR_DED,0) HR_AREAR_DED  FROM PRMS_DEDUC D" + " WHERE EMP_ID = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("EmployeeId").toString());
				ResultSet rs = stmt.executeQuery();
				if (!rs.next()) {
					ResultMap.put("ERROR_MSG", "Employee Id not Found!");
				} else {
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
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
		}		
		return ResultMap;
	}
	
	
	
	public Map<String, String> FetchIncentiveData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_incentive.sp_get_incentiveData(?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("LocationCode").toString());
			cstmt.setString(2, DataMap.get("EmployeeID").toString());
			cstmt.setString(3, DataMap.get("FinanYear").toString());			
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);	
			cstmt.execute();
			String error = cstmt.getString(9);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else {				
				ResultMap.put("CURRENT_BASIC", cstmt.getString(4));
				ResultMap.put("INCENTIVE_BASIC", cstmt.getString(5));
				ResultMap.put("TOTAL_INCENTIVE", cstmt.getString(6));
				ResultMap.put("EMPLOYEE_NAME", cstmt.getString(7));
				ResultMap.put("INCENTIVE_PCT", cstmt.getString(8));				
			}
				
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
	
	public Map<String, String> UpdateIncentiveData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_incentive.sp_update_incentivce_Data(?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("EmployeeID").toString());
			cstmt.setString(2, DataMap.get("LocationCode").toString());
			cstmt.setString(3, DataMap.get("FinanYear").toString());
			cstmt.setString(4, DataMap.get("IncentiveBasic").toString());
			cstmt.setString(5, DataMap.get("IncentivePct").toString());
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);	
			cstmt.execute();
			String error = cstmt.getString(6);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else {				
				ResultMap.put("SUCCESS", "Incentive Data Sucessfully Updated for PF no :"+ DataMap.get("EmployeeID").toString());		
			}
				
		} catch (SQLException e) {
			
			ResultMap.put("ERROR_MSG", "Error in UpdateIncentiveData" );
			e.printStackTrace();
		} finally {
			try {
				con.commit();
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	
	public Map<String, String> UpdateUserFeedback(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String sql = "INSERT INTO PRMS_FEEDBACK VALUES(?,?,?,?,?,?,?,?)";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("entityNum").toString());
			stmt.setString(2, DataMap.get("branchCode").toString());
			stmt.setString(3, DataMap.get("year").toString());
			stmt.setString(4, DataMap.get("monthCode").toString());
			stmt.setString(5, DataMap.get("feedbackType").toString());
			stmt.setString(6, DataMap.get("userID").toString());
			stmt.setString(7, DataMap.get("entd_on").toString());
			stmt.setString(8, DataMap.get("remarks").toString());
			stmt.executeQuery();

			ResultMap.put("SUCCESS", "Data Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in UpdateUserFeedback! \nMay be you've already given feedback for this month!");
			e.printStackTrace();
		} finally {
			try {
				con.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
}
