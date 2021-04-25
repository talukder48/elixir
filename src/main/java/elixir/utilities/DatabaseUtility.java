/***************************************************************
* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/

package elixir.utilities;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DatabaseUtility {
	public Connection GetConnection() {
		Connection con = null;
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource datasource = (DataSource) envContext.lookup("jdbc/bhbfc_office");
			con = datasource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e) {
			e.getLocalizedMessage();
		}
		return con;
	}
}
