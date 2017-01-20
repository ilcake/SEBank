<%@page import="sebank.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<style>
.heads {
	background-color: #e6e6ff;
}
</style>
</head>
<body>
	<h1>BOARD</h1>

	<%
		String maxPage = (String) session.getAttribute("maxPage");
		int mPage = 100;
		if (maxPage != null) {
			mPage = Integer.parseInt(maxPage);
			System.out.println(" boardList max  :  " + mPage);
		}
		int pagen = 1;
		String pageNum = (String) request.getParameter("pagen");
		if (pageNum != null) {
			pagen = Integer.parseInt(pageNum);
			System.out.println(" boardList now  :  " + pagen);
		}

		ArrayList<Board> list = (ArrayList<Board>) session.getAttribute("boardList");
	%>

	<div class="whole">
		<table border="1">
			<tr class="heads">
				<th>No.</th>
				<th width=100>ID</th>
				<th width=400>Title</th>
				<th>Date</th>
				<th align="right">Hits</th>
			</tr>
			<%
				if (list.size() == 0) {
			%>
			<tr>
				<td colspan=5>등록된 글이 없습니다.</td>
			</tr>
			<%
				} else {
					for (int i = 0; i < list.size(); i++) {
						Board b = list.get(i);
						int num = b.getBoardnum();
						String id = b.getId();
						String title = b.getTitle();
						String content = b.getTitle();
						String date = b.getInputdate();
						int hits = b.getHits();
			%>
			<tr>
				<td><%=num%></td>
				<td><%=id%></td>
				<td><a href="bs?action=read&num=<%=num%>"><%=title%></a></td>
				<td><%=date%></td>
				<td align="right"><%=hits%></td>
			</tr>
			<%
				}
				}
			%>
		</table>
		<div class="navi">
			<%
				if (pagen == 1) {
			%>
			<a href="bs?action=boardList&pagen=<%=(pagen + 1)%>">다음페이지</a>
			<%
				} else if (pagen == mPage) {
			%>
			<a href="bs?action=boardList&pagen=<%=(pagen - 1)%>">이전페이지</a>
			<%
				} else {
			%>
			<a href="bs?action=boardList&pagen=<%=(pagen - 1)%>">이전페이지</a> <a
				href="bs?action=boardList&pagen=<%=(pagen + 1)%>">다음페이지</a>
			<%
				}
			%>
		</div>
		<a href="bs?action=writeForm">글쓰기</a>
	</div>
</body>
</html>