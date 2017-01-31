<%@page import="sebank.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<c:set var="maxPage" value="${ empty maxPage ? '1' : maxPage }" />
<c:set var="pageNum" value="${ empty param.pagen ? '1' : param.pagen }" />
<c:set var="counts" value="${ empty count ? '10' : count }" />
<fmt:parseNumber var="mp" value="${ maxPage }" />
<fmt:parseNumber var="pg" value="${ pageNum }" />
<fmt:parseNumber var="ct" value="${ counts }" />



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

.table6_1 {
	width: 100%;
}

.table6_1 table {
	width: 100%;
	margin: 15px 0;
	border: 0;
}

.table6_1 th {
	background-color: #93DAFF;
	color: #000000
}

.table6_1, .table6_1 th, .table6_1 td {
	font-size: 0.95em;
	text-align: center;
	padding: 4px;
	border-collapse: collapse;
}

.table6_1 th, .table6_1 td {
	border: 1px solid #6fcdfe;
	border-width: 1px 0 1px 0
}

.table6_1 tr {
	border: 1px solid #ffffff;
}

.table6_1 tr:nth-child(odd) {
	background-color: #dbf2fe;
}

.table6_1 tr:nth-child(even) {
	background-color: #ffffff;
}

a {
	text-decoration: none;
}

a:HOVER {
	text-decoration: underline;
}

.whole {
	width: 50%;
	height: 60%;
	margin: 40px auto;
}

html, body {
	width: 100%;
	height: 100%;
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
		<table border="1" class="table6_1">
			<tr class="heads">
				<th>No.</th>
				<th width=60%>Title</th>
				<th width=100>ID</th>
				<th>Date</th>
				<th align="right"><a href="bs?action=byHits">Hits</a></th>
			</tr>
			<c:choose>
				<c:when test="${ empty boardList }">
					<tr>
						<td colspan=5>글이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="board" items="${ boardList }">
						<tr>
							<td>${ board.boardnum }</td>
							<td><a href="bs?action=read&num=${ board.boardnum }"><c:out
										value="${ board.title }"></c:out></a></td>
							<td>${ board.id }</td>
							<td>${ board.inputdate }</td>
							<td align="right">${ board.hits }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>

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

			<c:choose>
				<c:when test="${ pg==1 && mp!=1}">
					<a href="bs?action=boardList&pagen=${ pg+1 }">다음페이지</a>
				</c:when>
				<c:when test="${ pg!=1 && mp!=pg }">
					<a href="bs?action=boardList&pagen=${ pg-1 }">이전페이지</a>
					<a href="bs?action=boardList&pagen=${ pg+1 }">다음페이지</a>
				</c:when>
				<c:otherwise>
					<a href="bs?action=boardList&pagen=${ pg-1 }">이전페이지</a>
				</c:otherwise>
			</c:choose>
			<div class="navi2">
				<a href="bs?action=boardList&pagen=1">첫페이지/</a>
				<c:set var="max" value="${ (pg+2> mp) ? mp : (pg +2) }" />
				<c:set var="min" value="${ (pg - 2 <= 0) ? 1 : (pg - 2) }" />
				<c:forEach var="i" begin="${ min }" end="${ max }" step="1">
					<c:if test="${ i eq pg }">
						<span class="pgNow" id="pgNow">${ pg }</span>
					</c:if>
					<c:if test="${ i ne pg }">
						<a href="bs?action=boardList&pagen=${ i }">${ i } </a>
					</c:if>
				</c:forEach>
				<a href="bs?action=boardList&pagen=${ mp }">/마지막페이지</a>
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