package dao;
import java.sql.*;
import util.*;

import java.util.*;

public class HelpDao {
	public ArrayList<HashMap<String, Object>> selectMemberHelpList(String memberId) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		
		String sql ="SELECT * FROM help h LEFT OUTER JOIN comment c on h.help_no = c.help_no WHERE h.member_id  = ? ORDER BY h.createdate";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> h = new HashMap<String, Object>();
			h.put("helpNo", rs.getInt("h.help_no"));
			h.put("helpMemo", rs.getString("h.help_memo"));
			h.put("userId", rs.getString("h.member_id"));
			h.put("userUpdatedate", rs.getString("h.updatedate"));
			h.put("adminId", rs.getString("c.member_id"));
			h.put("commentMemo", rs.getString("c.comment_memo"));
			h.put("adminUpdatedate", rs.getString("c.updatedate"));
				
			list.add(h);			
		}
		db.close(rs, stmt, conn);
		return list;
	}
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "SELECT * FROM help h LEFT OUTER JOIN comment c on h.help_no = c.help_no ORDER BY h.createdate LIMIT ?, ?"; 
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> h = new HashMap<String, Object>();
			h.put("helpNo", rs.getInt("h.help_no"));
			h.put("helpMemo", rs.getString("h.help_memo"));
			h.put("userId", rs.getString("h.member_id"));
			h.put("userUpdatedate", rs.getString("h.updatedate"));
			h.put("adminId", rs.getString("c.member_id"));
			h.put("commentMemo", rs.getString("c.comment_memo"));
			h.put("adminUpdatedate", rs.getString("c.updatedate"));
			h.put("commentNo", rs.getInt("c.comment_no"));
			
			list.add(h);
		}	
		db.close(rs, stmt, conn);
		return list;
	}
	public int helpCount(int beginRow, int rowPerPage) throws Exception  {
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		
		int count = 0;
		
		String sql = "SELECT COUNT(*) FROM help";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs= stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt("count(*)");
		}
		int lastPage= count/rowPerPage;
		if(count%rowPerPage!=0) {
			lastPage+=1;
		}
		
		return lastPage;
		
		
	}
	
	public int insertHelp(String memberId, String helpMemo) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "INSERT INTO help(member_id, help_memo, createdate, updatedate) VALUES (?, ?, now(), now()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, helpMemo);
		
		stmt.executeUpdate();
		stmt.close();
		conn.close();
		
		
		return 1;
	}
	public int deleteHelp(int helpNo) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "DELETE FROM help WHERE help_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		
		stmt.executeUpdate();
		db.close(null, stmt, conn);
		
		return 1;
	}
	
	public int updateHelp(int helpNo, String helpMemo) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "UPDATE help SET help_memo= ?, updatedate= now() WHERE help_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, helpMemo);
		stmt.setInt(2, helpNo);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		
		return 1;
		
		
	}
}
