package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.OrdersDTO;

public class OrdersDAO extends JdbcDAO {
	private static OrdersDAO _dao;
	
	public OrdersDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new OrdersDAO();
	}
	
	public static OrdersDAO getDAO() {
		return _dao;
	}
	
	//주문 입력 insert
	//게시글을 전달받아 REVIEW 테이블에 삽입하여 저장하고 삽입행의 갯수를 반환하는 메소드
	public int insertOrders(OrdersDTO orders) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into orders values(ORDER_seq.nextval,?,?,sysdate,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			//pstmt.setInt(2, orders.getOrderNo());
			pstmt.setString(1, orders.getItemCd());
			pstmt.setString(2, orders.getMemberEmail());
			pstmt.setInt(3, orders.getOrderStatus());
			pstmt.setInt(4, orders.getOrderQuantity());
			pstmt.setString(5, orders.getOrderAddress1());
			pstmt.setString(6, orders.getOrderAddress2());
			pstmt.setString(7, orders.getOrderZipcode());
			pstmt.setString(8, orders.getOrderPhone());
			pstmt.setString(9, orders.getOrderName());
			pstmt.setString(10, orders.getOrderMemo());
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]insertOrders 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//주문 수정 update
	public int updateOrders(OrdersDTO orders) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update orders order_status=?, order_quantity=?, order_address1=?, order_address2=?, "
					+ "order_zipcode=?, order_phone=?, order_name=? where order_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orders.getOrderStatus());
			pstmt.setInt(2, orders.getOrderQuantity());
			pstmt.setString(3, orders.getOrderAddress1());
			pstmt.setString(4, orders.getOrderAddress2());
			pstmt.setString(5, orders.getOrderZipcode());
			pstmt.setString(6, orders.getOrderPhone());
			pstmt.setString(7, orders.getOrderName());
			pstmt.setInt(8, orders.getOrderNo());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateOrders 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//주문 삭제 delete
	public int deleteOrders(int orderNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from orders where orderNo=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orderNo);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteOrders 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//시작 행번호와 게시글 종료 행번호를 전달받아 orders 테이블에 저장된 해당 행 범위의 게시글을 검색하여 반환하는 DAO 클래스의 메소드를 호출 
	public List<OrdersDTO> selectOrdersList(int orderStatus, int startRow, int endRow, String memberEmail) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> ordersList = new ArrayList<OrdersDTO>();
		
		try {
			
			con=getConnection();

			
			if(orderStatus==0) {
				String sql="select * from (select rownum rn,temp.* from "
						+ "(select o.order_date, o.order_no, i.item_cd, i.item_nm, o.order_quantity, i.item_price, o.order_status "
						+ "from orders o join item i on o.item_cd = i.item_cd join member m on o.member_email = m.member_email "
						+ "where m.member_email=? order by o.order_no desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, memberEmail);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from "
						+ "(select o.order_date, o.order_no, i.item_cd, i.item_nm, o.order_quantity, i.item_price, o.order_status "
						+ "from orders o join item i on o.item_cd = i.item_cd "
						+ "join member m on o.member_email = m.member_email where o.order_status=? and m.member_email=? order by o.order_no desc) "
						+ "temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, orderStatus);
				pstmt.setString(2, memberEmail);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
			}
			
			/*String sql="select o.order_date, o.order_no, i.item_nm, o.order_quantity, o.order_status from orders o join item i on o.item_cd=i.item_cd join member m on o.member_email=m.member_email order by o.order_date desc";
			pstmt=con.prepareStatement(sql);*/
				
			rs=pstmt.executeQuery();
			while(rs.next()){
				OrdersDTO orders = new OrdersDTO();
				orders.setOrderDate(rs.getString("order_date"));
				orders.setOrderNo(rs.getInt("order_no"));
				orders.setItemCd(rs.getString("item_cd"));
				orders.setItemNm(rs.getString("item_nm"));
				orders.setOrderQuantity(rs.getInt("order_quantity"));
				orders.setItemPrice(rs.getInt("item_price"));
				orders.setOrderStatus(rs.getInt("order_status"));
				//orders.setMemberEmail(rs.getString("member_email"));
				//orders.setOrderAddress(rs.getString("order_address1"));
				//orders.setOrderAddress2(rs.getString("order_address2"));
				//orders.setOrderZipcode(rs.getInt("order_zipcode"));
				//orders.setOrderPhone(rs.getString("order_phone"));
				//orders.setOrderName(rs.getString("order_name"));
				//orders.setOrderMemo(rs.getString("order_memo"));
				ordersList.add(orders);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrdersList 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return ordersList;
	}
	
	public List<OrdersDTO> selectAllOrdersList(int orderStatus, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> ordersList = new ArrayList<OrdersDTO>();
		try {
			con=getConnection();
			
			if(orderStatus!=0) {
				String sql = "select * from (select rownum rn, temp.* from (select o.member_email, m.member_name, o.order_date, o.order_no, i.item_cd, i.item_nm, o.order_quantity, i.item_price, o.order_status from orders o join item i on o.item_cd = i.item_cd join member m on o.member_email = m.member_email where o.order_status=  ? order by o.order_no) temp)  where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, orderStatus);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
			} else {
				String sql = "select * from (select rownum rn, temp.* from (select o.member_email, m.member_name, o.order_date, o.order_no, i.item_cd, i.item_nm, o.order_quantity, i.item_price, o.order_status from orders o join item i on o.item_cd = i.item_cd join member m on o.member_email = m.member_email order by o.order_no) temp)  where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			}
			rs=pstmt.executeQuery();
			while(rs.next()){
				OrdersDTO orders = new OrdersDTO();
				orders.setMemberEmail(rs.getString("member_email"));
				orders.setMemberName(rs.getString("member_name"));
				orders.setOrderDate(rs.getString("order_date"));
				orders.setOrderNo(rs.getInt("order_no"));
				orders.setItemCd(rs.getString("item_cd"));
				orders.setItemNm(rs.getString("item_nm"));
				orders.setOrderQuantity(rs.getInt("order_quantity"));
				orders.setItemPrice(rs.getInt("item_price"));
				orders.setOrderStatus(rs.getInt("order_status"));
				ordersList.add(orders);
			}
			
		} catch(SQLException e) {
			System.out.println("[에러]selectAllOrdersList 메소드의 SQL 오류 = "+e.getMessage());
		}finally {
			close(con, pstmt, rs);
		}
		return ordersList;
	}
	
	
	//시퀀스
	public int selectNextNo() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNo=0;
		try {
			con=getConnection();
			
			String sql="select orders_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNo=rs.getInt(1);
			}
					
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNo;
	}
	
	//Orders 테이블에 저장된 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectOrdersCount(String email) {
        Connection con=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;

        int count=0;
        try {
            con=getConnection();
            if(email==null) {
            	String sql="select count(*) from orders";
            	pstmt=con.prepareStatement(sql);
            } else {
            	String sql="select count(*) from orders where member_email=?";
            	pstmt=con.prepareStatement(sql);
            	pstmt.setString(1, email);
            }

            rs=pstmt.executeQuery();

            if(rs.next()) {
                count=rs.getInt(1); 
            }

        }catch (SQLException e) {
            System.out.println("[에러]selectOrdersCount 메소드의 SQL 오류 = "+e.getMessage());
        } finally {
            close(con, pstmt, rs);
        }
        return count;
    }
	
	//제품정보를 전달받아 ORDER 테이블에 저장된 해당 주문번호의 주문정보를 검색후 반환
	public OrdersDTO selectNoOrders(int orderNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		OrdersDTO orders=null;
		try {
			con=getConnection();
			
			String sql="select * from product where orderNo=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orderNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				orders=new OrdersDTO();
				orders.setOrderNo(rs.getInt("order_No"));
				orders.setMemberEmail(rs.getString("member_email"));
				orders.setOrderDate(rs.getString("order_date"));
				orders.setItemCd(rs.getString("item_cd"));
				orders.setOrderStatus(rs.getInt("order_status"));
				orders.setOrderQuantity(rs.getInt("order_quantity"));
				orders.setOrderAddress1(rs.getString("order_address1"));
				orders.setOrderAddress2(rs.getString("order_address2"));
				orders.setOrderZipcode(rs.getString("order_zipcode"));
				orders.setOrderPhone(rs.getString("order_phone"));
				orders.setOrderName(rs.getString("order_name"));
				orders.setOrderMemo(rs.getString("order_memo"));
			}
		}catch (SQLException e) {
			System.out.println("[에러]selectNoOrders 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orders;
	}
	
	public int updateOrderStatus(String orderNo, String status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update orders set order_status=? where order_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setString(2, orderNo);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	public int cancelOrderStatus(int orderNo, String status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update orders set order_status=? where order_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, status);
			pstmt.setInt(2, orderNo);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
}