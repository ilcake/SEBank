<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<style type="text/css">
#panel, #flip {
	padding: 5px;
	background-color: #93DAFF;
	border: solid 1px #c3c3c3;
}

#panel {
	padding: 20px;
	display: none;
	background-color: #93DAFF;
	color: #000000;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
	function outform() {
		window.open('outForm.jsp', '회원탈퇴', 'width=500,height=300');
	}

	$.fn.extend({
		animateCss : function(animationName) {
			var animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend';
			this.addClass('animated ' + animationName).one(animationEnd, function() {
				$(this).removeClass('animated ' + animationName);
			});
		}
	});

	/* $('#panel').addClass('animated bounceInUp'); */
	var isOpen = false;
	$(document).ready(function() {
		$("#flip").click(function() {
			$('#panel').animateCss('bounceInUp');
			if (!isOpen) {
				$("#panel").slideDown("slow");
				isOpen = true;
			} else {
				$("#panel").slideUp("slow");
				isOpen = false;
			}
		});$("#panel").click(function() {
			if (!isOpen) {
				$("#panel").slideDown("slow");
				isOpen = true;
			} else {
				$("#panel").slideUp("slow");
				isOpen = false;
			}
		});
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>SEBank_Step2</title>
</head>
<body>
	<div id="flip">SEBank_Step2</div>
	<div class="inc" id="panel">

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
		/ <a href="cal.jsp">달력보기</a> / <a href="googleMap.html">지도 보기</a>

	</div>
</body>
</html>