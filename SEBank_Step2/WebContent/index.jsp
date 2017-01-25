<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<style type="text/css">
.inc {
	padding: 10px;
	background-color: #93DAFF;
	color: #000000;
}
</style>
<script type="text/javascript">
	function outform() {
		window.open('outForm.jsp', '회원탈퇴', 'width=500,height=300');
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SEBank_Step2</title>
</head>
<body>
	<div class="inc">
		<h2>SEBank_Step2</h2>

		<c:choose>
			<c:when test="${ empty loginId }">
				<a href="cs?action=joinForm">회원가입</a> / 
				<a href="cs?action=loginForm">로그인</a>
			</c:when>
			<c:otherwise>
				<h4>${ loginName }-회원님접속중</h4>
				<a href="cs?action=logout">로그아웃</a> / 
				<a href="cs?action=updateForm">개인정보수정</a>/ 
				<a href="bs?action=boardList">게시판</a> / 
				<a href="" onclick="outform();">회원탈퇴</a>
			</c:otherwise>
		</c:choose>
		/ <a href="cal.jsp">달력보기</a>

	</div>
</body>
</html>