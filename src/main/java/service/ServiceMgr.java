package service;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import service.ServiceBean;
import db.DBConnectionMgr;

public class ServiceMgr {
	private DBConnectionMgr pool;
	private static final String SAVEFOLDER = "C:\\webclass\\git\\semiPJ\\src\\main\\webapp\\serFicUpload";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 5*1024*1024*1024;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public ServiceMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	
	public int getTotalCount(String keyField, String keyWord) {
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(serv_num) from service";
				pstmt = con.prepareStatement(sql);
			} else {
				sql = "select count(serv_num) from service where "+ keyField + " like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,  "%"+ keyWord + "%");
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
	
	
	public int getTotalCountCate(String cateKey) {
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(serv_num) from service where serv_category like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  "%"+ cateKey + "%");
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
	
	
	public ArrayList<ServiceBean> getServiceList(String keyField, String keyWord, int start, int end) {
		ArrayList<ServiceBean> alist = new ArrayList<ServiceBean>();
		
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select BT2.* from(select rownum R1, BT1.* from(select * from service order by serv_num desc)BT1)BT2 where R1 >= ? and R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select BT2.* from(select rownum R1, BT1.* from(select * from service order by serv_num desc)BT1 where "+ keyField + " like ?)BT2 where R1 >= ? and R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord +"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ServiceBean bean = new ServiceBean();
				bean.setServ_num(rs.getInt("serv_num"));
				bean.setServ_name(rs.getString("serv_name"));
				bean.setServ_category(rs.getString("serv_category"));
				bean.setRegion(rs.getString("region"));
				bean.setServ_corp(rs.getString("serv_corp"));
				bean.setPrice(rs.getInt("price"));
				bean.setServ_detail(rs.getString("serv_detail"));
				bean.setFilename(rs.getString("filename"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	public ArrayList<ServiceBean> getServiceListCate(String keyField, String keyWord, String cateKey, int start, int end) {
		ArrayList<ServiceBean> alist = new ArrayList<ServiceBean>();
		
		try {
			con = pool.getConnection();
			if((keyWord.equals("null") || keyWord.equals("")) && (cateKey.equals("null") || cateKey.equals(""))) {
				sql = "select BT2.* from(select rownum R1, BT1.* from(select * from service order by serv_num desc)BT1)BT2 where R1 >= ? and R1 <= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				if(!(keyWord.equals("null") || keyWord.equals(""))) {
					sql = "select BT2.* from(select rownum R1, BT1.* from(select * from service order by serv_num desc)BT1 where "+ keyField + " like ?)BT2 where R1 >= ? and R1 <= ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + keyWord +"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
				}else {
					sql = "select BT2.* from(select rownum R1, BT1.* from(select * from service where serv_category like ? order by serv_num desc)BT1)BT2 where R1 >= ? and R1 <= ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + cateKey +"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
				}
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ServiceBean bean = new ServiceBean();
				bean.setServ_num(rs.getInt("serv_num"));
				bean.setServ_name(rs.getString("serv_name"));
				bean.setServ_category(rs.getString("serv_category"));
				bean.setRegion(rs.getString("region"));
				bean.setServ_corp(rs.getString("serv_corp"));
				bean.setPrice(rs.getInt("price"));
				bean.setServ_detail(rs.getString("serv_detail"));
				bean.setFilename(rs.getString("filename"));
				alist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return alist;
	}
	
	
	public void insertBoard(HttpServletRequest req) {			//서블릿 파일에서 request부분 복붙, 변수명은 맘대로
		MultipartRequest multi = null;							//cos.jar파일이 있어야 import가능
		String filename = null;
		
		try {
			con = pool.getConnection();
			File file = new File(SAVEFOLDER);			//JAVA.IO를 임포트하기
			if(!file.exists()) 
				file.mkdir();				
			multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());		//받는 변수, 저장폴더, 사이즈, 타입, 디폴트적용
			if(multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
			}
			sql = "insert into service values(SEQ_SERVBOARDM.NEXTVAL, ?, ?, ?, ?, ?,?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("subject"));
			pstmt.setString(2, multi.getParameter("category"));
			pstmt.setString(3, multi.getParameter("re1") + " " + multi.getParameter("re2"));
			pstmt.setString(4, multi.getParameter("serv_corp"));
			pstmt.setInt(5, Integer.parseInt(multi.getParameter("price")));
			pstmt.setString(6, multi.getParameter("content"));
			pstmt.setString(7, filename);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public ServiceBean getService(int serv_num) {
		ServiceBean bean = new ServiceBean();
		try {
			con = pool.getConnection();
			sql = "select * from service where serv_num = " + serv_num;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setServ_num(rs.getInt(1));
				bean.setServ_name(rs.getString(2));
				bean.setServ_category(rs.getString(3));
				bean.setRegion(rs.getString(4));
				bean.setServ_corp(rs.getString(5));
				bean.setPrice(rs.getInt(6));
				bean.setServ_detail(rs.getString(7));
				bean.setFilename(rs.getString(8));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	public void updateBoard(ServiceBean upBean) {
		try {
			con = pool.getConnection();
			sql = "update service set serv_name = ?, serv_category=?, region=?, serv_corp=?, price=?, serv_detail=? where serv_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, upBean.getServ_name());
			pstmt.setString(2, upBean.getServ_category());
			pstmt.setString(3, upBean.getRegion());
			pstmt.setString(4, upBean.getServ_corp());
			pstmt.setInt(5, upBean.getPrice());
			pstmt.setString(6, upBean.getServ_detail());
			pstmt.setInt(7, upBean.getServ_num());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
	}
	
	public boolean deleteServiceBoard(int serv_num) {
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select filename from service where serv_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, serv_num);
			rs = pstmt.executeQuery();
			if(rs.next() && rs.getString(1) != null) {
				File file = new File(SAVEFOLDER + "/" + rs.getString(1));	//파일의 위치지정
				if(file.exists()) {				//file이 존재하면 
					UtilMgr.delete(SAVEFOLDER + "/" + rs.getString(1));
				}
			}
			
			sql = "delete from service where serv_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, serv_num);
			pstmt.executeUpdate();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}	
	
	
	
	
}

