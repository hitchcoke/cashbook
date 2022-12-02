package dao;
import vo.*;
import util.Dbutil;

import java.sql.*;
import java.util.*;
public class NoticeDao{
	public int selectNoticeCount(int rowPerPage) {
		int count=0;
		int lastPage= 0;
		
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		try {
			db =new Dbutil();
			conn = db.getConnection();
			String sql = "SELECT COUNT(*) FROM notice;";
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
	
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
			ArrayList<Notice> list = null;
			Dbutil db =null;
			PreparedStatement stmt = null;
			Connection conn= null;
			ResultSet rs =null;
			
			try {
				list = new ArrayList<Notice>();
				db = new Dbutil();
				conn = db.getConnection();
				
				String sql = "SELECT * FROM notice ORDER BY createdate DESC LIMIT ? , ?";
				 stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				 rs = stmt.executeQuery();
				
				while(rs.next()) {
					Notice n = new Notice();
					n.setNoticeNo(rs.getInt("notice_no"));
					n.setNoticeMemo(rs.getString("notice_memo"));
					n.setCreatedate(rs.getString("createdate"));
					n.setUpdatedate(rs.getString("updatedate"));
					list.add(n);
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
	
	public int deleteNotice(int noticeNo) {
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		 db = new Dbutil();
		 conn = db.getConnection();
		
		String sql="DELETE FROM notice WHERE notice_no=?";
		 stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);

		
		stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(null, stmt, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	
		return 1;
	}
	
	public int insertNotice(String noticeMemo) {
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		 db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "INSERT INTO notice(notice_memo, createdate, updatedate) VALUES (?,now(),now()) ";
		 stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		
		stmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(null, stmt, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		
		return 1;
	}
	
	public int updatNotice(String noticeMemo, int noticeNo) {
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		 db = new Dbutil();
		 conn = db.getConnection();
		
		String sql = "UPDATE notice SET notice_memo= ? WHERE notice_no=?";
		 stmt = conn.prepareStatement(sql);
		stmt.setString(1, noticeMemo);
		stmt.setInt(2, noticeNo);
		
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
	public Notice noticeOneList(String noticeNo){
		Notice notice=null;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs= null;
		
		try {
		notice= new Notice();
		
		 db = new Dbutil();
		conn = db.getConnection();
		
		String sql= "SELECT * FROM notice WHERE notice_no= ?;";
		 stmt= conn.prepareStatement(sql); 
		stmt.setString(1, noticeNo);
		 rs = stmt.executeQuery();
		if(rs.next()) {
			notice.setNoticeMemo(rs.getString("notice_memo"));
			notice.setNoticeNo(rs.getInt("notice_no"));
			notice.setCreatedate(rs.getString("createdate"));
			notice.setUpdatedate(rs.getString("updatedate"));
			
		}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return notice;
	}
	
	
}
