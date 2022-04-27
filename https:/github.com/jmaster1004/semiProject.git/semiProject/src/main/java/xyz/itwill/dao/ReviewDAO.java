package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ReviewDTO;


public class ReviewDAO extends JdbcDAO {
	private static ReviewDAO _dao;
	
	public ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	
	public static ReviewDAO getDAO() {
		return _dao;
	}
	
	//게시글을 전달받아 REVIEW 테이블에 삽입하여 저장하고 삽입행의 갯수를 반환하는 메소드
	public int insertReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into review values(REVIEW_seq.nextval,?,?,?,?,?,sysdate,0,?)";
			pstmt=con.prepareStatement(sql);
			//pstmt.setInt(1, review.getReviewNo());
			pstmt.setString(1, review.getItemCd());
			pstmt.setString(2, review.getMemberEmail());
			pstmt.setString(3, review.getReviewTitle());
			pstmt.setString(4, review.getReviewContent());
			pstmt.setInt(5, review.getReviewGrade());
			pstmt.setString(6, review.getReviewImg());
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]insertReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 REVIEW 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 메소드
	public ReviewDTO selectNoReview(int reviewNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review=null;
		try {
			con=getConnection();
			
			String sql="select * from review r join item i on r.item_cd=i.item_cd where r.review_no=?";
			//String sql="select * from review where review_no=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				review=new ReviewDTO();
				review.setReviewNo(rs.getInt("review_no"));
				review.setItemCd(rs.getString("item_cd"));
				review.setItemNm(rs.getString("item_nm"));
				review.setMemberEmail(rs.getString("member_email"));
				review.setReviewTitle(rs.getString("review_title"));
				review.setReviewContent(rs.getString("review_content"));
				review.setReviewGrade(rs.getInt("review_grade"));
				review.setReviewDate(rs.getString("review_date"));
				review.setReviewCount(rs.getInt("review_count"));
				review.setReviewImg(rs.getString("review_img"));
				//review.setMemberName(rs.getString("member_name"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return review;
	}

	
	//REVIEW 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 관련 기능을 제공하기 위해 매개변수에 검색 관련 값을 전달받아 저장
	//public int selectBoardCount() {////갯수 반환하니까 반환형 int, 전체 게시글이니까 전달값 X
	public int selectReviewCount(String search, String keyword, String email, String code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		int count=0;
		try {
			con=getConnection();
			
			StringBuffer sql = new StringBuffer("select count(*) from (select r.review_no, r.review_title, m.member_name, r.review_grade, r.review_count, r.review_date ");
			sql.append("from review r join item i on r.item_cd=i.item_cd join member m on r.member_email=m.member_email ");
			
			if(code!=null) {
				if(email==null) {
					if(keyword.equals("")) {
						sql.append("where r.item_cd = ?)");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, code);
					} else {//검색 기능을 사용할 경우
						//비교컬럼(search)에 검색단어(keyword)가 포함된 게시글의 갯수 검색
						sql.append("where "+search+" like '%'||?||'%'");
						sql.append("and r.item_cd = ?)");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, keyword);
						pstmt.setString(2, code);
					}
				} else {
					if(keyword.equals("")) {
						sql.append("where m.member_email = ? and r.item_cd = ? )");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, email);
						pstmt.setString(2, code);
					} else {//검색 기능을 사용할 경우
						//비교컬럼(search)에 검색단어(keyword)가 포함된 게시글의 갯수 검색
						sql.append("where "+search+" like '%'||?||'% and m.member_email = ? and r.item_cd =?')");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, keyword);
						pstmt.setString(2, email);
						pstmt.setString(2, code);
					}
				}
			} else {
				if(email==null) {
					if(keyword.equals("")) {
						sql.append(")");
						pstmt=con.prepareStatement(sql.toString());
					} else {//검색 기능을 사용할 경우
						//비교컬럼(search)에 검색단어(keyword)가 포함된 게시글의 갯수 검색
						sql.append("where "+search+" like '%'||?||'%')");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, keyword);
					}
				} else {
					if(keyword.equals("")) {
						sql.append("where m.member_email = ?)");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, email);
					} else {//검색 기능을 사용할 경우
						//비교컬럼(search)에 검색단어(keyword)가 포함된 게시글의 갯수 검색
						sql.append("where "+search+" like '%'||?||'% and m.member_email = ?')");
						pstmt=con.prepareStatement(sql.toString());
						pstmt.setString(1, keyword);
						pstmt.setString(2, email);
					}
				}
			}
			
			
			
			
			
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1); 
			}
			
		}catch (SQLException e) {
			System.out.println("[에러]selectReviewCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	
	
	//시작 행번호와 게시글 종료 행번호를 전달받아 Review 테이블에 저장된
	//	해당 행 범위의 게시글을 검색하여 반환하는 DAO 클래스의 메소드를 호출 
	//public List<BoardDTO> selectBoardList(int startRow, int endRow) {////시작행번호와 종료행번호를 전달받아 검색해서 그 결과를 list로 만들어서 반환
	public List<ReviewDTO> selectReviewList(int startRow, int endRow, String search, String keyword, int sort, String email) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
		
		//0최신순,1최신순,2별점순,3조회순
		String sortValue="";
		if(sort==0) {
			sortValue = "review_no desc";
		}else if(sort==1) {
			sortValue = "review_no desc";
		} else if(sort==2) {
			sortValue = "review_grade desc";
		} else if(sort==3) {
			sortValue = "review_count desc";
		}
		
		try {
			con=getConnection();
			if(email==null) {
				if(keyword.equals("")) {//검색기능을 사용하지 않은 경우
					String sql="select * from (select rownum rn,temp.* from "
							+ "(select r.review_no, r.review_title, i.item_cd, i.item_nm, m.member_name, r.review_grade, r.review_count, r.review_date "
							+ "from review r join item i on r.item_cd=i.item_cd join member m on r.member_email=m.member_email "
							+ "order by "+ sortValue+") temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
				} else { //검색기능을 사용한 경우
					String sql="select * from (select rownum rn,temp.* from "
							+ "(select r.review_no, r.review_title, i.item_cd, i.item_nm, m.member_name, r.review_grade, r.review_count, r.review_date "
							+ "from review r join item i on r.item_cd=i.item_cd join member m on r.member_email=m.member_email "
							+ "where "+search+" like '%'||?||'%' order by "+ sortValue+") temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
				} 
			} else {
				if(keyword.equals("")) {//검색기능을 사용하지 않은 경우
					String sql="select * from (select rownum rn,temp.* from "
							+ "(select r.review_no, r.review_title, i.item_cd, i.item_nm, m.member_name, r.review_grade, r.review_count, r.review_date "
							+ "from review r join item i on r.item_cd=i.item_cd join member m on r.member_email=m.member_email where m.member_email= ?"
							+ "order by "+ sortValue+") temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, email);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				} else{ //검색기능을 사용한 경우
					String sql="select * from (select rownum rn,temp.* from "
							+ "(select r.review_no, r.review_title, i.item_cd, i.item_nm, m.member_name, r.review_grade, r.review_count, r.review_date "
							+ "from review r join item i on r.item_cd=i.item_cd join member m on r.member_email=m.member_email "
							+ "where "+search+" like '%'||?||'%' and m.member_email= ? order by "+ sortValue+") temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setString(2, email);
					pstmt.setInt(3, startRow);
					pstmt.setInt(4, endRow);
					
				} 
			
			}
		
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review=new ReviewDTO();
				review.setReviewNo(rs.getInt("review_no"));
				review.setReviewTitle(rs.getString("review_title"));
				review.setItemCd(rs.getString("item_cd"));
				review.setItemNm(rs.getString("item_nm"));
				review.setMemberName(rs.getString("member_name"));
				review.setReviewGrade(rs.getInt("review_grade"));
				review.setReviewCount(rs.getInt("review_count"));
				review.setReviewDate(rs.getString("review_date"));
				//review.setMemberEmail(rs.getString("member_email"));
				//review.setReviewContent(rs.getString("review_content"));
				//review.setReviewImg(rs.getString("review_img"));
				reviewList.add(review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}


	//REVIEW_SEQ 시퀀스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNo() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select review_seq.nextval from dual"; 
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
					
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNo 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}

	//제품정보를 전달받아 PRODUCT 테이블에 저장된 제품정보를 변경하고 변경행의 갯수를 반환하는 메소드 
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set review_title=?, review_content=?, review_grade=?, review_img=? where review_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getReviewTitle());
			pstmt.setString(2, review.getReviewContent());
			pstmt.setInt(3, review.getReviewGrade());
			pstmt.setString(4, review.getReviewImg());
			pstmt.setInt(5, review.getReviewNo());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//글번호를 전달받아 BOARD 테이블에 저장된 해당 글번호의 게시글 조회수를 변경(증가)하고 변경행의 갯수를 반환하는 메소드
	public int updateReviewCount(int reviewNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set review_count=review_count+1 where review_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewNo);
			
			rows=pstmt.executeUpdate();
		}catch (SQLException e) {
			System.out.println("[에러]updateReviewCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 삭제하고
	//	삭제행의 갯수를 반환하는 메소드
	public int deleteReview(int reviewNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			String sql="delete from review where review_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, reviewNo);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}