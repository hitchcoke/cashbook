package dao;
import util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.*;
import java.sql.*;
public class CashDao {
	//cashList
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(int year, int month, String memberId) {
		ArrayList<HashMap<String, Object>>list = null;
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs = null;
		try {
			list=new ArrayList<HashMap<String, Object>>();
			dbutil = new Dbutil();
			conn = dbutil.getConnection();
			
			String sql="SELECT * FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+ " WHERE c.member_id = ? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? "
					+ " ORDER BY c.cash_date;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			
			rs = stmt.executeQuery();
			
			
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
			
			return list;
	}
	public int deleteCash(int cashNo, String memberId) {
		
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		
		try {
			dbutil = new Dbutil();
			conn = dbutil.getConnection();
			
			String sql="DELETE FROM cash WHERE cash_no=? AND member_id=? ";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			stmt.setString(2, memberId);
			
			stmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			try {
				dbutil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		return 1;
		
	}
	public int updateCash(int cashNo, String cashMemo, String cashPrice, int categoryNo) {
		
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
			
			 dbutil = new Dbutil();
			 conn = dbutil.getConnection();
		
			String sql="UPDATE cash SET cash_memo= ?, cash_price= ?, category_no= ? WHERE cash_no= ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashMemo);
			stmt.setString(2, cashPrice);
			stmt.setInt(3, categoryNo);
			stmt.setInt(4, cashNo);
		
			stmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	
		return 1;
	}
	//사용 용도 cashOne.jsp
	public ArrayList<HashMap<String, Object>> selecetCashListByDate(String memberId, int year, int month, int date){
		ArrayList<HashMap<String, Object>>list = null;
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs = null;
		
		try {
			list=new ArrayList<HashMap<String, Object>>();
			dbutil = new Dbutil();
			conn = dbutil.getConnection();
			
			
			
			String sql="SELECT * FROM cash c INNER JOIN category ct ON c.category_no = ct.category_no "
					+ " WHERE c.member_id = ? AND YEAR(c.cash_date)=? AND MONTH(c.cash_date)=? AND DAY(c.cash_date)= ? "
					+ " ORDER BY c.cash_date;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			
			
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
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	
		return list;
	}
	public int insertCash(String cashdate, String cashMemo, String cashPrice, int categoryNo, String memberId) {

		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
		dbutil = new Dbutil();
		conn = dbutil.getConnection();
		
		String sql="INSERT INTO cash(cash_memo, cash_price, category_no, cash_date, member_id) values (?,?,?,?,?);";
		stmt= conn.prepareStatement(sql);
		stmt.setString(1, cashMemo);
		stmt.setString(2, cashPrice);
		stmt.setInt(3, categoryNo);
		stmt.setString(4, cashdate);
		stmt.setString(5, memberId);
		
		stmt.executeQuery();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		return 1;
	}
}
