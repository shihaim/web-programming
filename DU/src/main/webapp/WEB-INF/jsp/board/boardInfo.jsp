<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 상세</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/layout/header.jsp"></jsp:include>
	</header>
	
	<table class="table" style="width: 50%;">
		<tr class="table-primary">
			<th>제목</th>
			<td><c:out value="${board.title }"></c:out></td>
			<th style="width: 10%;">작성자</th>
			<td style="width: 10%;"><c:out value="${board.writerName }"></c:out></td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3" style="width: 90%; height: 100px;"><c:out value="${board.content }"></c:out></td>
		</tr>
	</table>
	
	<div>
		<button type="button" class="btn btn-secondary btn-sm" onclick="history.back(); return false;">이전</button>
		
		<c:if test="${board.writerId == USER.userId }">
			<button type="button" class="btn btn-danger btn-sm" id="deleteBtn">삭제</button>
			<button type="button" class="btn btn-success btn-sm" id="modifyBtn">수정</button>
		</c:if>
	</div>
</body>
<script>
	window.onload = function() {
		var deleteBtn = document.getElementById("deleteBtn");
		
		
		deleteBtn.onclick = function() {
			if(confirm("삭제하시겠습니까?") == true) {
				var path = "${pageContext.request.contextPath}/boardDelete.do";
				var params = {
						"idx": "${board.idx}"
				}
				

				post(path, params);
			} else {
				return;
			}
		}
		
		var modifyBtn = document.getElementById("modifyBtn");
		
		modifyBtn.onclick = function() {
			var path = '${pageContext.request.contextPath}/boardModifyPage.do';
			var params = {
					"idx": "${board.idx}"
			}
			post(path, params)
		}
	}
	
	function post(path, params) {
		const form = document.createElement('form');
		form.method = 'post';
		form.action = path;
		
		for(const key in params) {
			if(params.hasOwnProperty(key)) {
				const hiddenField = document.createElement('input');
				hiddenField.type = 'hidden';
				hiddenField.name = key;
				hiddenField.value = params[key];
				
				form.appendChild(hiddenField);
			}
		}
		
		document.body.appendChild(form);
		form.submit();
	}
</script>
</html>