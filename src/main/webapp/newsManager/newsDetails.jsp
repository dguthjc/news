<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'addNews.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.config.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.all.min.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/lang/zh-cn/zh-cn.js'	type="text/javascript"></script>  
  </head>
  <body>
  <div style="margin-top: 20px;margin-left: 8%">
    	<table width="800">
    		<tr>
				<td align="right">新闻类型：</td>
				<td>${news.type}</td>
			</tr>	
    		<tr>
				<td align="right">标题：</td>
				<td>${news.title}</td>
			</tr>
			<tr>
				<td align="right">作者：</td>
				<td>${news.author}</td>
			</tr>
			<tr>
				<c:if test="${news.status=='refuse'}">
					<td align="right">申请时间：</td>
					<td>${news.publicdata}</td>
				</c:if>
				<c:if test="${news.status=='pass'}">
					<td align="right">审核时间：</td>
					<td>${news.publicdata}</td>
				</c:if>
			</tr>
    	</table>
    	<hr style="width: 700px;margin-left: 65px">
    	<div style="width: 700px;margin-left: 65px">
    		<h4>新闻内容：</h4>
    		<div>
    			${news.content}
    		</div>
    	</div>
    </div>
  </body>
</html>
