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

public class PensionValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public PensionValidation() {
		ResultMap.clear();
	}
	
	public Map<String, String> FetchPensionEmployeeData(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT P.NOTHI_NUM, P.ENOTHI_NUM,EMP_ID,EMP_NAME,GENDER,DESIGNATION_CODE, TIN_NO,EMAIL, CONTACT_NO, TO_CHAR(decode(DOB, '', SYSDATE - 365 * 60, DOB), 'dd-mon-yyyy') DOB, to_char(DECODE(prl_date, '', SYSDATE, prl_date), 'dd-mon-yyyy') prl_date, ADDRESS,RELIGION,HIGHEST_DEGREE,HOME_DISTRICT, NID,BANK_NAME,BRANCH_NAME, ACCOUNT_NUM, ACTIVATION_TYPE,BRANCH_DISTRICT,PRADDRESS,PENSIONER_TYPE \r\n" + 
				"  FROM PEN_EMPLOYEE P\r\n" + 
				" WHERE P.ENTITY_NUM = 1\r\n" + 
				"   AND P.NOTHI_NUM = ?";		
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("NothiNo").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
					ResultSetMetaData rsmd = rs.getMetaData();
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						try {
							ResultMap.put(rsmd.getColumnName(i),StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
						} catch (Exception e) {
							System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
						}
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
		return ResultMap;
	}
	
	public Map<String, String> AddPensionEmployee(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_pension.sp_add_pension_info(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("NothiNo").toString());
			cstmt.setString(3, DataMap.get("eNothiNo").toString());
			cstmt.setString(4, DataMap.get("EmployeeId").toString());
			cstmt.setString(5, DataMap.get("EmployeeName").toString());
			cstmt.setString(6, DataMap.get("PRLDate").toString());			
			cstmt.setString(7, DataMap.get("Designation").toString());
			cstmt.setString(8, DataMap.get("GenderType").toString());
			cstmt.setString(9, DataMap.get("ReligionType").toString());
			cstmt.setString(10, DataMap.get("DOB").toString());
			cstmt.setString(11, DataMap.get("contactNo").toString());	
			cstmt.setString(12, DataMap.get("homeDist").toString());
			cstmt.setString(13, DataMap.get("NID").toString());
			cstmt.setString(14, DataMap.get("email").toString());			
			cstmt.setString(15, DataMap.get("Address").toString());
			cstmt.setString(16, DataMap.get("bankName").toString());			
			cstmt.setString(17, DataMap.get("BranchName").toString());
			cstmt.setString(18, DataMap.get("BankAccount").toString());
			cstmt.setString(19, DataMap.get("ActivationType").toString());			
			cstmt.setString(20, DataMap.get("PrAddress").toString());
			cstmt.setString(21, DataMap.get("BranchDistrict").toString());
			cstmt.setString(22, DataMap.get("PensionType").toString());
			cstmt.setString(23, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(24);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AddPensionEmployee!");
			} else
				ResultMap.put("SUCCESS", "Data Update Successfully for nothi no : "+DataMap.get("NothiNo").toString());
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
	
	public Map<String, String> AddPensionInharitance(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_pension.sp_add_inharitance_info(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("NothiNo").toString());
			cstmt.setString(3, DataMap.get("SerialNo").toString());
			cstmt.setString(4, DataMap.get("BenificiaryName").toString());
			cstmt.setString(5, DataMap.get("PensionType").toString());
			cstmt.setString(6, DataMap.get("HandicapType").toString());			
			cstmt.setString(7, DataMap.get("pctPenAmt").toString());
			cstmt.setString(8, DataMap.get("PenAmt").toString());
			cstmt.setString(9, DataMap.get("DOB").toString());
			cstmt.setString(10, DataMap.get("contactNo").toString());
			cstmt.setString(11, DataMap.get("homeDist").toString());	
			cstmt.setString(12, DataMap.get("NID").toString());
			cstmt.setString(13, DataMap.get("email").toString());			
			cstmt.setString(14, DataMap.get("Address").toString());			
			cstmt.setString(15, DataMap.get("ActivationType").toString());				
			cstmt.setString(16, DataMap.get("bankName").toString());			
			cstmt.setString(17, DataMap.get("BranchName").toString());
			cstmt.setString(18, DataMap.get("BankAccount").toString());	
			cstmt.setString(19, DataMap.get("PrAddress").toString());
			cstmt.setString(20, DataMap.get("BranchDistrict").toString());				
			cstmt.setString(21, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			
			cstmt.execute();
			String error = cstmt.getString(22);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AddPensionInharitance!");
			} else
				ResultMap.put("SUCCESS", "Data Update Successfully for nothi no : "+DataMap.get("NothiNo").toString()+" Serial No: " +DataMap.get("SerialNo").toString());
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
			
	public Map<String, String> FetchPensionInharitance(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select BENIFICIARYNAME,RELATIONTYPE,SUCC_ACC_ACTIVE,DISTRICT,EMAIL,CONTACT_NO,ADDRESS,HANDICAP,HIGHEST_DEGREE,HOME_DISTRICT,NID,PENSION_PCT,PENSION_AMT,BANK_NAME,BRANCH_NAME,BANK_ACCOUNT,to_char(DECODE(DOB,'',TRUNC(SYSDATE-365*50),DOB),'DD-MON-YYYY')DOB,BRANCH_DISTRICT,PRADDRESS from pen_inheritance i  where i.nothi_num=? and i.successor_sl=?";		
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("NothiNo").toString());
			stmt.setString(2, DataMap.get("SerialNo").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
					ResultSetMetaData rsmd = rs.getMetaData();
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						try {
							ResultMap.put(rsmd.getColumnName(i),StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
						} catch (Exception e) {
							System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
						}
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
		return ResultMap;
	}
	
	public Map<String, String> FetchPensionCalculationData(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select e.emp_name,c.* from pen_calculation_data c join pen_employee e  on(c.entity_num=e.entity_num and c.nothi_num=e.nothi_num)  where c.entity_num=1 and c.nothi_num=?";		
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("NothiNo").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
					ResultSetMetaData rsmd = rs.getMetaData();
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						try {
							ResultMap.put(rsmd.getColumnName(i),StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
						} catch (Exception e) {
							System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
						}
					}				
			}
			else
			{
				ResultMap.put("ERROR_MSG", "No Data Found for Nothi no: "+ DataMap.get("NothiNo").toString());
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
	
	public Map<String, String> addPenAllowanceData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String query = "update pen_calculation_data\r\n" + "   set PENSION_AMT      = ?,\r\n"
					+ "       PENSION_AREAR    = ?,\r\n" + "       MEDICAL_AMT      = ?,\r\n"
					+ "       MEDICAL_ARR      = ?,\r\n" + "       BONUS            = ?,\r\n"
					+ "       BONUS_ARR        = ?,\r\n" + "       OTHERS_ALW       = ?,\r\n"
					+ "       REMRKS_OTHER_ALW = ?,\r\n" + "	   NOBORSHO		    =?,\r\n"
					+ "		  DEARNESS		   =?, \r\n" + "	   ARR_DEARNESS		=?" + " where ENTITY_NUM = 1\r\n"
					+ "   and NOTHI_NUM = ?\r\n" + "";
			stmt = con.prepareStatement(query);
			stmt.setString(1, DataMap.get("PensionAmt").toString());
			stmt.setString(2, DataMap.get("ArearPensionAmt").toString());
			stmt.setString(3, DataMap.get("MedicalAlw").toString());
			stmt.setString(4, DataMap.get("ArearMedicalAlw").toString());
			stmt.setString(5, DataMap.get("BonusAmt").toString());
			stmt.setString(6, DataMap.get("ArearBonus").toString());
			stmt.setString(7, DataMap.get("OthersAlw").toString());
			stmt.setString(8, DataMap.get("Remarks").toString());			
			stmt.setString(9, DataMap.get("Noboborsho").toString());
			stmt.setString(10, DataMap.get("Dearness").toString());
			stmt.setString(11, DataMap.get("ArrDearness").toString());			
			stmt.setString(12, DataMap.get("NothiNo").toString());
			stmt.executeUpdate();

			ResultMap.put("SUCCESS",
					"Allowance Sucessfully Updated for nothi no: " + DataMap.get("NothiNo").toString());
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Allowance");
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

	public Map<String, String> AddPenDeductionData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String query = "update pen_calculation_data\r\n" + "   set HB_DED           = ?,\r\n"
					+ "       COM_DED          = ?,\r\n" + "       MOT_DED          = ?,\r\n"
					+ "       OTHERS_DED       = ?,\r\n" + "       REMRKS_OTHER_DED = ?,\r\n"
					+ "       REVINUE          = ?\r\n" + " where ENTITY_NUM = 1\r\n" + "   and NOTHI_NUM = ?";
			stmt = con.prepareStatement(query);
			stmt.setString(1, DataMap.get("HBDed").toString());
			stmt.setString(2, DataMap.get("ComputerDed").toString());
			stmt.setString(3, DataMap.get("MotorDed").toString());
			stmt.setString(4, DataMap.get("OthersDed").toString());
			stmt.setString(5, DataMap.get("Remarks").toString());
			stmt.setString(6, DataMap.get("Revenue").toString());
			stmt.setString(7, DataMap.get("NothiNo").toString());
			stmt.executeUpdate();

			ResultMap.put("SUCCESS",
					"Deduction Sucessfully Updated for nothi no: " + DataMap.get("NothiNo").toString());
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Allowance");
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
