package dao;
import util.*;
import vo.*;

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
				m.put("cashPrice", rs.getLong("c.cash_price"));
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
		
		int row= 0;
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		
		try {
			
			 dbutil = new Dbutil();
			 conn = dbutil.getConnection();
		
			String sql="UPDATE cash SET cash_memo= ?, cash_price= ?, category_no= ?, updatedate= now() WHERE cash_no= ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashMemo);
			stmt.setString(2, cashPrice);
			stmt.setInt(3, categoryNo);
			stmt.setInt(4, cashNo);
		
			row=stmt.executeUpdate();
			
		}catch(Exception e) {
			
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	
		return row;
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
					m.put("cashPrice", rs.getLong("c.cash_price"));
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
		
		String sql="INSERT INTO cash(cash_memo, cash_price, category_no, cash_date, member_id, updatedate, createdate) values (?,?,?,?,?,now(),now());";
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
	public Cash cashOne(int cashNo) {
		Cash c = new Cash();
		Dbutil dbutil =null;
		PreparedStatement stmt = null;
		Connection conn= null;
		ResultSet rs = null;
		
		try {
			dbutil = new Dbutil();
			conn= dbutil.getConnection();
			String sql= "SELECT * FROM cash WHERE cash_no=?";
			stmt= conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs= stmt.executeQuery();
			
			if(rs.next()) {
				c.setCashMemo(rs.getString("cash_memo"));
				c.setCashPrice(rs.getLong("cash_price"));
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
		
		
		return c;
	}
	
	public int selectExpendByMonth(String memberId, int year, int month) {
		int totalExpend = 0;
		Dbutil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new Dbutil();
			conn = dbUtil.getConnection();
			String sql = "SELECT SUM(c.cash_price) t FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND ct.category_kind = '지출'";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				totalExpend = rs.getInt("t");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return totalExpend;
	}
	
	
	public int selectIncomeByMonth(String memberId, int year, int month) {
		int totalIncome = 0;
		Dbutil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil = new Dbutil();
			conn = dbUtil.getConnection();
			String sql = "SELECT SUM(c.cash_price) t FROM cash c INNER JOIN  category ct ON c.category_no = ct.category_no WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND ct.category_kind = '수입'";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				totalIncome = rs.getInt("t");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return totalIncome;
	}
	
	public ArrayList<HashMap<String, Object>> selectYearOfCashDate(String memberId, int year){
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		Dbutil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			dbUtil=new Dbutil();
			conn=dbUtil.getConnection();
			
			String sql="SELECT YEAR(t2.cashDate) 년, MONTH(t2.cashDate) mon"
					+ ", COUNT(t2.importCash) countImport"
					+ ", SUM(t2.importCash) sumImport"
					+ ", ROUND(AVG(t2.importCash)) avgImport"
					+ ", COUNT(t2.exportCash) countExport"
					+ ", SUM(t2.exportCash) sumExport"
					+ ", ROUND(AVG(t2.exportCash)) avgExport"
					+ " FROM"
						+ "	(SELECT "
						+ "memberId"
						+ ", cashNo"
						+ ", cashDate"
						+ ", IF(categoryKind = '수입', cashPrice, null) importCash"
						+ ", IF(categoryKind = '지출', cashPrice, null) exportCash"
							+ "	FROM (SELECT cs.cash_no cashNo"
							+ ", cs.cash_date cashDate"
							+ ", cs.cash_price cashPrice"
							+ ", cg.category_kind categoryKind"
							+ ", cs.member_id memberId"
							+ "	FROM cash cs"
							+ " INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate)= ?"
					+ " GROUP by MONTH(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate), MONTH(t2.cashDate);";
			stmt= conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			
			rs=stmt.executeQuery();
			
			while(rs.next()) {
				
				HashMap<String, Object> m = new HashMap<String, Object>();
				
				m.put("mon", rs.getString("mon"));
				m.put("countImport", rs.getString("countImport"));
				m.put("sumImport", rs.getLong("sumImport"));
				m.put("avgImport", rs.getLong("avgImport"));
				m.put("countExport", rs.getString("countExport"));
				m.put("sumExport", rs.getLong("sumExport"));
				m.put("avgExport", rs.getLong("avgExport"));
				list.add(m);
		
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
		
		return list;
	}
	public HashMap<String, Object> rankCashCategoryByMonth(int year, int month, String memberId){
		Dbutil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		HashMap<String, Object> rank= new HashMap<String, Object>();
		
		try {
			dbUtil= new Dbutil();
			conn= dbUtil.getConnection();
			
			String sql="SELECT c.category_no, c2.category_name, sum(c.cash_price) sum, COUNT(*), "
					+ "rank() over(order by sum(c.cash_price) DESC) ranking"
					+ " FROM cash c inner join category c2 on c.category_no = c2.category_no"
					+ " WHERE c2.category_kind = '지출' AND YEAR(c.cash_date) = ? AND MONTH(cash_date)= ? AND member_id = ?"
					+ " group by c2.category_no"
					+ " order by sum(c.cash_price) DESC";
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1, year);
			stmt.setInt(2, month);
			stmt.setString(3, memberId);
			
			rs=stmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("ranking")==1) {
					rank.put("categoryName", rs.getString("c2.category_name"));
					rank.put("sum", rs.getLong("sum"));
					rank.put("count", rs.getInt("count(*)"));
					
				}
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
		
		return rank;
	}
	
}
