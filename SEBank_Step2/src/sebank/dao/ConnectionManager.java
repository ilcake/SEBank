package sebank.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String dbid = "hr";
	private static final String dbpw = "hr";

	// 초기화 블럭
	static {
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static Connection makeConnection() { // 따로 객체를 생성하지않고 다른 클래스에서 불러쓰기위해
												// static타입으로
		Connection con = null;
		try {
			con = DriverManager.getConnection(url, dbid, dbpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

	public static void closeConnection(Connection con) {
		try {
			if (con != null)
				con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}