<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
</head>
<body>
	<h1>게시판 글쓰기</h1>

	<form id="writeForm" action="bs?action=write" method="post">
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" required></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea rows="10" cols="50" name="content"></textarea></td>
			</tr>
		</table>
		<input type="submit" value="저장">
	</form>
	<a href="bs?action=boardList">목록보기</a>
</body>
</html>