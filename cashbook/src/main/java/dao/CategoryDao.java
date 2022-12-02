package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import vo.*;
import util.*;
public class CategoryDao {
	//카테고리 목록 보기 
	public ArrayList<Category> selectCategory() {
		ArrayList<Category> category = null;
		Dbutil dbUtil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs = null;
		
		try {
			
			dbUtil = new Dbutil();
			conn = dbUtil.getConnection();
			
			String sql="SELECT * FROM category";
			stmt = conn.prepareStatement(sql);
			 rs = stmt.executeQuery();
			
			category = new ArrayList<Category>();
			
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryKind(rs.getString("category_kind"));
				c.setCategoryName(rs.getString("category_name"));
				c.setCategoryNo(rs.getInt("category_no"));
				c.setUpdatedate(rs.getString("updatedate"));
				category.add(c);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
		return category;
		
	}
	
	//category 추가  
	public int insertCategory(Category c){
	
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		
		try {
		
		db =new Dbutil();
		conn =db.getConnection();
		
		String sql = "INSERT INTO category("
				+ "category_kind,"
				+ "category_name,"
				+ "updatedate,"
				+ "createdate)"
				+ "values(?, ?, curdate(), curdate())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCategoryKind());
		stmt.setString(2, c.getCategoryName());
		
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
		
	
		return 0;
	}
	//category삭제 
	public int deleteCatgory(int categoryNo){
	
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
	
		
		try {
			db = new Dbutil();
			conn = db.getConnection();
			
			String sql = "DELETE FROM category WHERE category_no=?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			
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
	//category 업데이트
	public int updateCategory(Category category) {
	
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
	
		
		try {
		db = new Dbutil();
		conn = db.getConnection();
		
		String sql = "UPDATE category SET category_kind= ?, category_name= ?, updatedate= curdate() WHERE category_no= ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setInt(3, category.getCategoryNo());
		
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
	
	public Category selectCategoryOne(int categoryNo) {
		Category c = null;
		Dbutil db =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs = null;
		
		try {
		c = new Category();
		
		db =new Dbutil();
		conn = db.getConnection();
		
		String sql = "SELECT category_no, category_name FROM category WHERE category_no=?";
	    stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			c.setCategoryNo(rs.getInt("category_no"));
			c.setCategoryName(rs.getString("category_name"));
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
		
		
		return c;
	}
}
