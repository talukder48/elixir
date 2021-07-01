package elixir.validator.pps;
import java.io.Reader;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.lang.StringUtils;

import elixir.utilities.DatabaseUtility;


public class AccontingParameterSetup {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public AccontingParameterSetup() {
		ResultMap.clear();
	}
	
	
	public Map<String, String> GLCodeValidation(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		String glname = null;
		String glcode = null;
		try {
			StringTokenizer et = new StringTokenizer(DataMap.get("gldescription").toString(), ":");
			 glname = et.nextToken();
			 glcode = et.nextToken();
		}
		catch(Exception e) {
			ResultMap.put("ERROR_MSG", "Invalid GL Format");
		}
		
		if(ResultMap.get("ERROR_MSG").equals("")||ResultMap.get("ERROR_MSG")==null) {
			DatabaseUtility ob = new DatabaseUtility();
			String sql = " SELECT * FROM as_glcodelist l where l.entity_num=1 and l.glcode=? and tran_YN='Y' ";
			Connection con = ob.GetConnection();
			ResultSet rs = null;
			PreparedStatement stmt = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, glcode);
				rs = stmt.executeQuery();
				if (rs.next()) {
					ResultMap.put("ERROR_MSG", "");
				} else {
					ResultMap.put("ERROR_MSG", "Record not Found " + glname + " ->" + glcode);
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
		}		
		return ResultMap;
	}
	
	public Map<String, String> FetchItemDetails(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT ENTITY, BRANCH_CODE, ITEM_CODE,ITEM_DESC,(SELECT l.glname FROM as_glcodelist l where l.glcode=  DEBIT_GL)||':'||DEBIT_GL DEBIT_GL, (SELECT l.glname FROM as_glcodelist l where l.glcode=  CREDIT_GL)||':'||CREDIT_GL CREDIT_GL , ENTY_BY, TO_CHAR(ENTY_DATE, 'DD-MON-YYYY') ENTY_DATE, REMARKS  FROM as_itemlist i where i.entity=1 and BRANCH_CODE=? and i.item_code=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("BranchCode").toString());
			stmt.setString(2, DataMap.get("ItemCode").toString());
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

	public Map<String, String> AddItemDetailsParam(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");

		StringTokenizer et = new StringTokenizer(DataMap.get("DRglCode").toString(), ":");
		String drglname = et.nextToken();
		String drglcode = et.nextToken();
		StringTokenizer st = new StringTokenizer(DataMap.get("CRglCode").toString(), ":");
		String crglname = st.nextToken();
		String crglcode = st.nextToken();

		if (drglcode.equals(crglcode)) {
			ResultMap.put("ERROR_MSG", "Debit And Credit GL Must Be Different");
		} else {
			try {
				con = ob.GetConnection();
				cstmt = con.prepareCall("CALL pkg_param.sp_item_creation(?,?,?,?,?,?,?,?,?)");
				cstmt.setString(1, DataMap.get("BranchCode").toString());
				cstmt.setString(2, DataMap.get("ItemCode").toString());
				cstmt.setString(3, DataMap.get("ItemName").toString());

				cstmt.setString(4, drglcode);
				cstmt.setString(5, crglcode);

				cstmt.setString(6, DataMap.get("ItemEntyDate").toString());
				cstmt.setString(7, DataMap.get("itemremarks").toString());
				cstmt.setString(8, DataMap.get("User_Id").toString());
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.execute();
				String error = cstmt.getString(9);

				if (error != null) {
					ResultMap.put("ERROR_MSG", error + " " + drglname + " " + crglname);
				} else
					ResultMap.put("SUCCESS", "Item Sucessfully Created/update for this item code: "
							+ DataMap.get("ItemCode").toString() + " and name: " + DataMap.get("ItemName").toString());

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
		}
		return ResultMap;
	}
	public Map<String, String> FetchGLCodeDetails(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT GLCODE,GLNAME,GL_TYPE,INC_EXP,CAP_REV,SUB_GL,MAINHEAD,REMARKS,\r\n" + 
				"      to_char( decode(MOD_BY,'null',ENTY_ON,'',ENTY_ON,mod_on)) ENTY_ON\r\n" + 
				"      \r\n" + 
				"  FROM AS_GLCODELIST I where i.entity_num=1 and i.glcode=?";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("glcode").toString());
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
	
	public Map<String, String> FetchGLData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
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
	
	public Map<String, String> FetchGLStatementData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode_statement(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				
				if(clob!=null) {
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("GL_LIST", buffer.toString());
				}
				else {
					ResultMap.put("GL_LIST", "Not Applicable:000000000");
				}
				
			}

		} catch (Exception e) {
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
	
	public Map<String, String> FetchGLReconciliationData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glname)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(pkg_param.fn_get_glcode_reconciliation(?))) ORDER BY glname ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				
				if(clob!=null) {
					Reader r = clob.getCharacterStream();
					StringBuffer buffer = new StringBuffer();
					int ch;
					while ((ch = r.read()) != -1) {
						buffer.append("" + (char) ch);
					}
					ResultMap.put("GL_LIST", buffer.toString());
				}
				else {
					ResultMap.put("GL_LIST", "Not Applicable:000000000");
				}
				
			}

		} catch (Exception e) {
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
	
	
	public Map<String, String> FetchGLDataforRegister(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (select * from as_glcodelist g where   sub_gl='0' ) ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			//stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
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
	
	public Map<String, String> FetchGLData_OBL(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, glcode || ':' || glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from (SELECT * FROM table(PKG_PARAM.fn_GLCODE(?)) where tran_gl='Y') ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("loggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
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
	
	
	public Map<String, String> FetchGLListBranch(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, g.glcode || ':' || g.glname, ',').extract('//text()') order by glcode)\r\n"
				+ "             .getclobval(),\r\n" + "             ',') gl_list\r\n"
				+ "  from AS_glcodelist g where g.slot_yn='Y'" ;
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("gl_list");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("GL_LIST", buffer.toString());
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
	
	public Map<String, String> FetchItemData(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DatabaseUtility ob = new DatabaseUtility();
		String sql = "SELECT  listagg(ITEM_LIST,',') WITHIN GROUP (ORDER BY ITEM_LIST) ITEM_LIST from (SELECT ITEM_LIST FROM ( \r\n" + 
				"        SELECT g.item_code||':'||g.item_desc ITEM_LIST FROM as_itemlist g where branch_code=?))";			
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
	}//
	
	
	public Map<String, String> BranchGLOpening(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_branch_ledger_Opening(?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("BranchCode").toString());
			cstmt.setString(2, DataMap.get("glcode").toString());
			cstmt.setString(3, DataMap.get("GLName").toString());				
			cstmt.setString(4, DataMap.get("AccRemarks").toString());
			cstmt.setString(5, DataMap.get("entryDate").toString());
			cstmt.setString(6, DataMap.get("User_Id").toString());				
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(8);
			String newglcode = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "New glcode sucessfully created and code is:  "+ newglcode+":"+ DataMap.get("GLName").toString());
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
	
	
	public Map<String, String> GLSetupFunction(Map DataMap) throws Exception {
		DatabaseUtility ob = new DatabaseUtility();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_gl_setup(?,?,?,?,?,?,?,?,?,?,?)");			
			cstmt.setString(1, DataMap.get("glcode").toString());
			cstmt.setString(2, DataMap.get("glname").toString());
			cstmt.setString(3, DataMap.get("gltype").toString());
			cstmt.setString(4, DataMap.get("subgl").toString());
			cstmt.setString(5, DataMap.get("headglcode").toString().equals("")||DataMap.get("headglcode").toString().equals("N/A")? "":DataMap.get("headglcode").toString());
			cstmt.setString(6, DataMap.get("expendituretype").toString());
			cstmt.setString(7, DataMap.get("incometype").toString());
			cstmt.setString(8, DataMap.get("entyDate").toString());
			cstmt.setString(9, DataMap.get("glremarks").toString());
			
			cstmt.setString(10, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(11);

			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", "GL Sucessfully Created/update for this item code: " + DataMap.get("glcode").toString()+" and name: "+DataMap.get("glname").toString());
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
