<%@page import="sebank.vo.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 수정</title>
<script>
	function formCheck() {
		var id = document.getElementsByName("custid");
		if (id[0].value.length > 10 || id[0].value.length < 3) {
			alert('아이디는 3~10자로 입력해 주십시오.');
			return false;
		}

		var pw = document.getElementsByName("password1");
		var pw2 = document.getElementsByName("password2");
		var psw1 = pw[0].value;
		var psw2 = pw2[0].value;
		if (psw1.length > 10 || psw1.length < 3) {
			alert('비밀번호는 3~10자로 입력해 주십시오.');
			return false;
		}
		if (psw2.length > 10 || psw2.length < 3) {
			alert('비밀번호는 3~10자로 입력해 주십시오.');
			return false;
		}

		if (psw1 != psw2) {
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}

		var name = document.getElementById("name");
		if (name.value.length < 1) {
			alert('이름을 입력하여 주십시오.');
			return false;
		}

		var idno = document.getElementById("idno");
		if (idno.value.length < 1) {
			alert('식별번호를 입력하여 주십시오.');
			return false;
		}



		return true;
	}


	function idCheckOpen() {
		window.open("idCheck.jsp", "idCheckWin", "top=200, left=400, width=300, height=200");
	}
</script>
</head>
<body>
	<div class="all">
		<h1>[회원정보수정]</h1>
		<div class="ffom">
			<form id="joinForm" action="cs?action=update" method="post"
				onsubmit="return formCheck()">
				<table class="joinTable">
					<tr>
						<td><label class="lb">고객 ID</label></td>
						<td><input class="ip" type="text" id="custid" name="custid"
							value="${ Customer.custid }" readonly></td>
					</tr>
					<tr>
						<td><label class="lb">비밀번호</label></td>
						<td><input class="ip" type="password" name="password1"
							placeholder="pw 3~10자로 입력"></td>
					</tr>
					<tr>
						<td><label class="lb">비밀번호 확인</label></td>
						<td><input class="ip" type="password" name="password2"
							placeholder="pw 3~10자로 입력"></td>
					</tr>
					<tr>
						<td><label class="lb">이름</label></td>
						<td><input class="ip" type="text" id="name" name="name"
							placeholder="이름입력" value="${ Customer.name }"></td>
					</tr>
					<tr>
						<td><label class="lb">E-mail</label></td>
						<td><input class="ip" type="text" id="email" name="email"
							placeholder="이메일입력" value="${ Customer.email }"></td>
					</tr>
					<tr>
						<td><label class="lb">회원구분</label></td>
						<td><input class="ip" type="radio" name="division"
							value="personal"
							<c:if test="${ Customer.division=='personal' }">checked</c:if>
							disabled="disabled"><label>개인</label><input class="ip"
							type="radio" name="division" value="company" disabled="disabled"
							<c:if test="${ Customer.division=='company' }">checked</c:if>><label>기업</label></td>
					</tr>
					<tr>
						<td><label class="lb">식별번호</label></td>
						<td><input class="ip" type="text" id="idno" name="idno"
							value="${ Customer.idno }" readonly="readonly"></td>
					</tr>
					<tr>
						<td><label class="lb">주소</label></td>
						<td><input class="ip" type="text" id="address" name="address"
							value="${ Customer.address }"></td>
					</tr>
					<tr>
						<th colspan="2"><input type="submit" value="변경"><input
							type="reset" value="다시쓰기"></th>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>