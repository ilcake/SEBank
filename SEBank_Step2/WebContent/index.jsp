<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SEBank_Step2</title>
</head>
<body>
	<h1>SEBank_Step2</h1>
	<ol>
		<%
			String user = (String) session.getAttribute("loginName");
			if (user == null) {
		%>
		<li><a href="cs?action=joinForm">회원가입</a>
		<li><a href="cs?action=loginForm">로그인</a> <%
 	} else {
 %>
			<h4><%=user%>
				- 회원님 접속중
			</h4>
		<li><a href="cs?action=logout">로그아웃</a>
		<li><a href="cs?action=updateForm">개인정보 수정</a>
		<li><a href="bs?action=boardList">게시판</a> <%
 	}
 %>
	</ol>

</body>
</html>