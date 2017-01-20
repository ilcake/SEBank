package sebank.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sebank.dao.CustomerDAO;
import sebank.vo.Customer;

/**
 * Servlet implementation class CustomerServlet
 */
@WebServlet("/cs")
public class CustomerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CustomerDAO dao = new CustomerDAO();
		Customer c = null;
		String custid = "";
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");

		if (action == null) {
			return;
		}

		switch (action) {

		case "joinForm":
			RequestDispatcher dispatcher = request.getRequestDispatcher("JoinForm.jsp");
			dispatcher.forward(request, response);
			break;

		case "idCheck":
			// 전달받은 ID로 DB를 검색하여 결과를 받음.
			custid = request.getParameter("id");
			c = dao.selectCustomer(custid);
			// 검색 결과를 request에 저장
			request.setAttribute("Customer", c);
			request.setAttribute("id", custid);

			// idCheck.jsp로 되돌아감. (request 유지)
			request.getRequestDispatcher("idCheck.jsp").forward(request, response);
			break;

		case "join":
			// 전달받은 파라미터 모두 읽기.
			custid = request.getParameter("custid");
			String password = request.getParameter("password1");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String division = request.getParameter("division");
			String idno = request.getParameter("idno");
			String address = request.getParameter("address");

			c = new Customer(custid, password, name, email, division, idno, address);
			int result = dao.insertCustomer(c);

			if (result > 0) {
				out.println("<script>");
				out.println("alert('회원가입 성공!');");
				out.println("location.href='index.jsp';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('회원가입 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}

			break;

		case "loginForm":
			dispatcher = request.getRequestDispatcher("loginForm.jsp");
			dispatcher.forward(request, response);

			break;

		case "login":
			String id = request.getParameter("custid");
			String pw = request.getParameter("password");

			c = dao.selectCustomer(id);

			if (c != null && c.getPassword().equals(pw)) {

				HttpSession session = request.getSession();
				session.setAttribute("loginId", id);
				session.setAttribute("loginName", c.getName());

				out.println("<script>");
				out.println("alert('로그인 성공!');");
				out.println("location.href='index.jsp';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('로그인 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
			break;

		case "logout":
			request.getSession().invalidate();
			out.println("<script>");
			out.println("location.href='index.jsp';");
			out.println("</script>");
			break;

		case "updateForm":
			String loginId = (String) request.getSession().getAttribute("loginId");
			request.getSession().invalidate();
			c = dao.selectCustomer(loginId);
			request.setAttribute("Customer", c);
			dispatcher = request.getRequestDispatcher("updateForm.jsp");
			dispatcher.forward(request, response);
			break;

		case "update":
			custid = request.getParameter("custid");
			password = request.getParameter("password1");
			name = request.getParameter("name");
			email = request.getParameter("email");
			division = request.getParameter("division");
			idno = request.getParameter("idno");
			address = request.getParameter("address");

			c = new Customer(custid, password, name, email, division, idno, address);

			result = dao.updateCustomer(c);

			if (result > 0) {

				HttpSession session = request.getSession();
				session.setAttribute("loginName", c.getName());

				out.println("<script>");
				out.println("alert('수정 성공!');");
				out.println("location.href='index.jsp';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
			break;

		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
