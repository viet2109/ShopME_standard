package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import DAO.CouponDAO;
import Model.Coupon;

/**
 * Servlet implementation class CheckOut
 */
@WebServlet("/checkout")
public class CheckOut extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckOut() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("/pages/checkout.jsp").include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String couponCode = request.getParameter("coupon");
		if (couponCode != null) {
			Coupon coupon = CouponDAO.getById(couponCode);
			if (coupon != null) {
				request.getSession().setAttribute("coupon", coupon);
				request.setAttribute("insert_coupon", "success");
			} else {
				request.setAttribute("insert_coupon", "fail");
				request.setAttribute("coupon_code_fail", request.getParameter("coupon"));
			}
			
		}
		doGet(request, response);
	}

}
