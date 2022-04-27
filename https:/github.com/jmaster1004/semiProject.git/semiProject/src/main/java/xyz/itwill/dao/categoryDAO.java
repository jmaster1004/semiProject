package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.categoryDTO;

public class categoryDAO extends JdbcDAO{

	private static categoryDAO _dao;
	 
	private categoryDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new categoryDAO();
	}
	
	public static categoryDAO getDAO() {
		return _dao;
	}
	
	public categoryDTO selectCategory(String no,String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		categoryDTO cago = null;
		
		try {
			con=getConnection();
			
			if(no!=null) {
				String sql = "select * from item_category where category_no = ? ";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, no);

			} else {
				String sql = "select * from item_category where CATEGORY_NAME = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, name);
				
			}

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cago = new categoryDTO();
				cago.setCategogyNo(rs.getString("category_no"));
				cago.setCategogyName(rs.getString("CATEGORY_NAME"));
			}

		} catch(SQLException e) {
			System.out.println("[에러]selectCategory 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cago;
	}
	
	public List<categoryDTO> selectAllCategoryList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<categoryDTO> cagoList = new ArrayList<categoryDTO>();
		
		try {
			con=getConnection();
			
			String sql = "select * from item_category";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				categoryDTO cago = new categoryDTO();
				cago.setCategogyNo(rs.getString("category_no"));
				cago.setCategogyName(rs.getString("CATEGORY_NAME"));
				cagoList.add(cago);
			}
			
		} catch(SQLException e) {
			System.out.println("[에러]selectAllCategoryList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		
		return cagoList;
	}
	
	public int updateCategory(String no,String name ,String newName) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows = 0;
		try {
			con=getConnection();
			if(no==null) {
				String sql = "update item_category set category_name = ? where category_name =?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, newName);
			} else {
				String sql = "update item_category set category_name = ? where category_no =?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, no);
			}
			
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updateCategory 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}
	
	public int deleteCategory(String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows = 0;
		try {
			con=getConnection();
			
			String sql = "delete from item_category where category_name =?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, name);
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]deleteCategory 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}
	
	public int insertCategory(String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows = 0;
		try {
			con=getConnection();
			
			String sql = "insert into item_category values(CATEGORY_seq.nextval,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, name);
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]insertCategory 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}

		return rows;
	}
	
	
}
