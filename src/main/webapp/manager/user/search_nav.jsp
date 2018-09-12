<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'allContent_nav.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>
		.items{
			float: left;margin-left: 2%;margin-top: 0.5%;
		}
		body {
			background-color: rgb(230,230,230);
		}
	</style>

  </head>
  
  <body>
    <form action="/news/admin?type1=search&page=1&pageSize=2" method="post" target="content_main">
			<div class="items">
				<span>类型</span>
				<span>
					<select name="type">
						<option value="all">全部</option>
						<option value="user">用户</option>
						<option value="newsAuthor">新闻发布员</option>
						<option value="manager">管理员</option>
					</select>
				</span>
			</div>
			<div class="items">
				<span>用户名：</span>
				<span><input type="text" name="name" style="width: 80px;"></span>
			</div>
			<div class="items">
				<span>注册日期：</span>
				<span><input type="date" name="lowDate">-</span>
				<span>-<input type="date" name="upDate"></span>
			</div>
			<div class="items">
				<span>账号可用性：</span>
				<span>
					<select name="enable" id="select">
							<option value="all">全部</option>
							<option value="use">可用</option>
							<option value="stop">停用</option>
					</select>
				</span>
			</div>
			<div class="items">
				<span><input type="submit" value="检索"/></span>
			</div>
		</form>
  </body>
</html>
