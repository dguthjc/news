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
			float: left;margin-left: 1%;margin-top: 0.5%;
		}
		body {
			background-color: rgb(230,230,230);
		}
	</style>

  </head>
  
  <body>
    <form action="/news/admin?type1=searchNewsWithoutContent&page=1&pageSize=17" method="post" target="content_main">
			<div class="items">
				<span>类型</span>
				<span>
					<select name="type" id="typeOption">
						<option value="all">全部</option>
						<option value="military">军事</option>
						<option value="economics">财经</option>
						<option value="sports">体育</option>
						<option value="education">教育</option>
						<option value="entertainment">娱乐</option>
					</select>
				</span>
			</div>
			<div class="items">
				<span>标题：</span>
				<span><input type="text" name="title" style="width: 200px"></span>
			</div>
			<div class="items">
				<span>作者：</span>
				<span><input type="text" name="author" style="width: 80px;"></span>
			</div>
			<div class="items">
				<span>申请日期：</span>
				<span><input type="date" name="lowDate">-</span>
				<span>-<input type="date" name="upDate"></span>
			</div>
			
			<div class="items">
				<span><input type="submit" value="检索"/></span>
			</div>
			<input type="hidden" name="status" value="pass"/>
		</form>
  </body>
</html>
