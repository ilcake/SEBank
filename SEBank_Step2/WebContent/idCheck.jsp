<%@page import="sebank.vo.Customer"%>
<%@page import="sebank.dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ID CHECK</title>
<script>
	function isSelected(id) {
		opener.document.getElementById("custid").value = id;
		this.close();
	}

	function formCheck() {
		var id = document.getElementById("id");
		if (id.value == '') {
			alert('아이디를 입력해 주십시오');
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<form action="cs" method="post" onsubmit="return formCheck()">
		<table>
			<tr>
				<td><input type="text" id="id" name="id"
					placeholder="검색할 id를 입력해 주십시오" /></td>
			</tr>
			<tr>
				<td><input type="hidden" name="action" value="idCheck" /></td>
			</tr>
			<tr>
				<td><input type="submit" value="검색" /></td>
			</tr>
		</table>
	</form>
	<%
		if (request.getMethod().equalsIgnoreCase("GET"))
			return;

		Customer c = (Customer) request.getAttribute("customer");
		String id = (String) request.getAttribute("id");

		if (c == null) {
	%>
	${id} : 사용할 수 있는 ID 입니다.
	<input type="button" value="ID사용하기" onClick="isSelected('${id}');">
	<%
		} else {
	%>
	${id} : 이미 사용중인 ID입니다.
	<%
		}
	%>


</body>
</html>