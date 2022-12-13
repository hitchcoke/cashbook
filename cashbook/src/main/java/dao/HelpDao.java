package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.Dbutil;
import vo.Help;

public class HelpDao {
	public ArrayList<HashMap<String, Object>> selectMemberHelpList(String memberId){
		ArrayList<HashMap<String, Object>> list = null;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
		list = new ArrayList<HashMap<String, Object>>();
		db =new Dbutil();
		conn = db.getConnection();
		
		String sql ="SELECT * FROM help h LEFT OUTER JOIN comment c on h.help_no = c.help_no WHERE h.member_id  = ? ORDER BY h.createdate";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		
		rs = stmt.executeQuery();
		
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {
		
		ArrayList<HashMap<String, Object>> list = null;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
		list = new ArrayList<HashMap<String, Object>>();
		 db =new Dbutil();
		 conn = db.getConnection();
		
		String sql = "SELECT * FROM help h LEFT OUTER JOIN comment c on h.help_no = c.help_no ORDER BY h.createdate LIMIT ?, ?"; 
		 stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		 rs = stmt.executeQuery();
		
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}

		return list;
	}
	public int helpCount(int beginRow, int rowPerPage) {
		
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		int lastPage=0;
		
		try {
		db =new Dbutil();
		conn = db.getConnection();
		
		int count = 0;
		
		String sql = "SELECT COUNT(*) FROM help";
		stmt = conn.prepareStatement(sql);
		rs= stmt.executeQuery();
		if(rs.next()) {
			count=rs.getInt("count(*)");
		}
		lastPage= count/rowPerPage;
		if(count%rowPerPage!=0) {
			lastPage+=1;
		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return lastPage;
		
		
	}
	
	public int insertHelp(String memberId, String helpMemo) {
		
		
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		 db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "INSERT INTO help(member_id, help_memo, createdate, updatedate) VALUES (?, ?, now(), now()) ";
		 stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, helpMemo);
		
		stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		return 1;
	}
	public int deleteHelp(int helpNo){
	
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
	
		
		try {
		 db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "DELETE FROM help WHERE help_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, helpNo);
		
		stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return 1;
	}
	
	public int updateHelp(int helpNo, String helpMemo) {
		
	
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "UPDATE help SET help_memo= ?, updatedate= now() WHERE help_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, helpMemo);
		stmt.setInt(2, helpNo);
		
		stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return 1;
		
		
	}
	public Help helpOne(int helpNo) {
		Help help= new Help();
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
			db= new Dbutil();
			conn= db.getConnection();
			String sql="SELECT * FROM help WHERE help_no= ?";
			stmt= conn.prepareStatement(sql);
			stmt.setInt(1, helpNo);
			
			rs= stmt.executeQuery();
			
			if(rs.next()) {
				help.setHelpMemo(rs.getString("help_memo"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return help;
				
	}
}
