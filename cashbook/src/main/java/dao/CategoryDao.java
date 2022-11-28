package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import vo.*;
import util.*;
public class CategoryDao {
	//카테고리 목록 보기 
	public ArrayList<Category> selectCategory() throws Exception{
		Dbutil dbUtil = new Dbutil();
		Connection conn = dbUtil.getConnection();
		
		String sql="SELECT * FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		ArrayList<Category> category = new ArrayList<Category>();
		
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryKind(rs.getString("category_kind"));
			c.setCategoryName(rs.getString("category_name"));
			c.setCategoryNo(rs.getInt("category_no"));
			c.setUpdatedate(rs.getString("updatedate"));
			category.add(c);
		}
		dbUtil.close(rs, stmt, conn);
		return category;
		
	}
	
	//category 추가  
	public int insertCategory(Category c) throws Exception{
		int row =0;
		Dbutil db =new Dbutil();
		Connection conn =db.getConnection();
		
		String sql = "INSERT INTO category("
				+ "category_kind,"
				+ "category_name,"
				+ "updatedate,"
				+ "createdate)"
				+ "values(?, ?, curdate(), curdate())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, c.getCategoryKind());
		stmt.setString(2, c.getCategoryName());
		
		stmt.executeUpdate();
		
		db.close(null, stmt, conn);
		
		return row;
	}
	//category삭제 
	public int deleteCatgory(int categoryNo)throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "DELETE FROM category WHERE category_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		
		stmt.executeUpdate();
		
		db.close(null, stmt, conn);
		
		return 1;
	}
	//category 업데이트
	public int updateCategory(Category category) throws Exception{
		Dbutil db = new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "UPDATE category SET category_kind= ?, category_name= ?, updatedate= curdate() WHERE category_no= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getCategoryKind());
		stmt.setString(2, category.getCategoryName());
		stmt.setInt(3, category.getCategoryNo());
		
		stmt.executeUpdate();
		
		db.close(null, stmt, conn);
		
		return 1;
	}
	
	public Category selectCategoryOne(int categoryNo) throws Exception{
		Category c = new Category();
		
		Dbutil db =new Dbutil();
		Connection conn = db.getConnection();
		
		String sql = "SELECT category_no, category_name FROM category WHERE category_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, categoryNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			c.setCategoryNo(rs.getInt("category_no"));
			c.setCategoryName(rs.getString("category_name"));
		}
		
		
		return c;
	}
}
