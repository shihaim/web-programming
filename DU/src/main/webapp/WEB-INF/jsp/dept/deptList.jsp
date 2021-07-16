<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 정보</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/jsp/layout/header.jsp"></jsp:include>
	</header>
	<table class="table table-hover table-sm">
		<thead>
			<tr>
				<th>부서코드</th>
				<th>부서명</th>
				<th>추가기능</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${dept }" var="item">
				<tr>
					<td><c:out value="${item.deptCd }"></c:out></td>
					<td><c:out value="${item.deptNm }"></c:out></td>
					<td><button type="button" onclick="window.location.href='deleteDept.do?deptCd=${item.deptCd}'">부서 삭제</button></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<button type="button" onclick="window.location.href='deptInsertPage.do'">부서 등록</button>
		<button type="button" onclick="window.history.go(-1)">이전</button>
	</div>
</body>
</html>