package dao;
import java.sql.*;
import util.*;
import java.net.URLEncoder;
import vo.Member;
import java.util.*;


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
	
	public String deleteMemberByAdmin(String memberId, String adminId) throws Exception{
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		
		
		String sql2 ="SELECT member_level FROM member WHERE member_id=?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, adminId);
		ResultSet rs2 = stmt2.executeQuery();
		
		if(rs2.next()) {
			if(rs2.getInt("member_level")==1) {
				String sql1 = "DELETE FROM member WHERE member_id= ?;";
				PreparedStatement stmt1 = conn.prepareStatement(sql1);
				stmt1.setString(1, memberId);
				
				stmt1.executeUpdate();
				
				stmt1.close();
				conn.close();
				System.out.println("성공 ");
				return "성공";
			}

			System.out.println("실");
		}
		conn.close();
		stmt2.close();
		rs2.close();
		return "실패";
	}
	
	public String updateLevelAction(String memberId, String adminId, int memberLevel) throws Exception{
		
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		
		
		String sql2 ="SELECT member_level FROM member WHERE member_id=?";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, adminId);
		ResultSet rs2 = stmt2.executeQuery();
		
		if(rs2.next()) {
			if(rs2.getInt("member_level")==1) {
				String sql1 = "UPDATE member SET member_level= ?, updatedate= now() WHERE member_id=?";;
				PreparedStatement stmt1 = conn.prepareStatement(sql1);
				stmt1.setInt(1, memberLevel);
				stmt1.setString(2, memberId);
				
				stmt1.executeUpdate();
				
				stmt1.close();
				conn.close();

				System.out.println("성공 ");
				return "성공";
			}

			System.out.println("실패  ");
		}
		conn.close();
		stmt2.close();
		rs2.close();
		return "실패";
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
		
		String sql="UPDATE member SET member_name= ?, updatedate= now() WHERE member_id=?";
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
	
	public ArrayList<Member> selecetMemberList(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Member> list = new ArrayList<Member>();
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql ="SELECT * FROM member ORDER BY createdate DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Member m = new Member();
			m.setMemberId(rs.getString("member_id"));
			m.setMemberLevel(rs.getInt("member_level"));
			m.setMemberName(rs.getString("member_name"));
			m.setCreatedate(rs.getString("createdate"));
			m.setMemberNo(rs.getInt("member_no"));
			m.setUpdatedate(rs.getString("updatedate"));
			list.add(m);
		}
		
		return list;
	}
	public int selectMemberCount(int rowPerPage) throws Exception{
		int count=0;
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		String sql = "SELECT COUNT(*) FROM member;";
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
}
	
