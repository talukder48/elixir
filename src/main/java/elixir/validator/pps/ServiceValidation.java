package elixir.validator.pps;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import elixir.utilities.DatabaseUtility;


public class ServiceValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public ServiceValidation() {
		ResultMap.clear();
	}
	public Map<String, String> FetchAccountDetails(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("LocationCode").toString().equals(null) || DataMap.get("LocationCode").toString().equals("")
				|| DataMap.get("LocationCode").toString() == "" || DataMap.get("LocationCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT LOC_CODE,LOAN_CASE,LN_CATAGORY,LOAN_CODE,BORROWER_NAME,LN_TYPE, PROD_NATURE,SITE_ADD,ADDRESS,decode(EMAIL_ID,'','NF',EMAIL_ID)EMAIL_ID,decode(PHONE_NUMBER,'','NF',PHONE_NUMBER)PHONE_NUMBER \r\n" + 
					"  FROM SS_LOANACC_DATA\r\n" + 
					" where LOC_CODE = ?\r\n" + 
					"   and LOAN_CASE = ?\r\n" + 
					"   and LN_CATAGORY = ?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("LocationCode").toString());
				stmt.setString(2, DataMap.get("LoanAcc").toString());
				stmt.setString(3, DataMap.get("LocationCatagory").toString());
				
				rs = stmt.executeQuery();
				if (!rs.next()) {
					ResultMap.put("ERROR_MSG", "Loan Account Does not Exist!!(Upto 2019-2020 Final Closing)");
				} else {					
						ResultSetMetaData rsmd = rs.getMetaData();
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							try {
								ResultMap.put(rsmd.getColumnName(i),
										StringUtils.isBlank(rs.getObject(i).toString()) ? ""
												: rs.getObject(i).toString());
							} catch (Exception e) {
								//System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
								e.printStackTrace();
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
		}
		return ResultMap;
	}
	public Map<String, String> UpdateBorrowerDeduction(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "UPDATE SS_LOANACC_DATA  SET EMAIL_ID=? , PHONE_NUMBER=?\r\n" + 
				" WHERE LOC_CODE = ?\r\n" + 
				"   AND LOAN_CASE =?\r\n" + 
				"   AND LN_CATAGORY = ? ";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("MailAddress").toString());
			stmt.setString(2, DataMap.get("PhoneAddress").toString());
			stmt.setString(3, DataMap.get("LocationCode").toString());
			stmt.setString(4, DataMap.get("LoanAcc").toString());
			stmt.setString(5, DataMap.get("LocationCatagory").toString());
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Borrower Email and Phone number Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating Borrower Email and Phone number");
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
	
	public Map<String, String> BulkMessageService(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		String sucessMessage = BulkSMSService.sendsms("8801515240013", "বাংলাদেশ হাউস বিল্ডিং ফাইনান্স কর্পোরেশন");
		if (sucessMessage.equals("ok")) {
			ResultMap.put("ERROR_MSG", "Message Does not Sent Sucessfully");			
		} else {
			ResultMap.put("SUCCESS", "Message Sent Sucessfully");
		}
		return ResultMap;
	}

	
}
