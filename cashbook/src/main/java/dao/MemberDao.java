package dao;
import java.sql.*;
import util.*;
import java.net.URLEncoder;
import vo.Member;

public class MemberDao {
	//	반환값의 의미는 true 시 존재, false 시 사용가 
	public boolean selectMemberIdCk(String memberId) throws Exception {
			boolean result = false;
			Dbutil db = new Dbutil();
			Connection conn = db.getConnection();
			
			String sql = "SELECT member_id FROM member WHERE member_id = ?"+memberId;
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
			Dbutil dbb = new Dbutil();
			dbb.close(rs, stmt, conn);
			return result;
			
	}
	
	public String deleteMember(String memberId, String memberPw) throws Exception{
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		
		String msg=URLEncoder.encode("비밀번호를 확인해주세요  ","utf-8");
		String target="/member/deleteMemberForm.jsp?msg="+msg;
		
		
		String sql = "SELECT member_id FROM member WHERE member_id= ? AND member_pw= PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, memberId);
		stmt.setString(2, memberPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			String sql1 = "DELETE FROM member WHERE member_id= ?;";
			PreparedStatement stmt1 = conn.prepareStatement(sql1);
			stmt1.setString(1, memberId);
			
			stmt1.executeUpdate();
			
			msg = URLEncoder.encode(" 회원탈퇴 완료 안녕히  ","utf-8");
			target="/loginForm.jsp?msg="+msg;
			
			stmt1.close();
			stmt.close();
			rs.close();
			conn.close();
			return target;
			
		}		
		stmt.close();
		rs.close();
		conn.close();
		
		return target;
				
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
			resultMember.setMemberLevel(rs.getInt("member_level"));		}
		
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	public String insertMember(String memberId, String memberPw, String memberName) throws Exception{
			
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		
		String msg=URLEncoder.encode("회원가입 성공 ","utf-8");
		String target="/loginForm.jsp?msg="+msg;
		
		
		String sql = "SELECT member_id FROM member WHERE member_id= ?";
		PreparedStatement stmt = conn.prepareStatement(sql); 
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			msg = URLEncoder.encode("아이디가 중복되었습니다 ","utf-8");
			target="/insertMemberForm.jsp?msg="+msg;
			
			stmt.close();
			rs.close();
			conn.close();
			return target;
		}
		
		
		String sql1 = "INSERT INTO member("
				+ "member_id,"
				+ "member_pw,"
				+ "member_name,"
				+ "updatedate,"
				+ "createdate) values (?, PASSWORD(?), ?, curdate(), curdate())";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, memberId);
		stmt1.setString(2, memberPw);
		stmt1.setString(3, memberName);
		
		stmt1.executeUpdate();
		
		stmt1.close();
		stmt.close();
		rs.close();
		conn.close();
		
		return target;
			
		}
	
	
	public Member memberOneList(String memberId) throws Exception {
		
		Member member= new Member();
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql= "SELECT * FROM member WHERE member_id= ?;";
		
		PreparedStatement stmt= conn.prepareStatement(sql); 
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			member.setMemberName(rs.getString("member_name"));
			member.setCreatedate(rs.getString("createdate"));
			
		}
		
		stmt.close();
		rs.close();
		conn.close();
		return member;
	}
	public String memberUpdate(String memberId, String memberName) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql="UPDATE member SET member_name= ? WHERE member_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberName);
		stmt.setString(2, memberId);
		stmt.executeUpdate();
		
		String msg=URLEncoder.encode("수정완료  ","utf-8");
		String target="/member/memberOne.jsp?msg="+msg;
		
		stmt.close();
		
		conn.close();
		
		return target;
	}
}
	
