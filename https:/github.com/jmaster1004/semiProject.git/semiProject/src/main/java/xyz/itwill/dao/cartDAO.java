package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.cartDTO;

public class cartDAO extends JdbcDAO {
	private static cartDAO _dao;
	 
	private cartDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new cartDAO();
	}
	
	public static cartDAO getDAO() {
		return _dao;
	}
	
	// 장바구니 추가
	public int insertCart(cartDTO cart) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into cart values(CART_seq.nextval,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart.getItemCD());
			pstmt.setString(2, cart.getMemberEmail());
			pstmt.setInt(3, cart.getCartEach());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//장바구니 수정
	public int updateCart(String itemCD, String each ) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update cart set CART_EACH = ? where ITEM_CD = ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, each);
			pstmt.setString(2, itemCD);

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//장바구니 삭제
	public int deleteCart(String cartNO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from cart where CART_NO = ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cartNO);


			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int deleteAllCart(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from cart where MEMBER_EMAIL = ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);


			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteAllCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//장바구니 전체 조회
	public List<cartDTO> selectAllCart(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<cartDTO> cartList = new ArrayList<cartDTO>();
		try {
			con=getConnection();
			
			String sql="select C.CART_NO, C.ITEM_CD, C.MEMBER_EMAIL, I.ITEM_NM, I.ITEM_MAIN_IMAGE, I.ITEM_PRICE, C.CART_EACH from CART C join ITEM I on C.ITEM_CD = I.ITEM_CD where C.MEMBER_EMAIL = ? order by CART_NO";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				cartDTO cart = new cartDTO();
				cart.setCartNo(rs.getInt("CART_NO"));
				cart.setItemCD(rs.getString("ITEM_CD"));
				cart.setMemberEmail(rs.getString("MEMBER_EMAIL"));
				cart.setItemMainImage(rs.getString("ITEM_MAIN_IMAGE"));
				cart.setItemNM(rs.getString("ITEM_NM"));
				cart.setItem_price(rs.getInt("ITEM_PRICE"));
				cart.setCartEach(rs.getInt("CART_EACH"));
				cartList.add(cart);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllCart 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return cartList;
	}
	
	//장바구니 조회
		public List<cartDTO> selectCart(String cartNo,String id) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<cartDTO> cartList = new ArrayList<cartDTO>();
			try {
				con=getConnection();
				
				String sql="select  C.ITEM_CD, I.ITEM_NM, I.ITEM_MAIN_IMAGE, I.ITEM_PRICE, C.CART_EACH from CART C join ITEM I on C.ITEM_CD = I.ITEM_CD where C.CART_NO =? and C.MEMBER_EMAIL = ? order by CART_NO";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, cartNo);
				pstmt.setString(2, id);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					cartDTO cart = new cartDTO();
					cart.setItemCD(rs.getString("ITEM_CD"));
					cart.setItemMainImage(rs.getString("ITEM_MAIN_IMAGE"));
					cart.setItemNM(rs.getString("ITEM_NM"));
					cart.setItem_price(rs.getInt("ITEM_PRICE"));
					cart.setCartEach(rs.getInt("CART_EACH"));
					cartList.add(cart);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectCart 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return cartList;
		}
		
		public int selectUnitCart(String itemCD,String id) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int rows =0;
			try {
				con=getConnection();
				
				String sql="select COUNT(*) from CART where ITEM_CD =? and MEMBER_EMAIL = ?";
				pstmt=con.prepareStatement(sql);
				
				pstmt.setString(1, itemCD);
				pstmt.setString(2, id);
				
				rs=pstmt.executeQuery();
				
				rs.next();
				rows=rs.getInt("count(*)");
			} catch (SQLException e) {
				System.out.println("[에러]selectUnitCart 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rows;
		}

		//장바구니 갯수
		public int selectCartRows(String id) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			int rows = 0;
			try {
				con=getConnection();
				
				String sql="select count(*) from cart where MEMBER_EMAIL = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs=pstmt.executeQuery();
				rs.next();
				rows =rs.getInt("count(*)");
				
			} catch (SQLException e) {
				System.out.println("[에러]selectCartRows 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return rows;
		}
}
