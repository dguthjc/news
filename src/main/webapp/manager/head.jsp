<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'head.jsp' starting page</title>
    
    <style>
    	body{
    		background-color: rgb(39,130,150);
    	}
		#welcom{
			float: left;margin-left: 37%;margin-top:8px;font-size: 28px;font-family: "微软雅黑";color: #fff;
		}
		#lr{
			float: right;margin-right: 5%;font-family: "微软雅黑";font-size: 14px;
			margin-top: 25px;
		}
		#lr a{
			padding-left: 10px;
		}
		input{
			background-color: rgb(39,130,150);border: none;color: #fff;float: right;margin-right: 5%;
		}
	</style>
   	<script>
		function showTime(){
			var t=new Date();
			var year=t.getFullYear();
			var month=t.getMonth()+1;
			var day=t.getDate();
			var week=t.getDay();
			var arr=new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
			var hour=t.getHours();
			var minute=t.getMinutes();
			var second=t.getSeconds();
			var showTime=year+"-"+month+"-"+day+" "+arr[week]+" "+hour+((minute<10)?":0":":")
				+minute+((second<10)?":0":":")+second+((hour>12)?".PM":".AM");
			document.getElementById("clock").value=showTime;
		}
		setInterval("showTime()",1000);
	</script>
	<style type="text/css">
		a{
			text-decoration: none;color: black;
		}
	</style>
  </head>
  
  <body>
    <div>
		<span id="welcom">欢迎使用XXX新闻管理系统</span>
		<span>
     		<input type="text" id="clock" style="border: none;width: 190px"/>
     	</span>
		<span id="lr">
			<a>桌面</a>
			<a>管理员：${user.name}</a><span></span>
			<a href="/news/servlet/UserServlet?type1=exit" target="_blank">退出</a>
			<a>修改密码</a>
		</span>
	</div>
  </body>
</html>
