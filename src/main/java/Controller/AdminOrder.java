package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import DAO.OrderDAO;
import DAO.UserDAO;
import Model.Order;
import Model.User;
import Utils.BCrypt;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/admin/orders")
public class AdminOrder extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminOrder() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LocalDate date = LocalDate.now();
		
		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		List<Order> totalOrder = OrderDAO.getAll();
		List<Order> result = OrderDAO.getOrderByOffset(totalOrder, page);
		List<Order> totalNewOrder = OrderDAO.getOrdersByDateCurrent();
		double revenueOfMonth = OrderDAO.revenueOfMonth(date.getMonthValue(), date.getYear());
		double revenueOfQuarter = OrderDAO.revenueOfQuarter(((date.getMonthValue()-1)/3)+1, date.getYear());
		
		request.setAttribute("totalOrder", totalOrder);
		request.setAttribute("result", result);
		request.setAttribute("totalNewOrder", totalNewOrder);
		request.setAttribute("revenueOfMonth", revenueOfMonth);
		request.setAttribute("revenueOfQuarter", revenueOfQuarter);
		request.getRequestDispatcher("/pages/admin_order.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
