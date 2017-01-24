package sebank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import sebank.vo.Customer;

public class CustomerDAO {

	public CustomerDAO() {

	}

	/*
	 * 고객 ID로 고객정보 검색. 로그인/ID중복확인/개인정보 수정 기능
	 * 
	 * @param custid 검색할 아이디
	 * 
	 * @return 해당 아이디에 대한 정보를 Customer객체로 리턴, 없으면 null리턴
	 */
	public Customer selectCustomer(String id) {
		Customer c = null;
		Connection con = ConnectionManager.makeConnection();

		try {
			String sql = "select custid, password, name, email, division, idno, address from customer where custid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				c = new Customer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getString(6), rs.getString(7));
			}

		} catch (Exception e) {
			c = null;
		}
		ConnectionManager.closeConnection(con);
		return c;
	}

	public int insertCustomer(Customer c) {
		Connection con = ConnectionManager.makeConnection();
		int result = -1;

		try {
			String sql = "insert into customer values(?,?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, c.getCustid());
			ps.setString(2, c.getPassword());
			ps.setString(3, c.getName());
			ps.setString(4, c.getEmail());
			ps.setString(5, c.getDivision());
			ps.setString(6, c.getIdno());
			ps.setString(7, c.getAddress());

			result = ps.executeUpdate();

		} catch (Exception e) {
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public int updateCustomer(Customer c) {
		Connection con = ConnectionManager.makeConnection();
		int result = -1;
		try {
			String sql = "update customer set password=?, name=?, email=?, idno=?, address=? where custid=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, c.getPassword());
			ps.setString(2, c.getName());
			ps.setString(3, c.getEmail());
			ps.setString(4, c.getIdno());
			ps.setString(5, c.getAddress());
			ps.setString(6, c.getCustid());

			result = ps.executeUpdate();
		} catch (Exception e) {
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public int loginCustomer(String id, String pw) {
		Connection con = ConnectionManager.makeConnection();
		int result = -1;

		try {
			String sql = "select * from customer where custid=? and password=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			result = ps.executeUpdate();

		} catch (Exception e) {
		}

		ConnectionManager.closeConnection(con);
		return result;
	}

	public int out(String id, String pw) {
		int result = -1;
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "delete customer where custid=? and password=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			result = ps.executeUpdate();

		} catch (Exception e) {

		}
		return result;
	}

}
