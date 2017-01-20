<%@page import="sebank.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	Board b = (Board) session.getAttribute("read");
	String id = b.getId();
	String title = b.getTitle();
	String content = b.getContent();
	String date = b.getInputdate();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시물 수정</title>
<script type="text/javascript">
	function formCheck() {
		var tt = document.getElementsByName("title")[0];
		var cc = document.getElementsByName("content")[0];
		if (tt.value.length < 1 || cc.value.length < 1) {
			alert('제목, 내용을 입력하셔야 합니다.');
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h1>게시글 수정</h1>

	<form id="updateForm" action="bs?action=update" method="post"
		onsubmit="return formCheck()">
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" value='<%=title%>'></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="50" name="content"><%=content%></textarea></td>
			</tr>
		</table>
		<input type="submit" value="수정하기">
	</form>
	<a href="bs?action=boardList">목록보기</a>
</body>
</html>