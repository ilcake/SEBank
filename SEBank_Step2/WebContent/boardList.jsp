<%@page import="sebank.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String maxPage = (String) session.getAttribute("maxPage");
	int mPage = 0;
	if (maxPage != null) {
		mPage = Integer.parseInt(maxPage);
	}
	int pagen = 1;
	String pageNum = (String) request.getParameter("pagen");
	if (pageNum != null) {
		pagen = Integer.parseInt(pageNum);
	}
	String counts = (String) session.getAttribute("count");
	int count = 10;
	if (counts != null) {
		count = Integer.parseInt(counts);
	}

	ArrayList<Board> list = (ArrayList<Board>) session.getAttribute("boardList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
<style>
.heads {
	background-color: #e6e6ff;
}

.pgNow {
	font-size: 20px;
	color: red;
}
</style>
<script>
	function selected() {
		var select = document.getElementById("count");
		var option_value = select.options[select.selectedIndex].value;
		location.href = 'bs?action=boardList&pagen=1&count=' + option_value;
	}
	function selectBycount(count) {
		var select = document.getElementById("count");
		var num = -1;
		num = count = 5 ? 0 : count = 10 ? 1 : count = 15 ? 2 : -1;
		select.selectedIndex = num;
	}
</script>
</head>
<body>
	<%@ include file="index.jsp"%>
	<h1>BOARD</h1>

	<div class="whole">
		<table border="1">
			<tr class="heads">
				<th>No.</th>
				<th width=400>Title</th>
				<th width=100>ID</th>
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
				<td><a href="bs?action=read&num=<%=num%>"><%=title%></a></td>
				<td><%=id%></td>
				<td><%=date%></td>
				<td align="right"><%=hits%></td>
			</tr>
			<%
				}
				}
			%>
		</table>
		<form action="bs" method="post">
			<input type="hidden" name="action" value="search"><select
				name="stype">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="title+content">제목+내용</option>
				<option value="writer">글쓴이</option>
			</select><input type="text" name="que"><input type="submit" value="검색">
		</form>
		<div class="navi">
			<%
				if (pagen == 1 && mPage == 1) {

				} else if (pagen == 1) {
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
			<div class="navi2">

				<a href="bs?action=boardList&pagen=1">첫페이지/</a>
				<%
					int max = pagen + 2 > mPage ? mPage : pagen + 2;
					for (int i = pagen - 2 <= 0 ? 1 : pagen - 2; i <= max; i++) {
						if (i == pagen) {
				%>
				<span class="pgNow" id="pgNow"><%=i%></span>
				<%
					} else {
				%>
				<a href="bs?action=boardList&pagen=<%=i%>"><%=i%> </a>
				<%
					}
					}
				%>
				<a href="bs?action=boardList&pagen=<%=mPage%>">/마지막페이지</a>
			</div>

			<div>
				<select name="count" id="count" onchange="selected();">
					<option value="0">----</option>
					<option value="5">5개</option>
					<option value="10">10개</option>
					<option value="15">15개</option>
				</select>
			</div>
		</div>
		<a href="bs?action=writeForm">글쓰기</a>
	</div>
</body>
</html>