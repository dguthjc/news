<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'statisticsOption.jsp' starting page</title>
    <style type="text/css">
    	.clear{clear:both;}
    </style>
  </head>
  
  <body>
  	<div style="float: left;">
  		(1)分别按全部日期、近一年、近一个月、近一周统计新闻发布员发布新闻件数、普通用户发布评论的数目，按降序显示。
  	</div>
  	<div style="float: left;margin-left: 10px;">
  		<form action="/news/statisticsServlet?type1=statisticsByDate" method="post" target="content_main">
	  		<select name="role">
	  			<option value="newsAuthor">新闻发布员发布新闻件数</option>
	  			<option value="userComment">普通用户发布评论的数目</option>
	  		</select>
	  		<select name="date">
	  			<option value="all">全部</option>
	  			<option value="nearYear">近一年</option>
	  			<option value="nearMonth">近一个月</option>
	  			<option value="nearWeek">近一周</option>
	  		</select>
	  		<input type="submit" value="检索">
  		</form>
  	</div>
  	<div class="clear" style="margin-top: px;">
  		(2)<a href="/news/statisticsServlet?type1=statisticsTotal" target="content_main">
  			统计近一年内每个月总新闻件数、总评论数据。
  		</a>
  	</div>
  </body>
</html>
