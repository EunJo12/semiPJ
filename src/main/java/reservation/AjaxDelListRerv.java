package reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/reservation/delListRerv")
public class AjaxDelListRerv extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setCharacterEncoding("utf-8");
		
		int reserv_num = Integer.parseInt(request.getParameter("reserv_num"));
		boolean result = new ReservMgr().deleteReservertion(reserv_num);
		
		response.getWriter().print(result);
	}

}
