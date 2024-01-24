package Controller;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Hiển thị trang Forgot Password khi có yêu cầu GET
		req.getRequestDispatcher("/pages/forgotPassword.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Lấy giá trị email từ form
		String email = request.getParameter("email");
		RequestDispatcher dispatcher = null;
		int otpvalue = 0;
		HttpSession mySession = request.getSession();

		if (email != null && !email.equals("")) {
			// Tạo và gửi OTP
			Random rand = new Random();
			otpvalue = rand.nextInt(1255650);

			String to = email;
			// Thiết lập các thuộc tính của mail server
			Properties props = new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");

			// Khởi tạo session
			Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					// Thay đổi email và mật khẩu tương ứng với tài khoản Gmail của bạn
					return new PasswordAuthentication("21124548@st.hcmuaf.edu.vn", "txah sgxn npko rile");
				}
			});

			// Tạo và gửi email
			try {
				MimeMessage message = new MimeMessage(session);
				message.setFrom(new InternetAddress("21124548@st.hcmuaf.edu.vn"));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
				message.setSubject("Hello");
				message.setText("Your OTP is: " + otpvalue);

				// Gửi email
				Transport.send(message);
				System.out.println("message sent successfully");
			} catch (MessagingException e) {
				throw new RuntimeException(e);
			}

			// Chuyển hướng sang trang nhập OTP
			dispatcher = request.getRequestDispatcher("/pages/EnterOtp.jsp");
			request.setAttribute("message", "OTP is sent to your email id");
			mySession.setAttribute("otp", otpvalue);
			mySession.setAttribute("email", email);
			dispatcher.forward(request, response);
		}
	}
}
