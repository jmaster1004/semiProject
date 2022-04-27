package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.NoticeDTO;
import xyz.itwill.dto.QaDTO;

public class NoticeDAO extends JdbcDAO {
	private static NoticeDAO _dao;

	private NoticeDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new NoticeDAO();
	}

	public static NoticeDAO getDAO() {
		return _dao;
	}

	String joinSql = "select a.notice_no, a.member_email,b.member_name,a.notice_title,a.notice_content,a.notice_image,a.notice_regdate,a.notice_hit,a.notice_status"
			+ " from notice a left outer join member b on a.member_email = b.member_email";

	// BOARD 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드
	// => 검색 기능을 제공하기 위해 매개변수에 검색 관련 값을 전달받아 저장
	public int selectNoticeCount(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "select count(*) from notice where notice_status!=0";
				pstmt = con.prepareStatement(sql);
			} else {
				String sql = "select count(*) from (" + joinSql + ") where " + search
						+ " like '%'||?||'%' and notice_status!=0";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeCount 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return count;
	}

	// 시작 행번호와 종료 행번호를 전달받아 BOARD 테이블에 저장된 해당 행범위의 QnA을 검색하여 반환하는 메소
	public List<NoticeDTO> selectAllList(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where notice_status!=0 order by notice_status desc, notice_no desc)temp)where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);

			} else {
				String sql = "select * from(select rownum rn, temp.* from("+joinSql+" where "+search+" like '%'||?||'%' and notice_status!=0 order by notice_status desc, notice_no desc)temp)where rn between ? and ?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			

			rs = pstmt.executeQuery();


			while (rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setNoticeNo(rs.getInt("notice_no"));
				notice.setMemberEmail(rs.getString("member_email"));
				notice.setMemberName(rs.getString("member_name"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeContent(rs.getString("notice_content"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeRegDate(rs.getString("notice_regdate"));
				notice.setNoticeHit(rs.getInt("notice_hit"));
				notice.setNoticeStatus(rs.getInt("notice_status"));
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllList 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}

		return noticeList;
	}

	// 게시글을 전달받아 BOARD 테이블에 삽입하여 저장하고 삽입행의 갯수를 반환하는 메소드
	public int insertNotice(NoticeDTO notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into notice values(?,?,?,?,?,sysdate,0,?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNoticeNo());
			pstmt.setString(2, notice.getMemberEmail());
			pstmt.setString(3, notice.getNoticeTitle());
			pstmt.setString(4, notice.getNoticeContent());
			pstmt.setString(5, notice.getNoticeImage());
			pstmt.setInt(6, notice.getNoticeStatus());
			

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertNotice 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 게시글을 검색하여 반환하는 메소드
	public NoticeDTO selectNoNotice(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO notice = null;
		try {
			con = getConnection();

			String sql = joinSql+" where notice_no = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setNoticeNo(rs.getInt("notice_no"));
				notice.setMemberEmail(rs.getString("member_email"));
				notice.setMemberName(rs.getString("member_name"));
				notice.setNoticeTitle(rs.getString("notice_title"));
				notice.setNoticeContent(rs.getString("notice_content"));
				notice.setNoticeImage(rs.getString("notice_image"));
				notice.setNoticeRegDate(rs.getString("notice_regdate"));
				notice.setNoticeHit(rs.getInt("notice_hit"));
				notice.setNoticeStatus(rs.getInt("notice_status"));

			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoNotice 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
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

			String sql = "select notice_seq.nextval from dual";
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

	// 글번호를 전달받아 테이블에 저장된 해당 글번호의 QnA을 삭제 처리하고
	// 삭제행의 갯수를 반환하는 메소드
	public int deleteNotice(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "update notice set notice_status=0 where notice_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]deleteNotice 메소드의 SQL 오류 = " + e.getMessage());
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

			String sql = "update notice set notice_hit=notice_hit+1 where notice_no=?";
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