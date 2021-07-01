package elixir.validator.pps;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Map;
import java.util.StringTokenizer;

import elixir.utilities.DatabaseUtility;
import elixir.utilities.ProjectUtils;

public class GeneralAccontingSystem {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public GeneralAccontingSystem(){
		ResultMap.clear();
	}

	public Map<String, String> VoucherEntryMethod( Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		LinkedList<Map> GridMap = new LinkedList<Map>();		
		GridMap = ProjectUtils.TransactionSplite(DataMap.get("gridData").toString());
		
		DatabaseUtility ob = new DatabaseUtility();
		int batch_no = 0;
		Double BatchDr=(double) 0.00f;
		Double BatchCr=(double) 0.00f;
		Double TransactionDebit=(double) 0.00f;
		Double TransactionCredit=(double) 0.00f;
		PreparedStatement _stmt = null;
		
		if (DataMap.get("loggedBranch").toString().equals("")||DataMap.get("loggedBranch").toString()==null||DataMap.get("loggedBranch").toString()=="") {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Prease log In Again");
		}
		if (Double.parseDouble(DataMap.get("TransactionAmtDr").toString())<=0) {
			ResultMap.put("ERROR_MSG", "Total Debit must be greater then Zero");
		}
		else if (Double.parseDouble(DataMap.get("TransactionAmtCR").toString())<=0) {
			ResultMap.put("ERROR_MSG", "Total Credit must be greater then Zero");
		}					
		else if (Double.parseDouble(DataMap.get("TransactionAmtDr").toString()) != Double
				.parseDouble(DataMap.get("TransactionAmtCR").toString())) {
			ResultMap.put("ERROR_MSG", "Total Debit & Credit Amount Must be same");
		}
		else
		{			
			TransactionDebit=new BigDecimal(Double.parseDouble(DataMap.get("TransactionAmtDr").toString())).setScale(2, RoundingMode.HALF_UP).doubleValue();
			TransactionCredit=new BigDecimal(Double.parseDouble(DataMap.get("TransactionAmtCR").toString())).setScale(2, RoundingMode.HALF_UP).doubleValue();
			
			ResultSet resultset = null;
			Connection con = ob.GetConnection();
			
			try {		
				    con.setAutoCommit(false);
					_stmt = con.prepareStatement(
							"SELECT MAX(S.BATCH_SL)+1 BATCH_NO FROM AS_BATCH_SL S WHERE S.BRANCH_CODE=? AND S.TRAN_DATE =?");
					_stmt.setString(1, DataMap.get("loggedBranch").toString());
					_stmt.setString(2, DataMap.get("asonDate").toString());
					resultset = _stmt.executeQuery();
					if (resultset.next()) {
						batch_no = resultset.getInt("BATCH_NO");
					}
					_stmt.close();
				
				if (batch_no==0) {
					ResultMap.put("ERROR_MSG", "Day Begin Process is not run for this day");
				}
				else {
					ListIterator<Map> tranItems = GridMap.listIterator(0);
					int TransactionSl=1;
					while (tranItems.hasNext()) {												
						Map<String, String> TransactionClause = new HashMap<String, String>();
						TransactionClause.putAll((Map<? extends String, ? extends String>) tranItems.next());
						
						Map<String, String> SubData = new HashMap<String, String>();							
						SubData=ProjectUtils.SubStringTokenizer(TransactionClause.get("id5"));
						
				 	    StringTokenizer et = new StringTokenizer(TransactionClause.get("id1"), ":");		    	    
			    	    String glname = et.nextToken();			
			    	    String glcode = et.nextToken();	
			    	    
			    	    BatchDr+=Double.parseDouble(TransactionClause.get("id3"));
			    	    BatchCr+=Double.parseDouble(TransactionClause.get("id2"));
			    	    
						_stmt = con.prepareStatement(
								"insert into AS_TRANSACTION (ENTITY_NUM,tran_sl, branch, TRAN_DATE, glcode, DR_AMOUNT, CR_AMOUNT, BATCH_NO, NARATION,chq_number,chq_date,chq_reference,pf_number) "
										+ "values (1,?,?,?,?,?,?,?,?,?,?,?,?)");
						_stmt.setInt(1, TransactionSl);
						_stmt.setString(2, TransactionClause.get("BranchCode"));
						_stmt.setString(3, DataMap.get("asonDate").toString());					
						_stmt.setString(4, glcode.trim());	//glcode			
						_stmt.setString(5, TransactionClause.get("id3"));
						_stmt.setString(6, TransactionClause.get("id2"));			
						_stmt.setInt(7, batch_no);
						_stmt.setString(8, TransactionClause.get("id4"));					
						_stmt.setString(9, SubData.get("CQ"));//chq number
						_stmt.setString(10, SubData.get("CD"));//chq date
						_stmt.setString(11, SubData.get("RF"));//chq reference		
						_stmt.setString(12, "");//chq reference		
						_stmt.executeUpdate();
						TransactionSl+=1;
					}
					_stmt.close();
					
					
			        BigDecimal batch_debit = new BigDecimal(BatchDr).setScale(2, RoundingMode.HALF_UP);
			        BigDecimal batch_credit = new BigDecimal(BatchCr).setScale(2, RoundingMode.HALF_UP);
			        double BatchDebit = batch_debit.doubleValue();
			        double Batchcredit = batch_credit.doubleValue();
					
			        
			        
			        
					if (TransactionSl>1 && Double.compare(BatchDebit, Batchcredit)==0){
						
						if(Double.compare(BatchDebit, TransactionDebit)==0   &&  Double.compare(Batchcredit, TransactionCredit)==0) {
							_stmt = con.prepareStatement(
									"insert into as_transaction_list (entity_num, orginated_branch, tran_date, batch_no, transaction_type, remarks,dr_amount,cr_amount ,enty_by, enty_on)\r\n"
											+ "values(1,?,?,?,?,?,?,?,?,trunc(sysdate))");
		
							_stmt.setString(1, DataMap.get("loggedBranch").toString());
							_stmt.setString(2, DataMap.get("asonDate").toString());
							_stmt.setInt(3, batch_no);						
							_stmt.setString(4, DataMap.get("TransactionType").toString());
							_stmt.setString(5, DataMap.get("Remarks").toString());
							_stmt.setString(6, DataMap.get("TransactionAmtDr").toString());
							_stmt.setString(7, DataMap.get("TransactionAmtCR").toString());
							_stmt.setString(8, DataMap.get("User_Id").toString());
							_stmt.executeUpdate();						
							_stmt.close();
																									
							_stmt = con.prepareStatement("update as_batch_sl s set s.batch_sl=? " + " where s.branch_code= ? "
									+ " and s.tran_date=?");
							_stmt.setInt(1, batch_no);
							_stmt.setString(2, DataMap.get("loggedBranch").toString());
							_stmt.setString(3, DataMap.get("asonDate").toString());
							_stmt.executeUpdate();
							con.commit();
							ResultMap.put("BATCH_NO", "Transaction Batch Number: " + batch_no);
				        }
						else {
							ResultMap.put("ERROR_MSG", "sum of Debit & and sum Credit in  Grid is not equal with Actual transaction Total Debit & Credit Amount !!");
							con.rollback();
						}						
					}
					else
					{
						ResultMap.put("ERROR_MSG", "Total Debit & Total Credit in Transaction Grid is not equal !!");
						con.rollback();
					}
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
				try {
					con.rollback();
					_stmt.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			} finally {
				try {
					con.close();
					_stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}				
		return ResultMap;
	}
	public Map<String, String> BranchLedgerSerialSetup(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_Branch_ledger_serial_setup(?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(2);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Branch Setup Successfully Completed for "+DataMap.get("BranchCode").toString()+" !");
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
	public Map<String, String> ZeroBalanceSetup(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_Branch_Zero_Balance_setup(?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(2);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Zero Balance Setup Successfully Done for "+DataMap.get("BranchCode").toString()+" !");
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
	public Map<String, String> BranchInit(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_branch_balance_init(?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("FinYear").toString());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(3);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Branch Balance Init Successfully Completed for "+DataMap.get("BranchCode").toString()+" !");
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
	public Map<String, String> DayBeginProcess(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PARAM.sp_day_begin(?,?,?)");
			cstmt.setString(1, DataMap.get("User_Id").toString());
			cstmt.setString(2, DataMap.get("asonDate").toString());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(3);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Day Begin  Process Successfully Completed!");
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
		
	public Map<String, String> AuthorizeTransaction(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_BatchAUthorize(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("TransactionDate").toString());
			cstmt.setString(3, DataMap.get("BatchNumber").toString());
			cstmt.setString(4, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Batch Number: " +DataMap.get("BatchNumber").toString()+" is sucessfully Authorized");
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
	public Map<String, String> RejectTransaction(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_BatchRejection(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("TransactionDate").toString());
			cstmt.setString(3, DataMap.get("BatchNumber").toString());
			cstmt.setString(4, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Batch Number: " +DataMap.get("BatchNumber").toString()+" is sucessfully Rejected");
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
	public Map<String, String> checkTransaction(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_BatchChecked(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("TransactionDate").toString());
			cstmt.setString(3, DataMap.get("BatchNumber").toString());
			cstmt.setString(4, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Batch Number: " +DataMap.get("BatchNumber").toString()+" is sucessfully Validated");
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
	
	public Map<String, String> MakeAutoTransactionSalary(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_autopost_salary(?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("User_Id").toString());
			cstmt.setString(3, DataMap.get("TransactionDate").toString());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			String Batch = cstmt.getString(4);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Batch Number: " + Batch);
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
	
	public Map<String, String> OpeningBalance(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		StringTokenizer et = new StringTokenizer(DataMap.get("glcode").toString(), ":");
		String glname = et.nextToken();
		String glcode = et.nextToken();
		
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_Opening_Balance(?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, glcode.trim());
			cstmt.setString(3, DataMap.get("DrCrType").toString().trim());
			cstmt.setString(4, DataMap.get("TransactionAmount").toString());
			cstmt.setString(5, DataMap.get("FinYear").toString());
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(6);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Opening Balance Sucessfully Update for :" + DataMap.get("glcode").toString());
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
	public Map<String, String> ItemWiseVoucherPosting(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_gas.sp_auto_item_post(?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("itemCode").toString());
			cstmt.setString(3, DataMap.get("TransactionAmount").toString());
			cstmt.setString(4, DataMap.get("TransactionDate").toString());						
			cstmt.setString(5, DataMap.get("ChequeNo").toString());			
			cstmt.setString(6, DataMap.get("ChequeDate").toString());
			cstmt.setString(7, DataMap.get("ChequeReference").toString());			
			cstmt.setString(8, DataMap.get("Remarks").toString());
			cstmt.setString(9, DataMap.get("User_Id").toString());			
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(11);
			String Batch = cstmt.getString(10);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "Batch Number: " + Batch);
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

}
