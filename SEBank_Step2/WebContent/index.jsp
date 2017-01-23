<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.inc {
	padding: 10px;
	background-color: red;
	color: white;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SEBank_Step2</title>
</head>
<body>
	<div class="inc">
		<h2>SEBank_Step2</h2>

		<%
			String user = (String) session.getAttribute("loginName");
			if (user == null) {
		%>
		<a href="cs?action=joinForm">회원가입</a> / <a href="cs?action=loginForm">로그인</a>
		<%
			} else {
		%>
		<h4><%=user%>
			- 회원님 접속중
		</h4>
		<a href="cs?action=logout">로그아웃</a> / <a href="cs?action=updateForm">개인정보수정</a>
		/ <a href="bs?action=boardList">게시판</a>
		<%
			}
		%>
	</div>
</body>
</html>