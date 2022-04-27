package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.QaDTO;

public class QaDAO extends JdbcDAO {
	private static QaDAO _dao;

	private QaDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new QaDAO();
	}

	public static QaDAO getDAO() {
		return _dao;
	}

	String joinSql = "select a.qa_no,a.member_email,b.member_name,a.qa_title,a.qa_content,a.qa_date,a.qa_hit,a.qa_ref,a.qa_re_order,a.qa_re_level,a.qa_status "
			+ "from qa a left outer join member b on a.member_email = b.member_email";

	// BOARD 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 제공하기 위해 매개변수에 검색 관련 값을 전달받아 저장
	public int selectQaCount(String search, String keyword, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();
			if(email==null) {
				if (keyword.equals("")) {
					String sql = "select count(*) from qa";
					pstmt = con.prepareStatement(sql);
				} else {
					String sql = "select count(*) from (" + joinSql + ") where " + search
							+ " like '%'||?||'%' and qa_status!=0";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
				
			} else {
				if (keyword.equals("")) {
					String sql = "select count(*) from qa where member_email =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, email);
				} else {
					String sql = "select count(*) from (" + joinSql + ") where " + search
							+ " like '%'||?||'%' and qa_status!=0 and member_email =?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setString(2, email);
				}
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQaCount 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return count;
	}

	// 시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 해당 행범위의 QnA을 검색하여 반환하는 메소
	public List<QaDTO> selectAllList(int startRow, int endRow, String search, String keyword, String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QaDTO> qaList = new ArrayList<QaDTO>();
		try {
			con = getConnection();
			if(email==null) {
				if (keyword.equals("")) {
					String sql = "select * from(" + "select rownum rn, temp.* from("
							+ "select a.qa_no,a.member_email,b.member_name,a.qa_title,a.qa_content,a.qa_date,a.qa_hit,a.qa_ref,a.qa_re_order,a.qa_re_level,a.qa_status "
							+ "from qa a left outer join member b on a.member_email = b.member_email order by qa_ref desc, qa_re_order)temp"
							+ ") where rn between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, startRow);
					pstmt.setInt(2, endRow);
					
				} else {
					String sql = "select * from(select rownum rn, temp.* from(select a.qa_no,a.member_email,b.member_name,a.qa_title,a.qa_content,a.qa_date,a.qa_hit,a.qa_ref,a.qa_re_order,a.qa_re_level,a.qa_status from qa a left outer join member b on a.member_email = b.member_email where "+search+" like '%'||?||'%' and qa_status!=0 order by qa_ref desc, qa_re_order)temp)where rn between ? and ?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				}
			} else {
				if (keyword.equals("")) {
					String sql = "select * from(" + "select rownum rn, temp.* from("
							+ "select a.qa_no,a.member_email,b.member_name,a.qa_title,a.qa_content,a.qa_date,a.qa_hit,a.qa_ref,a.qa_re_order,a.qa_re_level,a.qa_status "
							+ "from qa a left outer join member b on a.member_email = b.member_email where b.member_email = ? order by qa_ref desc, qa_re_order)temp"
							+ ") where rn between ? and ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, email);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
					
				} else {
					String sql = "select * from(select rownum rn, temp.* from(select a.qa_no,a.member_email,b.member_name,a.qa_title,a.qa_content,a.qa_date,a.qa_hit,a.qa_ref,a.qa_re_order,a.qa_re_level,a.qa_status from qa a left outer join member b on a.member_email = b.member_email where "+search+" like '%'||?||'%' and qa_status!=0 and b.member_email = ? order by qa_ref desc, qa_re_order)temp)where rn between ? and ?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setString(2, email);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
				}
			}
			
			rs = pstmt.executeQuery();

			while (rs.next()) {
				QaDTO qa = new QaDTO();
				qa.setQaNo(rs.getInt("qa_no"));
				qa.setMemberEmail(rs.getString("member_email"));
				qa.setMemberName(rs.getString("member_name"));
				qa.setQaTitle(rs.getString("qa_title"));
				qa.setQaContent(rs.getString("qa_content"));
				qa.setQaDate(rs.getString("qa_date"));
				qa.setQaHit(rs.getInt("qa_hit"));
				qa.setQaRef(rs.getInt("qa_ref"));
				qa.setQaReOrder(rs.getInt("qa_re_order"));
				qa.setQaReLevel(rs.getInt("qa_re_level"));
				qa.setQaStatus(rs.getInt("qa_status"));
				qaList.add(qa);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return qaList;
	}

	// 게시글을 전달받아 BOARD 테이블에 삽입하여 저장하고 삽입행의 갯수를 반환하는 메소드
	public int insertQa(QaDTO qa) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into qa values(?,?,?,?,sysdate,0,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qa.getQaNo());
			pstmt.setString(2, qa.getMemberEmail());
			pstmt.setString(3, qa.getQaTitle());
			pstmt.setString(4, qa.getQaContent());
			pstmt.setInt(5, qa.getQaRef());
			pstmt.setInt(6, qa.getQaReOrder());
			pstmt.setInt(7, qa.getQaReLevel());
			pstmt.setInt(8, qa.getQaStatus());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertQa 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 메소드
	public QaDTO selectNoQa(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QaDTO qa = null;
		try {
			con = getConnection();

			String sql = joinSql+" where qa_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				qa = new QaDTO();
				qa.setQaNo(rs.getInt("qa_no"));
				qa.setMemberEmail(rs.getString("member_email"));
				qa.setMemberName(rs.getString("member_name"));
				qa.setQaTitle(rs.getString("qa_title"));
				qa.setQaContent(rs.getString("qa_content"));
				qa.setQaDate(rs.getString("qa_date"));
				qa.setQaHit(rs.getInt("qa_hit"));
				qa.setQaRef(rs.getInt("qa_ref"));
				qa.setQaReOrder(rs.getInt("qa_re_order"));
				qa.setQaReLevel(rs.getInt("qa_re_level"));
				qa.setQaStatus(rs.getInt("qa_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoQa 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qa;
	}

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 QnA 조뢰수를 변경(증가)
	// 하고 변경행의 갯수를 반환하는 메소드

	public int updateQa(QaDTO qa) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update qa set qa_title=?,qa_content=?,qa_status=? where qa_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qa.getQaTitle());
			pstmt.setString(2, qa.getQaContent());
			pstmt.setInt(3, qa.getQaStatus());
			pstmt.setInt(4, qa.getQaNo());

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateQa 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// QA_SEQ 시퀀스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNo() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNo = 0;
		try {
			con = getConnection();

			String sql = "select qa_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				nextNo = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNo 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return nextNo;
	}

	// 테이블에 저장된 게시글 중 조건에 맞는 게시글의 RE_ORDER 컬럼값을 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateReOrder(int ref, int reOrder) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update qa set re_order=re_order+1 where ref=? and re_order>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reOrder);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updateReOrder 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 QnA을 삭제 처리하고
	// 삭제행의 갯수를 반환하는 메소드
	public int deleteQa(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update qa set qa_status=0 where qa_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]deleteQa 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 QnA 조회수를 변경
	// 하고 변경행의 갯수를 반환하는 메소드
	public int updateHit(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update qa set qa_hit=qa_hit+1 where qa_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]updatehit 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}         