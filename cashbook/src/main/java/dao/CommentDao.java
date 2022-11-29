package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.Dbutil;

public class CommentDao {
	public int insertCommment(String memberId, String commentMemo, int helpNo) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "INSERT INTO comment(member_id, comment_memo, help_no, createdate, updatedate) VALUES (?, ?, ?, now(), now()) ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setString(2, commentMemo);
		stmt.setInt(3, helpNo);
		
		stmt.executeUpdate();
		stmt.close();
		conn.close();
		
		
		return 1;
	}
	public int deleteComment(int commentNo) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "DELETE FROM comment WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		
		stmt.executeUpdate();
		db.close(null, stmt, conn);
		
		return 1;
	}
	
	public int updateComment(int commentNo, String commentMemo, String memberId) throws Exception{
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "UPDATE comment SET comment_memo= ?, member_id= ?, updatedate= now() WHERE comment_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, commentMemo);
		stmt.setString(2, memberId);
		stmt.setInt(3, commentNo);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		
		return 1;
		
	}
}
