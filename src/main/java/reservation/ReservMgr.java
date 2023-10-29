package reservation;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import db.DBConnectionMgr;
import service.ServiceBean;
import service.UtilMgr;

public class ReservMgr {
	private DBConnectionMgr pool;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public ReservMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	public ReservBean getReservation(int reserv_num) {
		ReservBean bean = new ReservBean();
		try {
			con = pool.getConnection();
			sql = "select * from reservation where reserv_num = " + reserv_num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setReserv_num(rs.getInt(1));
				bean.setServ_num(rs.getInt(2));
				bean.setServ_date(rs.getString(3));
				bean.setReserv_date(rs.getString(4));
				bean.setReserv_price(rs.getInt(5));
				bean.setId(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	public ArrayList<ReservBean> getReservationList(int start, int end, String id) {
		ArrayList<ReservBean> alist = new ArrayList<ReservBean>();
		
		try {
			con = pool.getConnection();
			if(id.equals("admin")) {
				sql = "select BT2.* from(select rownum R1, BT1.* from(select * from reservation order by reserv_num desc)BT1)BT2 where R1 >= ? and R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReservBean bean = new ReservBean();
					bean.setReserv_num(rs.getInt("reserv_num"));
					bean.setServ_num(rs.getInt("serv_num"));
					bean.setServ_date(rs.getString("serv_date"));
					bean.setReserv_date(rs.getString("reserv_date"));
					bean.setReserv_price(rs.getInt("reserv_price"));
					bean.setId(rs.getString("id"));
					alist.add(bean);
				}
				
			}else {
				sql = "select BT2.* from(select rownum R1, BT1.* from(select * from reservation where id=? order by reserv_num desc)BT1)BT2 where R1 >= ? and R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ReservBean bean = new ReservBean();
					bean.setReserv_num(rs.getInt("reserv_num"));
					bean.setServ_num(rs.getInt("serv_num"));
					bean.setServ_date(rs.getString("serv_date"));
					bean.setReserv_date(rs.getString("reserv_date"));
					bean.setReserv_price(rs.getInt("reserv_price"));
					alist.add(bean);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	
	public void insertReserList(HttpServletRequest req) {			//서블릿 파일에서 request부분 복붙, 변수명은 맘대로
		
		try {
			con = pool.getConnection();
			sql = "insert into reservation values(SEQ_RESVNUM.NEXTVAL, ?, ?, SYSDATE, ?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(req.getParameter("serv_num")));
			pstmt.setString(2, req.getParameter("serv_date"));
			pstmt.setInt(3, Integer.parseInt(req.getParameter("reserv_price")));
			pstmt.setString(4, req.getParameter("id"));
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public int getTotalCount(String id) {
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(id.equals("admin")) {
				sql = "select count(reserv_num) from reservation";
				pstmt = con.prepareStatement(sql);
			}else {
				sql = "select count(reserv_num) from reservation where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	
	public boolean deleteReservertion(int reserv_num) {
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from reservation where reserv_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reserv_num);
			pstmt.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}	
	
	public boolean calcReservDay(String dd) {
		boolean flag = false;
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date sDay;
			sDay = sdf.parse(dd);
			flag = sDay.after(date);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return flag;
	}
	
	public boolean checkReserv(int serv_num) {
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "select * from reservation where serv_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, serv_num);
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
