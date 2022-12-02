package dao;
import java.sql.*;
import util.*;
import java.net.URLEncoder;
import vo.Member;
import java.util.*;


public class MemberDao {
	//	반환값의 의미는 true 시 존재, false 시 사용가 
	public boolean selectMemberIdCk(String memberId)  {
			boolean result = false;
			Dbutil db =null;
			PreparedStatement stmt = null;
			Connection conn= null;
			ResultSet rs= null;
			try {
			db = new Dbutil();
			 conn = db.getConnection();
			
			String sql = "SELECT member_id FROM member WHERE member_id = ?"+memberId;
			 stmt = conn.prepareStatement(sql);
			 rs = stmt.executeQuery();
			if(rs.next()) {
				result = true;
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
			return result;
			
	}
	
	public String deleteMemberByAdmin(String memberId, String adminId) {
		Dbutil db =null;
		PreparedStatement stmt2 = null;
		Connection conn= null;
		ResultSet rs2= null;
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		
		String sql2 ="SELECT member_level FROM member WHERE member_id=?";
		 stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, adminId);
		rs2 = stmt2.executeQuery();
		
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs2, stmt2, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return "실패";
	}
	
	public String updateLevelAction(String memberId, String adminId, int memberLevel) {
		
		Dbutil db =null;
		PreparedStatement stmt2 = null;
		Connection conn= null;
		ResultSet rs2= null;
		
		try {
		
		 db = new Dbutil();
		conn = db.getConnection();
		
		String sql2 ="SELECT member_level FROM member WHERE member_id=?";
		 stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, adminId);
		rs2 = stmt2.executeQuery();
		
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs2, stmt2, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
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
	
	
 	
	public Member login(Member paramMember) {
		Member resultMember= null;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
		db= new Dbutil();
		
		conn = db.getConnection();
		
		
		String sql = "SELECT * FROM member WHERE member_id = ? AND member_pw=PASSWORD(?)";
		 stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		
		rs= stmt.executeQuery();
		
		 resultMember = new Member();
		
		if(rs.next()) {
			resultMember.setMemberName(rs.getString("member_name"));
			resultMember.setMemberNo(rs.getInt("member_no"));
			resultMember.setMemberId(rs.getString("member_id"));
			resultMember.setMemberLevel(rs.getInt("member_level"));		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
	
		
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
	
	
	public Member memberOneList(String memberId) {
		
		Member member= new Member();
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
			db = new Dbutil();
			 conn = db.getConnection();
			
			String sql= "SELECT * FROM member WHERE member_id= ?;";
			
			stmt= conn.prepareStatement(sql); 
			stmt.setString(1, memberId);
			 rs = stmt.executeQuery();
			if(rs.next()) {
				member.setMemberName(rs.getString("member_name"));
				member.setCreatedate(rs.getString("createdate"));
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				db.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
	
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
	
	public ArrayList<Member> selecetMemberList(int beginRow, int rowPerPage)  {
		ArrayList<Member> list = new ArrayList<Member>();
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		try {
		 db = new Dbutil();
		 conn = db.getConnection();
		
		String sql ="SELECT * FROM member ORDER BY createdate DESC LIMIT ?,?";
		 stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		 rs = stmt.executeQuery();
		
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
	public int selectMemberCount(int rowPerPage) {
		int count=0;
		int lastPage=0;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs =null;
		
		try {
		db =new Dbutil();
		 conn = db.getConnection();
		String sql = "SELECT COUNT(*) FROM member;";
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
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return lastPage;
	}
}
	
