package dao;
import java.sql.*;
import util.*;
import vo.Member;

public class MemberDao {
	
	public int deleteMember(int memberNo) throws Exception{
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql= "DELETE FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		
		stmt.executeUpdate();
		String msg="삭제성공";
		
		return 1;
	}
	
	
	public int insertMember(Member paramMember) throws Exception {
		
		
		
		Dbutil db= new Dbutil();
		
		Connection conn = db.getConnection();
		
		String sql= "INSERT INTO member(member_id, member_pw, member_name, createdate) VALUES (?, PASSWORD(?), ?, CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		
		stmt.executeQuery();
		
		
		
		return 1;
	}
 	
	public Member login(Member paramMember) throws Exception {
		
		Dbutil db= new Dbutil();
		
		Connection conn = db.getConnection();
		
		
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw=PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		ResultSet rs= stmt.executeQuery();
		
		Member resultMember = new Member();
		
		if(rs.next()) {
			resultMember.setMemberName(rs.getString("member_name"));
			resultMember.setMemberNo(rs.getInt("member_no"));
			resultMember.setMemberId(rs.getString("member_id"));
		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	
	
	
}
