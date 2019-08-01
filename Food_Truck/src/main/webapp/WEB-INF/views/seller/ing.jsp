<%@page import="com.foodtruck.vo.FoodTruckVO"%>
<%@page import="com.foodtruck.vo.OrderDetailVO"%>
<%@page import="com.foodtruck.vo.OrderVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%@include file="../comm/header2.jsp"%>
	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3" id="sidebar">
				<ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">

				</ul>
			</div>

			<!--/span-->
			<div class="span9" id="content">

				<div class="row-fluid">
					<!-- block -->
					<div class="block">
						<div class="navbar navbar-inner block-header">
							<div class="muted pull-left">푸드트럭이 없습니다</div>
							<div class="muted pull-right">
							</div>
						</div>
						<h4 align="center" class="info">승인중입니다</h4>
					</div>
					<!-- /block -->
				</div>
			</div>
		</div>
		
	</div>

</body>

</html>