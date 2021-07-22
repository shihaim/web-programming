<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<a href="#" onclick="downloadFile(); return false;">${board.attFilename }</a>
				</td>
			</tr>
		</table>
		
		<div>
			<button type="button" class="btn btn-secondary btn-sm" onclick="history.back(); return false;">이전</button>
			
			<c:if test="${board.writerId == USER.userId }">
				<button type="button" class="btn btn-danger btn-sm" id="deleteBtn">삭제</button>
				<button type="button" class="btn btn-success btn-sm" id="modifyBtn">수정</button>
			</c:if>
		</div>
		<form id="fileDownload" action="${pageContext.request.contextPath }/download/boardAttFile.do" method="post">
			<input type="hidden" name="boardIdx" value="${board.idx }"/>
			<input type="hidden" name="idx" value="${board.attIdx }"/>
		</form>
		
		<div id="replyDiv" style="margin-top: 10px;">
			<form action="${pageContext.request.contextPath }/replyWrite.do" method="post">
				<table class="table table-light" style="width: 50%;">
					<tr>
						<th style="width: 10%;">댓글</th>
						<td>
							<input type="text" name="content" style="width: 90%;" />
							<button type="submit" class="btn btn-success btn-sm">등록</button>
						</td>
					</tr>
					
					<c:forEach items="${replyList }" var="item" varStatus="status">
						<tr>
							<th style="width: 10%;"><c:out value="${item.writerName }"></c:out></th>
							
							<td data-idx="${item.idx }">
								<span><c:out value="${item.content }"></c:out></span>
								<c:if test="${USER.userId == item.writerId}">
									<button type="button" class="btn btn-danger btn-sm" style="float: right;" onclick="deleteReply('${item.idx}');">삭제</button>
									<button type="button" class="btn btn-success btn-sm replyModifyBtn" style="float: right; margin-right: 5px;">수정</button>
								</c:if>
								<c:choose>
									<c:when test="${item.modifyDate != null }">
										<fmt:parseDate value="${item.modifyDate }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="date"></fmt:parseDate>
										<br>(<fmt:formatDate value="${date }" pattern="yyyy-MM-dd HH:mm:ss"/>)
									</c:when>
									<c:otherwise>
										<fmt:parseDate value="${item.registDate }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="date"></fmt:parseDate>
										<br>(<fmt:formatDate value="${date }" pattern="yyyy-MM-dd HH:mm:ss"/>)
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					
				</table>
				<input type="hidden" name="boardIdx" value="${board.idx}" />
			</form>
		</div>
		<form id="hiddenForm" style="display: none;" action="${pageContext.request.contextPath}/replyModify.do" method="post">
			<input type="text" name="content" style="width: 80%; margin-right: 6px;" />
			<input type="hidden" name="idx" />
			<input type="hidden" name="boardIdx" value="${board.idx }" />
			<button type="submit" class="btn btn-primary">확인</button>
		</form>
		
	</body>
	
	<script>
		window.onload = function() {
			
			var deleteBtn = document.getElementById("deleteBtn");
			
			deleteBtn.onclick = function() {
				if(confirm("삭제하시겠습니까?") == true) {
					var path = "${pageContext.request.contextPath}/boardDelete.do";
					var params = {
							"idx"		: "${board.idx}",
							"attIdx"	: "${board.attIdx}"
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
				post(path, params);
			}
			
		}
		
		function deleteReply(idx) {
			if(confirm("댓글을 삭제하시겠습니까?") == true) {
				var path = "${pageContext.request.contextPath }/replyDelete.do";
				var params = {
						"idx": idx,
						"boardIdx": "${board.idx}"
				};
				post(path, params)
			} else {
				return;
			}
		}
		
		
		

		
		
		var replyModifyBtns = document.querySelectorAll('.replyModifyBtn');
		replyModifyBtns.forEach(el => el.addEventListener('click', event => {
			
			var td = el.parentNode;
			var content = td.getElementsByTagName('span')[0].innerHTML;
			
			td.innerHTML = '';
			td.append(makeReplyUpdateForm(td.getAttribute('data-idx'), content));
			
		}));
		
		
		function makeReplyUpdateForm(idx, content) {
			
			var form = document.getElementById('hiddenForm').cloneNode(true);
			form.style.display = '';
			
			var contentInput = form.getElementsByTagName("input")[0];
			contentInput.value = content;
			
			var idxInput = form.getElementsByTagName("input")[1];
			idxInput.value = idx;
			
			return form;
			
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
		
		function downloadFile() {
			var inputIdx = document.querySelector('#fileDownload > input[name="idx"]');
			
			if(inputIdx.value) {
				document.forms["fileDownload"].submit();
			}
		}
		
		
	</script>
</html>