<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>My JSP 'head.jsp' starting page</title>
		<!--<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />-->
		<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="/news/css/head.css" type="text/css" />
	</head>
	<style>
		body{
			font-family: "微软雅黑";width: 1152px;margin: auto;
		}
		a{
			text-decoration: none;
		}
		#showDiv{
			font-size: 12px;background-color: #fff;
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
		function searchWord(obj){
			var word=$(obj).val();
			var content = "";
			$.post(
				"${pageContext.request.contextPath}/newsVisible",
				{"word":word,"type1":"seachNewsByWord"},
				function(data){
					if(data.length>0){
						for(var i=0;i<data.length;i++){
							content+="<div style='font-size:12px; padding:5px;cursor:pointer' onclick='clickFn(this)' onmouseover='overFn(this)' onmouseout='outFn(this)'>"+data[i]+"</div>";
						}
						$("#showDiv").html(content);
						$("#showDiv").css("display","block");
					}
					
				},
				"json"
			);
		}
		function overFn(obj){
			$(obj).css("background","#BFBFBF");
		}
		function outFn(obj){
			$(obj).css("background","#fff");
		}
		
		function clickFn(obj){
			$("#searchword").val($(obj).html());
			$("#showDiv").css("display","none");
		}
	</script>
	<body>
		<div id="main">
			<div class="top"> 
				<div class="top1">
					<span style="font-size: 12px;">欢迎访问......</span>
	                <div class="top1_1">
	                	<span>
	                		<!--
                        	作者：offline
                        	时间：2018-08-04
                        	描述：加载时间
                        -->
	                		<input type="text" id="clock" style="border: none;width: 190px"/>
	                	</span>
	                	<!--
		                	作者：offline
		                	时间：2018-08-04
		                	描述：登录，退出，注册，修改密码......
		                -->
		                <c:if test="${empty user }">
		                	<a href="/news/user/login.jsp" target="_parent">
		                		<span class="loginPadding">登录
		                		</span>
		                	</a>
		                </c:if>
		                <c:if test="${!empty user }">
		                	<a href="/news/user/userDetails.jsp" style="cursor: pointer;"><span style="color: green">欢迎你，${user.name}</span></a>
		                	<a href="/news/servlet/UserServlet?type1=exit" target="_parent"><span class="loginPadding">退出</span></a>
		                	<a href="${pageContext.request.contextPath }/user/modifyPwd.jsp" 
		                		target="_parent"><span class="loginPadding">修改密码</span></a>
		                </c:if>
	                	<a href="/news/user/register.jsp" target="_blank"><span class="loginPadding">注册</span></a>
	                </div>
                </div>
                <div class="clear"></div>
                <div style="border-top: #BFBFBF 0.5px dashed; overflow: hidden; height: 0.5px"></div>
                <!--
                	作者：offline
                	时间：2018-08-04
                	描述：logo图，搜索框，天气预报
                -->
                <div>
                	<div id="logo">
                		<img src="/news/img/weather.jpg" width="220px" height="54px"/>
                	</div>
                	<div id="search" style="position: relative;">
                		<form action="${pageContext.request.contextPath}/newsVisible?type1=searchBytitle" method="post">
							<div class="form_input" style="position: relative;">
								<input id="searchword" type="text" placeholder="search" style="width: 85%;height: 30px;"
									onkeyup="searchWord(this)" name="title">
								<div style="width: 84.8%;position: absolute;top:28;border: 1px solid #ccc;
									display: none;" id="showDiv">
									
								</div>
							</div>
							<div style="position:absolute;top: -1px;left: 84.8%;">
								<input type="submit" style="height: 31px;" value="搜索">
							</div>
                		</form>
                	</div>
                	<span id="weather">
                		<!--
                        	作者：offline
                        	时间：2018-08-04
                        	描述：引入天气预报插件
                        -->
						<iframe width="200" scrolling="no" height="65" frameborder="0" class="weather"
							allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=12&icon=5&num=1">
  						 </iframe>              		
                	</span>
                </div>
                <div class="clear"></div>
                <!--
                	作者：offline
                	时间：2018-08-04
                	描述：导航条
                -->
                <div id="top2">
                	<span id="navFirst"><a href="/news/index" target="_parent">首页</a></span>
                	<span id="nav"><a href="/news/newsVisible?type1=showNewsToAll&type=military&page=1&pageSize=15" target="_blank">军事</a></span>
                	<span id="nav"><a href="/news/newsVisible?type1=showNewsToAll&type=economics&page=1&pageSize=15" target="_blank">财经</a></span>
                	<span id="nav"><a href="/news/newsVisible?type1=showNewsToAll&type=education&page=1&pageSize=15" target="_blank">教育</a></span>
                	<span id="nav"><a href="/news/newsVisible?type1=showNewsToAll&type=sports&page=1&pageSize=15" target="_blank">体育</a></span>
                	<span id="nav"><a href="/news/newsVisible?type1=showNewsToAll&type=entertainment&page=1&pageSize=15" target="_blank">娱乐</a></span>
                	<span style="padding-top: 10px;">
                		<marquee behavior="scroll" direction="left" class="marquee" 
                			scrollamount=3 scrolldelay=0 onmouseover="this.stop()" onmouseout="this.start()">
							没有账号？点击右上方注册即可完成。登录后可参与新闻评论哦
	               		</marquee>
                	</span>
                </div>
			</div>	
			<div>
				
			</div>
		</div>
	</body>
</html>
