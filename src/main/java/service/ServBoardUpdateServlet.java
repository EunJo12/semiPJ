package service;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/service/servBoardUpdate")
public class ServBoardUpdateServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String nowPage = request.getParameter("nowPage");
		
		ServiceBean upBean = new ServiceBean();
		upBean.setServ_num(Integer.parseInt(request.getParameter("serv_num")));
		upBean.setServ_corp(request.getParameter("corp"));
		upBean.setServ_name(request.getParameter("subject"));
		upBean.setServ_detail(request.getParameter("content"));
		upBean.setServ_category(request.getParameter("category"));
		upBean.setRegion(request.getParameter("region"));
		upBean.setPrice(Integer.parseInt(request.getParameter("price")));
		
		ServiceMgr sMgr = new ServiceMgr();
		sMgr.updateBoard(upBean);
		String url = "read_M.jsp?nowPage=" + nowPage + "&serv_num=" + upBean.getServ_num();
		response.sendRedirect(url);
	}

}
