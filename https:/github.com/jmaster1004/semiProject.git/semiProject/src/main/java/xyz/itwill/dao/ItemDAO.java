package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import xyz.itwill.dto.ItemDTO;

public class ItemDAO extends JdbcDAO {
	private static ItemDAO _dao;
	
	private ItemDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ItemDAO();
	}
	
	public static ItemDAO getDAO() {
		return _dao;
	}
	
	String joinSql= "select a.item_cd, a.item_nm,a.item_qty,a.item_price,a.category_no,b.category_name,a.item_main_image, a.item_ctt_image_1, "
			+ "a.item_ctt_image_2 ,a.item_ctt_image_3, a.item_status from item a left outer join item_category b on a.category_no = b.category_no";
	
	public int selectItemCount(int category, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			
			
			if (keyword.equals("")&&category==0) {
				String sql = "select count(*) from("+joinSql+") where item_status!=0";
				pstmt = con.prepareStatement(sql);

			} else if(keyword.equals("")&&category!=0) {
				String sql = "select count(*) from("+joinSql+") where item_status!=0 and category_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);

			} else if(!keyword.equals("")&&category==0) {
				String sql = "select count(*) from("+joinSql+") where "+search+" like '%'||?||'%' and item_status!=0";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			} else {
				String sql = "select count(*) from("+joinSql+") where category_no=? "+search+" like '%'||?||'%' and item_status!=0";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);
				pstmt.setString(2, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectItemCount 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return count;
	}
	
	
	public List<ItemDTO> selectCategoryItemList(int category, int startRow, int endRow, String search, String keyword, int sort) {
		Connection con =null;
		PreparedStatement pstmt= null;
		ResultSet rs=null;
		List<ItemDTO> itemList=new ArrayList<ItemDTO>();
		
		String sortValue="";
		if(sort==0) {
			sortValue = "item_cd desc";
		}else if(sort==11) {
			sortValue = "item_cd desc";
		}else if(sort==22) {
			sortValue = "item_nm";
		}else if(sort==33) {
			sortValue = "item_price";
		}else if(sort==44) {
			sortValue = "item_price desc";
		}
		
		try {
			con=getConnection();
			
			if (keyword.equals("")&&category==0) {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where item_status!=0 order by "+sortValue+")temp)where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);	

			} else if(keyword.equals("")&&category!=0) {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where item_status!=0 and a.category_no=? order by "+sortValue+")temp)where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else if(!keyword.equals("")&&category==0) {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where "+search+" like '%'||?||'%' and item_status!=0 order by "+sortValue+")temp)where rn between ? and ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where a.category_no=? "+search+" like '%'||?||'%' and item_status!=0 order by "+sortValue+")temp)where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
			}
			
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ItemDTO item=new ItemDTO();
				item.setItemCd(rs.getInt("item_cd"));
				item.setItemNm(rs.getString("item_nm"));
				item.setItemQty(rs.getString("item_qty"));
				item.setItemPrice(rs.getInt("item_price"));
				item.setCategoryNo(rs.getInt("category_no"));
				item.setCategoryName(rs.getString("category_name"));
				item.setItemMainImage(rs.getString("item_main_image"));
				item.setItemCttImage1(rs.getString("item_ctt_image_1"));
				item.setItemCttImage2(rs.getString("item_ctt_image_2"));
				item.setItemCttImage3(rs.getString("item_ctt_image_3"));
				itemList.add(item);				
			}

		} catch (Exception e) {
			System.out.println("[에러]selectCategoryItemList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return itemList;		
	}
	
	public ItemDTO selectNumItem(int code) {
		Connection con =null;
		PreparedStatement pstmt= null;
		ResultSet rs= null;
		ItemDTO item= null;
		try {
			con=getConnection();
			
			String sql = "select * from ("+joinSql+") where item_cd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				item=new ItemDTO();
				item.setItemCd(rs.getInt("item_cd"));
				item.setItemNm(rs.getString("item_nm"));
				item.setItemQty(rs.getString("item_qty"));
				item.setItemPrice(rs.getInt("item_price"));
				item.setCategoryNo(rs.getInt("category_no"));
				item.setCategoryName(rs.getString("category_name"));
				item.setItemMainImage(rs.getString("item_main_image"));
				item.setItemCttImage1(rs.getString("item_ctt_image_1"));
				item.setItemCttImage2(rs.getString("item_ctt_image_2"));
				item.setItemCttImage3(rs.getString("item_ctt_image_3"));
			}

		} catch (Exception e) {
			System.out.println("[에러]selectNumItem 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return item;		
	}
		
	public int insertItem(ItemDTO item) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into item values(item_seq.nextval,?,?,?,?,?,?,?,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, item.getItemNm());
			pstmt.setString(2, item.getItemQty());
			pstmt.setInt(3, item.getItemPrice());
			pstmt.setInt(4, item.getCategoryNo());
			pstmt.setString(5, item.getItemMainImage());
			pstmt.setString(6, item.getItemCttImage1());
			pstmt.setString(7, item.getItemCttImage2());
			pstmt.setString(8, item.getItemCttImage3());
			
			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertItem 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int updateItem(ItemDTO item) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "update item set item_nm=?, item_qty=?, item_price=?, category_no=?, item_main_image=?, item_ctt_image_1=?, item_ctt_image_2=?, item_ctt_image_3=? where item_cd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, item.getItemNm());
			pstmt.setString(2, item.getItemQty());
			pstmt.setInt(3, item.getItemPrice());
			pstmt.setInt(4, item.getCategoryNo());
			pstmt.setString(5, item.getItemMainImage());
			pstmt.setString(6, item.getItemCttImage1());
			pstmt.setString(7, item.getItemCttImage2());
			pstmt.setString(8, item.getItemCttImage3());
			pstmt.setInt(9, item.getItemCd());
			
			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateItem 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	public int deleteItem(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update item set item_status=0 where item_cd=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteItem 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}
