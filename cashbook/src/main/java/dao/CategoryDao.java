package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;
import vo.*;
import util.*;
public class CategoryDao {
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
			category.add(c);
		}
		return category;
		
	}
}
