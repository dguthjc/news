<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'statisticByDate.jsp' starting page</title>
  </head>
  <style>
  	td{
  		width:120px;text-align: center;
  	}
  </style>
  <body>
    <table style="margin:0 auto;" border="1" cellspacing="0" >
    	<tr><td>年份</td><td>月份</td><td>日期</td><td>作者</td><td>发布新闻数</td><td>获得评论数</td></tr>
    	<c:forEach items="${statistics}" var="statistics">
    		<tr><td>${statistics.year}</td>
	    		<td>${statistics.month}</td>
	    		<td>${statistics.day}</td>
	    		<td>${statistics.author}</td>
	    		<td>${statistics.sumNews}</td>
	    		<td>${statistics.sumComment}</td>
    		</tr>
    	</c:forEach>
    </table>
  </body>
</html>
