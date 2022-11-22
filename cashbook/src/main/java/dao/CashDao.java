package dao;
import util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import java.sql.*;
public class CashDao {
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(int year, int month, String memberId) throws Exception{
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		Dbutil dbUtil = new Dbutil();
		Connection conn = dbUtil.getConnection();
		
		
		
		String sql="SELECT * FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? ORDER BY c.cash_date;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashMemo", rs.getString("c.cash_memo"));
			m.put("cashPrice", rs.getString("c.cash_price"));
			m.put("cashdate", rs.getString("c.cash_date"));
			m.put("categoryName", rs.getString("ct.category_name"));
			m.put("categoryKind", rs.getString("ct.category_kind"));
			m.put("cashNo", rs.getString("c.cash_no"));
			m.put("memberId", memberId);
			list.add(m);
			
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	public int deleteCash(int cashNo) throws Exception {
		Dbutil dbutil = new Dbutil();
		Connection conn = dbutil.getConnection();
		
		String sql="DELETE FROM cash WHERE cash_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		
		return 1;
		
	}
	public int updateCash(int cashNo, String cashMemo, String cashPrice) throws Exception {
		Dbutil dbutil = new Dbutil();
		Connection conn = dbutil.getConnection();
	
		String sql="UPDATE cash SET cash_memo= ?, cash_price= ? WHERE cash_no= ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cashMemo);
		stmt.setString(2, cashPrice);
		stmt.setInt(3, cashNo);
		
		stmt.executeUpdate();
		stmt.close();
		conn.close();
		
		return 1;
	}
}
