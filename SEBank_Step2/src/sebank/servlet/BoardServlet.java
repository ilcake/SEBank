package sebank.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import sebank.dao.BoardDAO;
import sebank.vo.Board;
import sebank.vo.Reply;

/**
 * Servlet implementation class BoardServlet
 */
@WebServlet("/bs")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	// good

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");
		BoardDAO dao;
		HttpSession session = null;

		if (action == null) {
			return;
		}

		switch (action) {

		case "boardList":
			int pagen = 1;
			int count = 10;
			String counts = request.getParameter("count");
			if (counts != null) {
				count = Integer.parseInt(counts);
				request.getSession().setAttribute("count", count + "");
			}
			String wh = (String) request.getSession().getAttribute("count");
			if (wh != null)
				count = Integer.parseInt(wh);

			dao = new BoardDAO();
			int maxNum = ((dao.getFullCount() - 1) / count) + 1;
			request.getSession().setAttribute("maxPage", maxNum + "");

			String whatNow = request.getParameter("pagen");
			if (whatNow != null)
				pagen = Integer.parseInt(whatNow);

			int start = ((pagen - 1) * count) + 1;
			int end = ((pagen - 1) * count) + count;
			ArrayList<Board> list = dao.list(start, end);
			session = request.getSession();
			session.setAttribute("boardList", list);

			request.getRequestDispatcher("boardList.jsp").forward(request, response);
			break;

		case "writeForm":
			request.getRequestDispatcher("writeForm.jsp").forward(request, response);
			break;

		case "write":
			session = request.getSession();
			String wrid = (String) session.getAttribute("loginId");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Board b = new Board(0, wrid, title, content, null, 0);
			int result = new BoardDAO().write(b);

			if (result < 0) {
				out.println("<script>");
				out.println("alert('글쓰기 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('작성되었습니다');");
				out.println("location.href='bs?action=boardList';");
				out.println("</script>");
			}
			break;

		case "read":
			String num = (String) request.getParameter("num");
			dao = new BoardDAO();
			b = dao.read(Integer.parseInt(num));
			ArrayList<Reply> rList = dao.replyList(Integer.parseInt(num));
			if (b == null)
				return;
			request.getSession().setAttribute("read", b);
			request.getSession().setAttribute("reply", rList);
			request.getRequestDispatcher("read.jsp").forward(request, response);
			break;

		case "delete":
			dao = new BoardDAO();
			num = (String) request.getParameter("num");
			result = dao.delete(Integer.parseInt(num), (String) request.getSession().getAttribute("loginId"));
			if (result > 0) {
				out.println("<script>");
				out.println("alert('게시글이 삭제되었습니다.');");
				out.println("location.href='bs?action=boardList';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('삭제 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
			break;

		case "updateForm":
			request.getRequestDispatcher("boardUpdateForm.jsp").forward(request, response);
			break;

		case "update":
			dao = new BoardDAO();
			b = (Board) request.getSession().getAttribute("read");
			b.setTitle(request.getParameter("title"));
			b.setContent(request.getParameter("content"));
			result = dao.update(b);
			out.println("location.href='bs?action=read&num=" + b.getBoardnum() + "';");
			if (result > 0) {
				out.println("<script>");
				out.println("alert('게시글이 수정되었습니다.');");
				out.println("location.href='bs?action=boardList';");
				out.println("</script>");
			} else {
				out.println("<script>");
				out.println("alert('수정 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
			break;

		case "replyInsert":
			int boardnum = Integer.parseInt(request.getParameter("boardnum"));
			String text = (String) request.getParameter("text");
			String id = (String) request.getSession().getAttribute("loginId");
			dao = new BoardDAO();
			dao.replyInsert(new Reply(0, boardnum, id, text, null));

			response.sendRedirect("bs?action=read&num=" + boardnum);

			break;
		case "replyUpdate":
			String rtext = (String) request.getParameter("text");
			String rnums = request.getParameter("rnum");
			b = (Board) request.getSession().getAttribute("read");
			int rnum = -1;
			if (rnums != null)
				rnum = Integer.parseInt(rnums);
			System.out.println(rnum);
			System.out.println(rtext);
			dao = new BoardDAO();
			result = dao.replyUpdate(rnum, rtext);
			if (result > 0) {
				response.sendRedirect("bs?action=read&num=" + b.getBoardnum());
			} else {
				out.println("<script>");
				out.println("alert('수정 실패!');");
				out.println("history.go(-1);");
				out.println("</script>");
			}
			break;

		case "replyDelete":
			dao = new BoardDAO();
			b = (Board) request.getSession().getAttribute("read");
			result = dao.replyDelete(Integer.parseInt(request.getParameter("rnum")),
					(String) request.getSession().getAttribute("loginId"));
			if (result > 0) {
				response.sendRedirect("bs?action=read&num=" + b.getBoardnum());
			} else {
				out.println("<script>");
				out.println("alert('삭제 실패!');");
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
