package dao;
import util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import java.sql.*;
public class CashDao {
	//cashList
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(int year, int month, String memberId) throws Exception{
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		Dbutil dbUtil = new Dbutil();
		Connection conn = dbUtil.getConnection();
		
		
		
		String sql="SELECT * FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				+ " WHERE c.member_id = ? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? "
				+ " ORDER BY c.cash_date;";
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
	public int deleteCash(int cashNo, String memberId) throws Exception {
		Dbutil dbutil = new Dbutil();
		Connection conn = dbutil.getConnection();
		
		String sql="DELETE FROM cash WHERE cash_no=? AND member_id=? ";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cashNo);
		stmt.setString(2, memberId);
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		
		return 1;
		
	}
	public int updateCash(int cashNo, String cashMemo, String cashPrice, int categoryNo) throws Exception {
		Dbutil dbutil = new Dbutil();
		Connection conn = dbutil.getConnection();
	
		String sql="UPDATE cash SET cash_memo= ?, cash_price= ?, category_no= ? WHERE cash_no= ?;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cashMemo);
		stmt.setString(2, cashPrice);
		stmt.setInt(3, categoryNo);
		stmt.setInt(4, cashNo);
	
		
		stmt.executeUpdate();
		stmt.close();
		conn.close();
		
		return 1;
	}
	//사용 용도 cashOne.jsp
	public ArrayList<HashMap<String, Object>> selecetCashListByDate(String memberId, int year, int month, int date) throws Exception{
		ArrayList<HashMap<String, Object>> list=new ArrayList<HashMap<String, Object>>();
		Dbutil dbUtil = new Dbutil();
		Connection conn = dbUtil.getConnection();
		
		
		
		String sql="SELECT * FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
				+ " WHERE c.member_id = ? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? AND DAY(c.cash_date)= ? "
				+ " ORDER BY c.cash_date;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
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
	public int insertCash(String cashdate, String cashMemo, String cashPrice, int categoryNo, String memberId) throws Exception{
		
		Dbutil dbUtil = new Dbutil();
		Connection conn = dbUtil.getConnection();
		
		String sql="INSERT INTO cash(cash_memo, cash_price, category_no, cash_date, member_id) values (?,?,?,?,?);";
		PreparedStatement stmt= conn.prepareStatement(sql);
		stmt.setString(1, cashMemo);
		stmt.setString(2, cashPrice);
		stmt.setInt(3, categoryNo);
		stmt.setString(4, cashdate);
		stmt.setString(5, memberId);
		
		stmt.executeQuery();
	
		stmt.close();
		conn.close();
		
		
		return 1;
	}
}
