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

import elixir.utilities.AESEncrypt;
import elixir.utilities.DatabaseUtility;

public class LoginValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	private static String secretKey = "DarkHorse";

	public LoginValidation() {
		ResultMap.clear();
	}
	
	public Map<String, String> FetchUserData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select * from erp_user t where t.user_id=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("UserId").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			} 

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
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
	public Map<String, String> UserCreationFunction(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_user.sp_user_creation(?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("UserId").toString());
			cstmt.setString(2, DataMap.get("userName").toString());
			cstmt.setString(3, DataMap.get("UserRole").toString());
			cstmt.setString(4, DataMap.get("branch_code").toString());
			cstmt.setString(5, AESEncrypt.encrypt(DataMap.get("UserPass").toString(), secretKey));
			cstmt.setString(6, DataMap.get("checkRole").toString());
			cstmt.setString(7, DataMap.get("AuthRole").toString());
			cstmt.setString(8, DataMap.get("loggeduser").toString());
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(9);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "User Sucessfully Created/update for this " + DataMap.get("UserId").toString());
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
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

	public Map<String, String> UserIdValidation(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select * from erp_user t where t.user_id=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("user").toString());
			rs = stmt.executeQuery();
			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "User not Found!");
			} else {
				ResultMap.put("USER_ROLE", rs.getString("USER_ROLE").trim());
				ResultMap.put("USER_NAME", rs.getString("USER_NAME"));
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
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

	public Map<String, String> ValidateOldPassword(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "select * from erp_user t where t.user_id=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("UserId").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				String password = rs.getString("USER_PASSWORD");
				if (!password.equals(AESEncrypt.encrypt(DataMap.get("currPassword").toString(), secretKey))) {
					ResultMap.put("ERROR_MSG", "Wrong Password");
				}
			}
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
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

	public Map<String, String> UserCreation(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		PreparedStatement stmt1 = null;
		String sql = "select USER_ID, USER_NAME, USER_PASSWORD  from prms_user m where m.user_id not in('S9999' ,'F9999') ";
		ResultSet rs = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			while (rs.next()) {
				String SQL = "UPDATE erp_user U SET U.USER_PASSWORD = ? WHERE U.USER_ID= ?";
				stmt1 = con.prepareStatement(SQL);
				stmt1.setString(1, AESEncrypt.encrypt(rs.getString("USER_PASSWORD").toString(), secretKey));
				stmt1.setString(2, rs.getString("USER_ID").toString());
				stmt1.executeUpdate();
				System.out.println(rs.getString("USER_PASSWORD").toString() + "-"
						+ AESEncrypt.encrypt(rs.getString("USER_PASSWORD").toString(), secretKey));
			}
		} catch (Exception e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				stmt1.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> ResetPassword(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String SQL = "UPDATE erp_user U SET U.USER_PASSWORD = ? WHERE U.USER_ID= ?";
			stmt = con.prepareStatement(SQL);
			stmt.setString(1, AESEncrypt.encrypt(DataMap.get("newPassword").toString(), secretKey));
			stmt.setString(2, DataMap.get("UserId").toString());
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Password Sucessfully Updated");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	/*
	 * public Map <String, String> PasswordValidation() {
	 * 
	 * DatabaseUtility ob = new DatabaseUtility(); String sql =
	 * "select * from erp_user t where t.user_id=? and "; Connection con =
	 * ob.GetConnection(); PreparedStatement stmt = null; try { stmt =
	 * con.prepareStatement(sql); stmt.setString(1, DataMap.get("user").toString());
	 * ResultSet rs = stmt.executeQuery(); if (!rs.next()) { DataMap.put("error",
	 * "User not Found!"); } } catch (SQLException e) { e.printStackTrace(); } }
	 */

	public Map<String, String> LoginMethod(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		DatabaseUtility db = new DatabaseUtility();
		Connection con = db.GetConnection();
		ResultSet rs = null;
		String sql = "SELECT T.USER_ID, T.USER_NAME,(SELECT BRAN_CAT_CODE  \n" + 
				" FROM prms_mbranch  b where b.brn_code=t.user_branch) br_type, T.USER_BRANCH,CHECK_ROLE	,AUTH_ROLE, T.USER_ROLE, (SELECT M.BRN_NAME FROM PRMS_MBRANCH M WHERE M.BRN_CODE = T.USER_BRANCH) BRN_NAME FROM erp_user T WHERE T.USER_ID=? AND T.USER_PASSWORD=?";
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("user").toString());
			/*
			 * if(DataMap.get("user").equals("S9999")) { stmt.setString(2,
			 * AESEncrypt.encrypt(DataMap.get("password").toString(), secretKey)); } else {
			 * stmt.setString(2, DataMap.get("password").toString()); }
			 */
			stmt.setString(2, AESEncrypt.encrypt(DataMap.get("password").toString(), secretKey));
			// stmt.setString(2, DataMap.get("password").toString());
			rs = stmt.executeQuery();
			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "User Id Or Password not Valid!");
			} else {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> LogOut(Map DataMap) {
		return ResultMap;
	}
}
