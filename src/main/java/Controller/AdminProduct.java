package Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Blob;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;

import DAO.CategoryDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import Model.Category;
import Model.Product;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/admin/products")
@MultipartConfig
public class AdminProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminProduct() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LocalDate date = LocalDate.now();

		int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		List<Product> totalProduct = ProductDAO.getAllProduct();
		List<Product> result = ProductDAO.getProductByOffset(totalProduct, page);
		List<Category> categories = CategoryDAO.getAllCategory();
		double revenueOfMonth = OrderDAO.revenueOfMonth(date.getMonthValue(), date.getYear());
		double revenueOfQuarter = OrderDAO.revenueOfQuarter(((date.getMonthValue() - 1) / 3) + 1, date.getYear());
		Product productBestSale = ProductDAO.getBestSale(1).get(0);

		request.setAttribute("page", request.getParameter("page") == null ? 1 : page);
		request.setAttribute("totalProduct", totalProduct);
		request.setAttribute("result", result);
		request.setAttribute("categories", categories);
		request.setAttribute("revenueOfMonth", revenueOfMonth);
		request.setAttribute("revenueOfQuarter", revenueOfQuarter);
		request.setAttribute("productBestSale", productBestSale);
		request.getRequestDispatcher("/pages/admin_product.jsp?page=" + URLEncoder.encode("1", "UTF-8"))
				.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String categoryNameInput = request.getParameter("categoryNameInput");

		String action = request.getParameter("action");
		String status = null;
		if ("delete_category".equals(action)) {
			int category_id = Integer.parseInt(request.getParameter("delete_category_input"));
			boolean result = CategoryDAO.delete(category_id);
			if (result)
				status = "delete_success";
			else
				status = "delete_failed";
			request.setAttribute("status", status);
			doGet(request, response);
			return;

		} else if ("insert_category".equals(action)) {
			String name_category = request.getParameter("categoryNameInput");
			boolean result = CategoryDAO.insert(name_category);
			if (result)
				status = "insert_success_category";
			else
				status = "insert_failed_category";
			request.setAttribute("status", status);
			doGet(request, response);
			return;
		} else if ("add_product".equals(action)) {
			System.out.println("admin_product: " + request.getParameter("price"));
			String productName = request.getParameter("productName");
			int categoryId = Integer.parseInt(request.getParameter("category"));
			float price = Float.parseFloat(request.getParameter("price"));
			float percentSale = Float.parseFloat(request.getParameter("percentPrice"));
			Part image = request.getPart("image");
			String description = request.getParameter("description");
			Product product = null;
			try {
				product = new Product(productName, categoryId, description, price, percentSale,
						new SerialBlob(image.getInputStream().readAllBytes()));
			} catch (SQLException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			boolean result = ProductDAO.insert(product);
			if (result)
				status = "insert_success_product";
			else
				status = "insert_failed_product";
			request.setAttribute("status", status);
			doGet(request, response);
			return;
		} else if ("edit_product".equals(action)) {
			int product_id = Integer.parseInt(request.getParameter("product_id"));
			Product product = ProductDAO.getById(product_id);
			String productName = request.getParameter("productName");
			int categoryId = Integer.parseInt(request.getParameter("category"));
			float price = Float.parseFloat(request.getParameter("price"));
			float percentSale = Float.parseFloat(request.getParameter("percentPrice"));
			Part image = request.getPart("image");

			Blob blob = product.getImage();
			if (image.getSize() > 0) {
				try {
					blob = new SerialBlob(image.getInputStream().readAllBytes());
				} catch (SQLException | IOException e) {
					e.printStackTrace();
				}
			}
			String description = request.getParameter("description");

			product.setName(productName);
			product.setCategoryId(categoryId);
			product.setPrice(price);
			product.setPercentSale(percentSale);
			product.setImage(blob);
			product.setDes(description);

			boolean result = ProductDAO.update(product);
			if (result)
				status = "update_product_success";
			else
				status = "update_product_failed";
			request.setAttribute("status", status);
			doGet(request, response);
			return;
		} else if ("delete_product".equals(action)) {
			int product_id = Integer.parseInt(request.getParameter("delete_category_input"));
			boolean result = ProductDAO.delete(product_id);
			if (result)
				status = "delete_success";
			else
				status = "delete_failed";
			request.setAttribute("status", status);
			doGet(request, response);
			return;
//			result ? 

		}

	}

}
