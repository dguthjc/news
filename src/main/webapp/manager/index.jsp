<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  
  <frameset rows="80,*" framespacing="0" frameborder="yes">
	<frame name="top" src="head.jsp" scrolling="no" noresize="noresize"/>
	<frameset cols="165,*" framespacing="0">
		<frame name="sider" src="sider.jsp" scrolling="no" noresize="noresize"/>
		<frame name="content" src="content_main.jsp" scrolling="yes" noresize="noresize"/>
	</frameset>
  </frameset>
</html>
