package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import reservation.ReservMgr;

@WebServlet("/listDel.bo")
public class AjaxDelListM extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		int serv_num = Integer.parseInt(request.getParameter("serv_num"));
		boolean result = false;
		
		if(!new ReservMgr().checkReserv(serv_num)) {
			result = new ServiceMgr().deleteServiceBoard(serv_num);
		}
		
		response.getWriter().print(result);
		
	}

}
