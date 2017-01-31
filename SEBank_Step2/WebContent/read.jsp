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
<title>${ read.title }</title>
<style type="text/css">
.content {
	padding: 10px;
}

.heads {
	background-color: #e6e6ff;
	padding: 5px;
}

.textarea {
	border: none;
	column-fill: auto;
	width: 100%;
	resize: none;
}

.table6_1 table {
	width: 100%;
	margin: 15px 0;
	border: 0;
}

.table6_1 th {
	background-color: #93DAFF;
	color: #000000
}

.table6_1, .table6_1 th, .table6_1 td {
	font-size: 0.95em;
	text-align: center;
	padding: 4px;
	border-collapse: collapse;
}

.table6_1 th, .table6_1 td {
	border: 1px solid #6fcdfe;
	border-width: 1px 0 1px 0
}

.table6_1 tr {
	border: 1px solid #ffffff;
}

.table6_1 tr:nth-child(odd) {
	background-color: #dbf2fe;
}

.table6_1 tr:nth-child(even) {
	background-color: #ffffff;
}

.inin {
	width: 90%;
}
</style>

<script>

	function resize(o) {
		o.style.height = "1px";
		o.style.height = (25 + o.scrollHeight) + "px";

	}

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
		replyForm.innerHTML = "<form action='bs' method='post' onsubmit=''><input type='hidden' name='action' value='replyUpdate'><input type='hidden' name='rnum' value='" + replyNum + "'><input class='inin' type='text' name='text'><input type='submit' value='확인'></form>";
	}

	function boardDelete(num) {
		if (confirm('정말 삭제 하시겠습니까?')) {
			location.href = "bs?action=delete&num=" + num;
		}
	}
	function replyDelete(num) {
		if (confirm('정말 삭제 하시겠습니까?')) {
			location.href = 'bs?action=replyDelete&rnum=' + num;
		}
	}
</script>
</head>
<body>
	<%@ include file="index.jsp"%>
	<table border="1" width=700 class="table6_1">
		<tr class="heads">
			<td width=30>No.${ read.boardnum }</td>
			<td width=500><c:out value="${ read.title }"></c:out></td>
			<td>작성자 : ${ read.id }</td>
		</tr>
		<tr>
			<td class="content" colspan=3><textarea class="textarea"
					readonly="readonly" id="tex" onfocus="resize(this);"><c:out
						value="${ read.content }"></c:out></textarea></td>
		</tr>
		<%
			if (b.getId().equals(session.getAttribute("loginId"))) {
		%>

		<tr>
			<td colspan="3">
				<button
					onclick="location.href='bs?action=updateForm&num=${ read.boardnum }'">수정</button>
				<button onclick="boardDelete(${ read.boardnum });">삭제</button>
			</td>
		</tr>
		<%
			}
		%>
		<!-- /////////////////////////////////////////////////// -->
		<c:forEach var="r" items="${ reply }">

			<tr>
				<td>No.${ r.replynum }</td>
				<td>작성자 : ${ r.id }</td>
				<td>날짜 : ${ r.inputdate }</td>
			</tr>
			<tr>
				<td colspan="2" id="${ r.replynum }"><c:out value="${ r.text }" />
				</td>
				<td><c:if test="${ r.id eq loginId }">
						<button onclick="replyUpdate('${ r.replynum }');">수정</button>
						<button onclick="replyDelete('${ r.replynum }');">삭제</button>
					</c:if></td>
			</tr>
		</c:forEach>
		<!-- ////////////////////////////////////////////// -->
		<%-- <%
			if (rList.size() != 0) {
				int i = 0;
				for (Reply r : rList) {
					i++;
					int replynum = r.getReplynum();
					String id = r.getId();
					String text = r.getText();
					String date = r.getInputdate();
		%>
		<tr>
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
				<button onclick="replyDelete(<%=replynum%>);">삭제</button> <%
 	}
 %>
			</td>
		</tr>
		<%
			}
			}
		%> --%>

	</table>
	<script>
		resize(document.getElementById("tex"));
	</script>
	<div id="replyForm">
		<form id="reForm" action="bs" method="post"
			onSubmit="return checkReply();">
			<input type="hidden" name="action" value="replyInsert"> <input
				type="hidden" name="boardnum" value="${ read.boardnum }"> <input
				type="text" id="text" name="text" style="width: 500px"> <input
				type="submit" value="리플달기">
		</form>
	</div>
	<table>
		<tr>
			<td><a href="bs?action=boardList">목록보기</a></td>
		</tr>
	</table>
</body>
</html>