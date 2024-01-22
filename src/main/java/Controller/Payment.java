package Controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Map;

import DAO.AddressDAO;
import DAO.CartDAO;
import DAO.CouponDAO;
import DAO.OrderDAO;
import DAO.PaymentDAO;
import Model.Address;
import Model.Coupon;
import Model.Order;
import Model.Product;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PaymentDAO
 */
@WebServlet("/payment")
public class Payment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Payment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int userId = ((User) request.getSession().getAttribute("user")).getId();
		
		String province = request.getParameter("p_province");
		String district = request.getParameter("d_district");
		String ward = request.getParameter("w_ward");
		String addressDetail = request.getParameter("c_address");
		
		String payment = request.getParameter("payment");
		
		String phone = request.getParameter("c_phone");
		String email = request.getParameter("c_email_address");
		String firstName = request.getParameter("c_fname");
		String lastName = request.getParameter("c_lname");
		
		String notes = request.getParameter("c_order_notes");
		
		User receiver = new User();
		receiver.setPhone(phone);
		receiver.setEmail(email);
		receiver.setFirstName(firstName);
		receiver.setLastName(lastName);
		
		String coupon = request.getParameter("coupon");
		
		Map<Product, Integer> orderProductList = CartDAO.getSelectedProductList(userId);
		
		
		Address address = new Address(province, district, ward, addressDetail);
		Coupon cp  = CouponDAO.getById(coupon);
		
		Order order = new Order();
		order.setOrderAddress(address);
		order.setOrderDate(Date.valueOf(LocalDate.now()));
		order.setCoupon(cp);
		order.setPayment(PaymentDAO.getById(Integer.valueOf(payment)));
		order.setProductAndQuantityList(orderProductList);
		order.setSender((User) request.getSession().getAttribute("user"));
		order.setReceiver(receiver);
		order.setNotes(notes);
		
		
		Model.Cart cart = (Model.Cart) request.getSession().getAttribute("cart");
		OrderDAO.addOrder(order, userId);
		
		cart = CartDAO.getByUserId(userId);
		request.getSession().setAttribute("cart", cart);
		
		
		
		request.getRequestDispatcher("/pages/thankyou.jsp").forward(request, response);;
	}

}
