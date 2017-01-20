<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>[ 로그인 ]</h1>

	<form id="loginForm" action="cs?action=login" method="post">

		<table>
			<tr>
				<td>고객 ID</td>
				<td><input type="text" id="id" name="custid" required></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="password" name="password"
					required></td>
			</tr>
			<tr>
				<td><input type="submit" value="로그인"></td>
			</tr>
		</table>

	</form>

</body>
</html>