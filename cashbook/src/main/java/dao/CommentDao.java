package dao;

import java.sql.*;


import util.Dbutil;

public class CommentDao {
	public int insertCommment(String memberId, String commentMemo, int helpNo){
		
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "INSERT INTO comment(member_id, comment_memo, help_no, createdate, updatedate) VALUES (?, ?, ?, now(), now()) ";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, commentMemo);
		stmt.setInt(3, helpNo);
		
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
	public int deleteComment(int commentNo) {
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "DELETE FROM comment WHERE comment_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		
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
	
	public int updateComment(int commentNo, String commentMemo, String memberId) {
		
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "UPDATE comment SET comment_memo= ?, member_id= ?, updatedate= now() WHERE comment_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, commentMemo);
		stmt.setString(2, memberId);
		stmt.setInt(3, commentNo);
		
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
}
