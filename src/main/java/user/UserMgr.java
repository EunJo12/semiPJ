package user;

import java.sql.*;

import db.DBConnectionMgr;

public class UserMgr {
	private DBConnectionMgr pool;
	
	public UserMgr() {
		pool = DBConnectionMgr.getInstance();

	}

	public boolean checkId(String id) {
		Connection con = null;				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			String sql = "SELECT ID FROM USER_M WHERE ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public boolean insertUser(UserBean bean) {
		Connection con = null;				
		PreparedStatement pstmt = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			String sql = "insert into USER_M values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getPhone());
			pstmt.setString(7, bean.getEmail());
			pstmt.setString(8, bean.getZipcode());
			pstmt.setString(9, bean.getAddress());
			pstmt.setString(10, bean.getDetailAddr());
			
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
			

		
		return flag;
	}
	
	
	public boolean loginMember(String id, String pwd) {
		Connection con = null;				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean flag = false;
		
		try {
			con = pool.getConnection();
			String sql = "SELECT ID FROM USER_M WHERE ID=? AND PWD=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return flag;
	}
	
}
