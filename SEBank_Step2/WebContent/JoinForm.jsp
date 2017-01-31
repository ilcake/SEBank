<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 JSP</title>
<script type="text/javascript" src="join.js"></script>
</head>
<body>


	<div class="all">
		<h1>[회원가입]</h1>
		<div class="ffom">
			<form id="joinForm" action="cs?action=join" method="post"
				onsubmit="return formCheck()">
				<table class="joinTable">
					<tr>
						<td><label class="lb">고객 ID</label></td>
						<td><input class="ip" type="text" id="custid" name="custid"
							placeholder="ID 3~10자로 입력"></td>
						<td><input type="button" value="중복체크"
							onClick="idCheckOpen();"></td>

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
							placeholder="이름입력"></td>
					</tr>
					<tr>
						<td><label class="lb">E-mail</label></td>
						<td><input class="ip" type="text" id="email" name="email"
							placeholder="이메일입력"></td>
					</tr>
					<tr>
						<td><label class="lb">회원구분</label></td>
						<td><input class="ip" type="radio" name="division"
							value="personal" checked><label>개인</label><input
							class="ip" type="radio" name="division" value="company"><label>기업</label></td>
					</tr>
					<tr>
						<td><label class="lb">식별번호</label></td>
						<td><input class="ip" type="text" id="idno" name="idno"
							placeholder="개인 : 주민번호 / 법인 : 사업자 번호"></td>
					</tr>
					<tr>
						<td><label class="lb">주소</label></td>
						<td><input class="ip" type="text" id="address" name="address"
							placeholder="주소를 입력해 주십시오"></td>
					</tr>
					<tr>
						<th colspan="2"><input type="submit" value="가입"><input
							type="reset" value="다시쓰기"></th>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>