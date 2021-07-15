<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap/bootstrap.css">
	<link rel="stylesheet" href="css/main.css">
	<script type="text/javascript" src="js/bootstrap/bootstrap.bundle.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div class="logoDiv">
			<img alt="대구대학교 로고" src="images/symbol_1.jpg">
		</div>
		<ul class="infoUl">
			<li><a href="deptPage.do">부서정보</a></li>
		</ul>
		<div class="userInfoDiv">
			반갑습니다! <c:out value="${USER.name}"></c:out>님
			<button type="button" onClick="window.location.href='logout.do'" class="btn btn-primary btn-sm">로그아웃</button>
			<button type="button" onClick="window.location.href='userInfoConfirmPage.do'" class="btn btn-outline-primary btn-sm">내정보</button>
		</div>
</body>
</html>