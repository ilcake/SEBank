package sebank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import oracle.sql.DATE;
import sebank.vo.Board;
import sebank.vo.Reply;

public class BoardDAO {
	public BoardDAO() {

	}

	public int write(Board b) {
		int result = -1;
		Connection con = ConnectionManager.makeConnection();
		String id = b.getId();
		String title = b.getTitle();
		String content = b.getContent();
		try {
			String sql = "insert into board2 values( BOARD2_SEQ.NEXTVAL, ?,?,?, sysdate, 0 )";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, title);
			ps.setString(3, content);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public ArrayList<Board> list(int a, int b) {
		ArrayList<Board> list = new ArrayList<>();
		Connection con = ConnectionManager.makeConnection();
		try {

			String sql = "select * from";
			sql += "( select rownum r, b.* from";
			sql += "(select boardnum, id, title, content, to_char(inputdate, 'YYYY/MM/DD') inputdate2, hits, inputdate ";
			sql += "from board2 order by inputdate desc) b) where r between ? and ?";

			// String sql = "select boardnum, id, title, content,
			// to_char(inputdate, 'YYYY/MM/DD') inputdate, hits from board2
			// order by boardnum desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			ps.setInt(2, b);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new Board(rs.getInt("boardnum"), rs.getString("id"), rs.getString("title"),
						rs.getString("content"), rs.getString("inputdate2"), rs.getInt("hits")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public Board read(int a) {
		Board b = null;
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "select boardnum, id, title, content, to_char(inputdate, 'YYYY/MM/DD') inputdate, hits from board2 where boardnum=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new Board(rs.getInt("boardnum"), rs.getString("id"), rs.getString("title"), rs.getString("content"),
						rs.getString("inputdate"), rs.getInt("boardnum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
		addHits(a);
		return b;
	}

	public void addHits(int a) {
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "update board2 set hits=hits+1 where boardnum=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
	}

	public int update(Board b) {
		Connection con = ConnectionManager.makeConnection();
		int result = -1;
		String title = b.getTitle();
		String content = b.getContent();
		int boardnum = b.getBoardnum();
		String id = b.getId();
		try {
			String sql = "update board2 set title=?, content=? where boardnum=? and id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, title);
			ps.setString(2, content);
			ps.setInt(3, boardnum);
			ps.setString(4, id);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	public int delete(int a, String id) {
		Connection con = ConnectionManager.makeConnection();
		PreparedStatement ps;
		String sql;
		int result = -1;

		try {
			con.setAutoCommit(false);
			sql = "select * from board2 where boardnum=? and id=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			ps.setString(2, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = 1;
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}

		if (result > 0) {

			try {
				sql = "delete reply2 where boardnum=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, a);
				ps.executeUpdate();

				sql = "delete board2 where boardnum=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, a);
				result = ps.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			con.commit();
			con.setAutoCommit(true);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public void replyInsert(Reply r) {
		Connection con = ConnectionManager.makeConnection();

		try {
			String sql = "insert into reply2 values ( reply2_seq.nextval, ?, ?, ?, sysdate )";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, r.getBoardnum());
			ps.setString(2, r.getId());
			ps.setString(3, r.getText());
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
	}

	public ArrayList<Reply> replyList(int a) {
		ArrayList<Reply> replyList = new ArrayList<>();
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "select replynum, boardnum, id, text, to_char(inputdate, 'YYYY/MM/DD') inputdate from reply2 where boardnum=? order by replynum";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			Reply r = null;
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				r = new Reply(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5));
				replyList.add(r);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
		return replyList;
	}

	public int replyDelete(int a, String id) {
		int result = -1;
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "delete reply2 where replynum=? and id=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, a);
			ps.setString(2, id);
			result = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public int replyUpdate(int a, String text) {
		int result = -1;
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "update reply2 set text=? where replynum=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, text);
			ps.setInt(2, a);
			result = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

	public int getFullCount() {
		int result = -1;
		Connection con = ConnectionManager.makeConnection();
		try {
			String sql = "select count(boardnum) from board2";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = -1;
		}
		ConnectionManager.closeConnection(con);
		return result;
	}

}
