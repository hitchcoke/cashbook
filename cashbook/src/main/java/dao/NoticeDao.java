package dao;
import vo.*;
import util.Dbutil;

import java.sql.*;
import java.util.*;
public class NoticeDao{
	public int selectNoticeCount(int rowPerPage) throws Exception{
		int count=0;
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		String sql = "SELECT COUNT(*) FROM notice;";
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
	
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
			ArrayList<Notice> list = new ArrayList<Notice>();
			Dbutil db = new Dbutil();
			Connection conn = db.getConnection();
			
			String sql = "SELECT * FROM notice ORDER BY createdate DESC LIMIT ? , ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("notice_no"));
				n.setNoticeMemo(rs.getString("notice_memo"));
				n.setCreatedate(rs.getString("createdate"));
				n.setUpdatedate(rs.getString("updatedate"));
				list.add(n);
			}
			
		return list;
	}
}
