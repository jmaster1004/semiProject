package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.MemberDTO;

public class MemberDAO extends JdbcDAO {
	private static MemberDAO _dao;
	 
	private MemberDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static{
		_dao=new MemberDAO();
	}
	
	public static MemberDAO getDAO() {
		return _dao;
	}

	//회원가입
	public int insertMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			String sql="insert into member values(?,?,?,?,?,?,?,0)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member.getMemberEmail());
			pstmt.setString(2, member.getMemberPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getMemberAddress1());
			pstmt.setString(5, member.getMemberAddress2());
			pstmt.setString(6, member.getMemberZipcode());
			pstmt.setString(7, member.getMemberPhone());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//
	public MemberDTO selectEmailMember(String email) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberDTO member=null;

		try {
			con=getConnection();
			
			String sql="select * from member where member_email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				member=new MemberDTO();
				member.setMemberEmail(rs.getString("member_email"));
				member.setMemberPassword(rs.getString("member_password"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberAddress1(rs.getString("member_address1"));
				member.setMemberAddress2(rs.getString("member_address2"));
				member.setMemberZipcode(rs.getString("member_zipcode"));
				member.setMemberPhone(rs.getString("member_phone"));
				member.setMemberStatus(rs.getInt("member_status"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectIdMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return member;
	}

	//회원정보수정
	public int updateMember(MemberDTO member) {
        Connection con=null;
        PreparedStatement pstmt=null;
        int rows=0;
        try {
            con=getConnection();
            if(member.getMemberPassword()==null & (member.getMemberStatus()==0 || member.getMemberStatus()==9 || member.getMemberStatus()==11)) {

                String sql="update member set member_address1=?, member_address2=?"
                        +", member_zipcode=?,  member_phone =?, member_status=? where member_email=?";
                pstmt=con.prepareStatement(sql);
                pstmt.setString(1, member.getMemberAddress1());
                pstmt.setString(2, member.getMemberAddress2());
                pstmt.setString(3, member.getMemberZipcode());
                pstmt.setString(4, member.getMemberPhone());
                pstmt.setInt(5, member.getMemberStatus());
                pstmt.setString(6, member.getMemberEmail());

            } else {
                String sql="update member set member_password=?, member_address1=?, member_address2=?"
                                        +", member_zipcode=?,  member_phone =?  where member_email=?";
                pstmt=con.prepareStatement(sql);
                pstmt.setString(1, member.getMemberPassword());
                pstmt.setString(2, member.getMemberAddress1());
                pstmt.setString(3, member.getMemberAddress2());
                pstmt.setString(4, member.getMemberZipcode());
                pstmt.setString(5, member.getMemberPhone());
                pstmt.setString(6, member.getMemberEmail());
            }

            rows=pstmt.executeUpdate();
        } catch (SQLException e) {
            System.out.println("[에러]updateMember 메소드의 SQL 오류 = "+e.getMessage());
        } finally {
            close(con, pstmt);
        }
        return rows;
    }

	//회원탈퇴
	public int deleteMember(String email) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set member_status=11 where member_email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//전체회원조회
	public List<MemberDTO> selectAllMemberList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberDTO> memberList=new ArrayList<MemberDTO>();
		try {
			con=getConnection();
			
			String sql="select * from member where member_status = '0' or member_status = '11' order by member_email";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO member=new MemberDTO();
				member.setMemberEmail(rs.getString("member_email"));
				member.setMemberPassword(rs.getString("member_password"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberAddress1(rs.getString("member_address1"));
				member.setMemberAddress2(rs.getString("member_address2"));
				member.setMemberZipcode(rs.getString("member_zipcode"));
				member.setMemberPhone(rs.getString("member_phone"));
				member.setMemberStatus(rs.getInt("member_status"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllMemberList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}
	
	public List<MemberDTO> selectAllAdminList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberDTO> memberList=new ArrayList<MemberDTO>();
		try {
			con=getConnection();
			
			String sql="select * from member where member_status = '9'order by member_email";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO member=new MemberDTO();
				member.setMemberEmail(rs.getString("member_email"));
				member.setMemberPassword(rs.getString("member_password"));
				member.setMemberName(rs.getString("member_name"));
				member.setMemberAddress1(rs.getString("member_address1"));
				member.setMemberAddress2(rs.getString("member_address2"));
				member.setMemberZipcode(rs.getString("member_zipcode"));
				member.setMemberPhone(rs.getString("member_phone"));
				member.setMemberStatus(rs.getInt("member_status"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectAllMemberList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}
	
	//회원상태 수동수정
	public int updateStatus(String email, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set member_status=? where member _email=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, email);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//비밀번호 수정
	public int updatePasswdMember(MemberDTO member) {
	  Connection con=null;
	  PreparedStatement pstmt=null;
	       int rows=0;
	       try {
	            con=getConnection();
	        
	                String sql="update member set member_password=? where member_email=? AND member_name=? AND member_phone=?";
	                
	                pstmt=con.prepareStatement(sql);
	                pstmt.setString(1, member.getMemberPassword());
	                pstmt.setString(2, member.getMemberEmail());
	                pstmt.setString(3, member.getMemberName());
	                pstmt.setString(4, member.getMemberPhone());

	                rows=pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("[에러]updatePasswdMember 메소드의 SQL 오류 = "+e.getMessage());
	        } finally {
	            close(con, pstmt);
	        }
	        return rows;
	    }

		//이메일찾기 정보 일치 검색
		public MemberDTO serchEmailMember(String name, String phone) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			MemberDTO member=null;
		
			try {
				con=getConnection();
				
				String sql="select * from member where member_name=? AND member_phone=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, phone);
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					member=new MemberDTO();
					member.setMemberEmail(rs.getString("member_email"));
					member.setMemberName(rs.getString("member_name"));
					member.setMemberPhone(rs.getString("member_phone"));
				}
			} catch (SQLException e) {
				System.out.println("[에러]serchEmailMember 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return member;
		}

		//비밀번호 변경 전 정보 조회
			public MemberDTO serchPasswdMember(String email, String name, String phone) {
				Connection con=null;
				PreparedStatement pstmt=null;
				ResultSet rs=null;
				MemberDTO member=null;
				
				try {
					con=getConnection();
						
					String sql="select * from member where member_email=? AND member_name=? AND member_phone=?";
					pstmt=con.prepareStatement(sql);						
					pstmt.setString(1, email);
					pstmt.setString(2, name);
					pstmt.setString(3, phone);
					
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						member=new MemberDTO();
						member.setMemberPassword(rs.getString("member_password"));
						member.setMemberEmail(rs.getString("member_email"));
						member.setMemberName(rs.getString("member_name"));
						member.setMemberPhone(rs.getString("member_phone"));
					}
					} catch (SQLException e) {
						System.out.println("[에러]serchPasswdMember 메소드의 SQL 오류 = "+e.getMessage());
					} finally {
						close(con, pstmt, rs);
					}
					return member;
				}
}