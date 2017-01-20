<%@page import="sebank.vo.Reply"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sebank.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	Board b = (Board) session.getAttribute("read");
	ArrayList<Reply> rList = (ArrayList<Reply>) session.getAttribute("reply");
%>
<title>${ b.title }</title>
<style type="text/css">
.content {
	padding: 10px;
}

.heads {
	background-color: #e6e6ff;
	padding: 5px;
}
</style>

<script>
	var text = document.getElementById('text');
	function checkReply() {
		if (text.value.length == 0) {
			alert('댓글을 입력해주세요');
			text.focus();
			text.select();
			return false;
		}
	}
	function replyUpdate(replyNum) {
		var replyForm = document.getElementById(replyNum);
		replyForm.innerHTML = "<form action='bs' method='post' onsubmit=''><input type='hidden' name='action' value='replyUpdate'><input type='hidden' name='rnum' value='" + replyNum + "'><input type='text' name='text'><input type='submit' value='확인'></form>";
	}
</script>
</head>
<body>
	<table border="1" width=700>
		<tr class="heads">
			<td width=30>No.<%=b.getBoardnum()%></td>
			<td width=500><%=b.getTitle()%></td>
			<td>작성자 : <%=b.getId()%></td>
		</tr>
		<tr>
			<td class="content" colspan=3><%=b.getContent()%></td>
		</tr>
		<%
			if (b.getId().equals(session.getAttribute("loginId"))) {
		%>

		<tr>
			<td colspan="3">
				<button
					onclick="location.href='bs?action=updateForm&num=<%=b.getBoardnum()%>'">수정</button>
				<button
					onclick="location.href='bs?action=delete&num=<%=b.getBoardnum()%>'">삭제</button>
			</td>
		</tr>
		<%
			}
		%>

		<%
			if (rList.size() != 0) {
				int i = 0;
				for (Reply r : rList) {
					i++;
					int replynum = r.getReplynum();
					String id = r.getId();
					String text = r.getText();
					String date = r.getInputdate();
		%><tr>
			<td>No.<%=i%></td>
			<td>작성자 : <%=id%></td>
			<td>날짜 : <%=date%></td>
		</tr>
		<tr>
			<td colspan="2" id="<%=replynum%>"><%=text%></td>
			<td>
				<%
					if (id.equals(session.getAttribute("loginId"))) {
				%>
				<button onclick="replyUpdate('<%=replynum%>');">수정</button>
				<button
					onclick="location.href='bs?action=replyDelete&rnum=<%=replynum%>'">삭제</button>
				<%
					}
				%>
			</td>
		</tr>
		<%
			}
			}
		%>

	</table>

	<div id="replyForm">
		<form id="reForm" action="bs" method="post"
			onSubmit="return checkReply();">
			<input type="hidden" name="action" value="replyInsert"> <input
				type="hidden" name="boardnum" value="<%=b.getBoardnum()%>">
			<input type="text" id="text" name="text" style="width: 500px">
			<input type="submit" value="리플달기">
		</form>
	</div>
	<table>
		<tr>
			<td><a href="bs?action=boardList">목록보기</a></td>
		</tr>
	</table>

</body>
</html>