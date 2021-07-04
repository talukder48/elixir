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


public class MISDataValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public MISDataValidation() {
		ResultMap.clear();
	}
	public Map<String, String> FetchTargetMaster(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT TARGET_CODE,to_char(START_DATE, 'DD-MON-YYYY') START_DATE,to_char(END_DATE, 'DD-MON-YYYY') END_DATE,TARGET_DESCRIPTION, ACTIVE_FLAG, TARGET_REMARKS FROM target_master\r\n"
				+ " m where m.target_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("TargetCode").toString());
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
	public Map<String, String> addTargetDetails(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_mis_entry_ho.sp_target_master(?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("TargetCode").toString());
			cstmt.setString(2, DataMap.get("TargetName").toString());
			cstmt.setString(3, DataMap.get("StartDate").toString());
			cstmt.setString(4, DataMap.get("EndDate").toString());
			cstmt.setString(5, DataMap.get("activation").toString());
			cstmt.setString(6, DataMap.get("Targetremarks").toString());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS",
						"Target :" + DataMap.get("TargetName").toString() + " is Successfully Updated!");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", " Error in addTargetDetails");
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
	
	public Map<String, String> FetchBranchData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT listagg(BRANCH_OFFICE, ',') WITHIN GROUP(ORDER BY BRANCH_OFFICE) BRANCH_OFFICE\r\n" + 
				"  from (SELECT BRANCH_OFFICE\r\n" + 
				"          FROM (SELECT g.branch_off_code || ':' || (SELECT b.brn_name FROM prms_mbranch b where b.brn_code=G.branch_off_code) BRANCH_OFFICE\r\n" + 
				"                  FROM zonal_branch_mapping g\r\n" + 
				"                 where G.ZONAL_OFF_CODE = ?))";			
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("BranchCode").toString());
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
	
	public Map<String, String> FetchSenctionAndDisburseData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_loan_sanction_disburse m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	
	public Map<String, String> FetchTargetData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_goal_setup s where s.target_code=?\r\n" + 
					"and s.branch_code=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("TargetCode").toString());	
				stmt.setString(2, DataMap.get("BranchCode").toString());
				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	
	public Map<String, String> FetchLoanRecoveryData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_loan_recovery  m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	public Map<String, String> FetchAuditDisposalData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_audit_ob_disposal  m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	public Map<String, String> FetchKharidaBariData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_kharidabari  m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	public Map<String, String> FetchCourtCaseSettlementData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_court_case_settle  m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	public Map<String, String> FetchFaultyLoanData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
			DatabaseUtility ob = new DatabaseUtility();
			String sql = "SELECT * FROM mis_faulty_ln_case  m where m.branch_code=? and m.entry_date=?";
			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("BranchCode").toString());
				stmt.setString(2, DataMap.get("EntyDate").toString());				
				rs = stmt.executeQuery();
				if (rs.next()) {
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
	
	
	public Map<String, String> AddSanctionDisburseData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_LOAN_SANCTION_DISBURSE(?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, "0");
			cstmt.setString(4, "0");
			cstmt.setString(5, DataMap.get("ZeroEquityDisburse").toString());
			cstmt.setString(6, DataMap.get("OthersDisburse").toString());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			 ResultMap.put("ERROR_MSG", " Error in AddSanctionDisburseData");
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
	
	
	public Map<String, String> AddLoanRecoveryData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_LOAN_RECOVERY(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, DataMap.get("CLAmount").toString());
			cstmt.setString(4, DataMap.get("UCAmount").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", " Error in AddLoanRecoveryData: ");
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
	
	
	public Map<String, String> AddCourtCaseSettlementData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_CC_SETTLEMENT(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, DataMap.get("ExecutiveCase").toString());
			cstmt.setString(4, DataMap.get("MiscCase").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG",error);
			} else
				
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", " Error in AddCourtCaseSettlementData ");
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
	
	public Map<String, String> AddKharidabariData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_LOAN_KHARIDABARI(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, DataMap.get("Possession").toString());
			cstmt.setString(4, DataMap.get("SaleCase").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG",  error);
			} else
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			  ResultMap.put("ERROR_MSG", " Error in AddKharidabariData" );
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
	
	public Map<String, String>  AddDisposalAuditObjection(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_LOAN_AUDIT_OBJECTION(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, DataMap.get("CommercialAudit").toString());
			cstmt.setString(4, DataMap.get("PostAudit").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG",  error);
			} else
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", " Error in AddCourtCaseSettlementData");
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
	
	public Map<String, String> AddFaultyLoanCaseData(Map DataMap) {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_MIS_ENTRY.SP_DEED_RETURN_FL(?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("EntyDate").toString());
			cstmt.setString(3, DataMap.get("LoanCaseNumber").toString());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(4);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Record Successfully Completed!");
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", " Error in AddFaultyLoanCaseData");
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
	
	public Map<String, String> TargetValueSetup(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			String query = " update mis_goal_setup \r\n" + 
					"   set ZERO_EQ_SANCTION       = ?,\r\n" + 
					"       OTHS_PD_SANCTION       = ?,\r\n" + 
					"       ZERO_EQ_DISBURSE       = ?,\r\n" + 
					"       OTHS_PD_DISBURSE       = ?,\r\n" + 
					"       LOAN_UC_RECOVERY       = ?,\r\n" + 
					"       LOAN_CL_RECOVERY       = ?,\r\n" + 
					"       AUDIT_COMMERCIAL       = ?,\r\n" + 
					"       AUDIT_POST_AUDIT       = ?,\r\n" + 
					"       KHARIDABARI_PROCESSION = ?,\r\n" + 
					"       KHARIDABARI_SALE       = ?,\r\n" + 
					"       SETTLE_EXECUTIVE_CASE  = ?,\r\n" + 
					"       SETTLE_WRIT_CASE       = ?,\r\n" + 
					"       DEED_RETURN_FL         = ?\r\n" + 
					" where TARGET_CODE = ?\r\n" + 
					"   and BRANCH_CODE = ?";
			
			stmt = con.prepareStatement(query);
			stmt.setString(1, DataMap.get("ZeroEquitySanction").toString());
			stmt.setString(2, DataMap.get("OthersSanction").toString());
			stmt.setString(3, DataMap.get("ZeroEquityDisburse").toString());
			stmt.setString(4, DataMap.get("OthersDisburse").toString());
			stmt.setString(5, DataMap.get("UCAmount").toString());
			stmt.setString(6, DataMap.get("CLAmount").toString());
			stmt.setString(7, DataMap.get("CommercialAudit").toString());
			stmt.setString(8, DataMap.get("PostAudit").toString());
			stmt.setString(9, DataMap.get("Possession").toString());
			stmt.setString(10, DataMap.get("SaleCase").toString());
			stmt.setString(11, DataMap.get("ExecutiveCase").toString());
			stmt.setString(12, DataMap.get("MiscCase").toString());
			stmt.setString(13, DataMap.get("LoanCaseNumber").toString());
			stmt.setString(14, DataMap.get("TargetCode").toString());
			stmt.setString(15, DataMap.get("BranchCode").toString());
			stmt.executeUpdate();

			ResultMap.put("SUCCESS", "Data Sucessfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating TargetValueSetup");
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
