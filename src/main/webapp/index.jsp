<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'index.jsp' starting page</title>
    <script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
  </head>
  <style>
  	li{
  		list-style-type: none;margin-bottom: 10px;
  		font-family: "微软雅黑";font-size: 15px;
  	}
  	.news_a a{
  		color: black;
  	}
  	#sideshow{
  		margin-left: 2%;margin-top: 20px;
  	}
  	#latestNews{
  	    float:right;margin-right:2%;margin-top: 20px;
  		width: 470px;height:890px;
		border-top: 1px solid #cccccc;
	    border-bottom: 1px solid #cccccc;
	    border-left:  1px solid #cccccc;
	    border-right:  1px solid #cccccc; 
  	}
  	#hotNews{
  		float:left;margin-left:2%;margin-top:10px;
  		width: 600px;height:514px;
		border-top: 1px solid #cccccc;
	    border-bottom: 1px solid #cccccc;
	    border-left:  1px solid #cccccc;
	    border-right:  1px solid #cccccc; 
  	}
  	.li_border{
  		border-top: 1px solid #BFBFBF;margin: auto;margin-top: 15px;margin-right: 10%;
  	}
  	.title_border{
  		border-top: 3px solid #325D32;width: 6em;float:top;margin-left: 12px;
  	}
  	.topTitle{
  		margin-left: 12px;margin-top:8px;font-size: 24px;font-family: "微软雅黑";
  	}
  	#hotNews_search{
  		font-family: "微软雅黑";font-size: 16px;margin-top: 10px;margin-left: 4%
  	}
  	#hotNews_comment{
  		font-family: "微软雅黑";font-size: 16px;margin-top: px;float: right;margin-right: 25px;
  	}
  	#hotNewsItemborder{
  		border-top: 1px dashed #BFBFBF;margin: auto;margin-top: 5px;margin-right: 25px;
  	}
  	.typeItems1{
  		float:left;margin-left:2%;margin-top:10px;
  		width: 31%;height:320px;
		border-top: 1px solid #cccccc;
	    border-bottom: 1px solid #cccccc;
	    border-left:  1px solid #cccccc;
	    border-right:  1px solid #cccccc; 
  	}
	.typeItems2{
  		float:left;margin-left:14px;margin-top:10px;
  		width: 31%;height:320px;
		border-top: 1px solid #cccccc;
	    border-bottom: 1px solid #cccccc;
	    border-left:  1px solid #cccccc;
	    border-right:  1px solid #cccccc; 
  	}
	.typeItems3{
  		float:right;margin-right:2%;margin-top:10px;
  		width: 31%;height:320px;
		border-top: 1px solid #cccccc;
	    border-bottom: 1px solid #cccccc;
	    border-left:  1px solid #cccccc;
	    border-right:  1px solid #cccccc; 
  	}
  	.news_a a{
  		color: black;
  	}
  </style>
  <script>
		<!--轮播图实现-->
		function init(){
			//书写轮图片显示的定时操作
			setInterval("changeImg()",3000);
		}
		
		//书写函数
		var i=0
		function changeImg(){
			i++;
			//获取图片位置并设置src属性值
			document.getElementById("img1").src="/news/img/"+i+".PNG";
			if(i==4){
				i=0;
			}
		}
	</script>
	<body onload="init()">
		<div>
			<jsp:include page="/head.jsp"></jsp:include>
		</div>
		
		<!-- 最新新闻 -->
		<div id="latestNews">
		    <div class="title_border"></div>
			<div class="topTitle">最新新闻</div>
			<ul class="news_a">
				<c:forEach items="${latestNews}" var="news" varStatus="vs">
					<c:if test="${vs.count%5==1}">
						<c:if test="${vs.count==11}">
							<div>
								<img alt="" src="/news/img/active.gif" width="400" style="margin-top: 10px;">
							</div>
						</c:if>
						<li>
							<a style="color: red" href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
					</c:if>
					<c:if test="${vs.count%5==0}">
						<li>
							<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
						<div class="li_border"></div>
					</c:if>
					<c:if test="${vs.count%5!=1 && vs.count%5!=0}">
						<li>
							<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
					</c:if>
				</c:forEach>
			</ul>
		</div>
		<!--
        	作者：offline
        	时间：2018-08-04
        	描述：轮播图
        -->
        <div id="sideshow">
			<img src="/news/img/4.PNG" width="600" height="365.733" id="img1"/>
		</div>
		<!-- <div class="clear"></div> -->
		<!-- 热搜新闻 -->
		<div id="hotNews">
			<div class="title_border"></div>
			<div class="topTitle">热搜新闻</div>
			<div>
				<span id="hotNews_search">排行榜</span>
				<span id="hotNews_comment"">评论数</span>
			</div>
			<ul class="news_a">
				<c:forEach items="${hotNews}" var="news"  varStatus="vs">
					<li style="margin-left: -15px;"/>
					    <c:if test="${vs.count<=3 }">
					    	<span style="color: red">NO${vs.count}.  </span>
					    	<span class="news_a">
					    		<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
					    	</span>
							<span style="float: right;margin-right: 40px">${news.commentnumber}</span>
					    </c:if>
					    <c:if test="${vs.count>3 }">
					    	<span>NO${vs.count}.  <a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
							</span>
							<span style="float: right;margin-right: 40px">${news.commentnumber}</span>
					    </c:if>
					<div id="hotNewsItemborder"></div>
				</c:forEach>
			</ul>
		</div>
		<img src="/news/img/activePlane.gif" width="31%" height="320" style="margin-left: 2%;
			margin-top: 10px;float:left">
		
		<div class="typeItems2">
			<div class="title_border"></div>
			<div class="topTitle">军事新闻</div>
			<ul class="news_a">
				<c:forEach items="${military}" var="news">
					<li style="margin-left: -28px;"/>
						<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
				</c:forEach>
			</ul>
		</div>
		<div class="typeItems3">
			<div class="title_border"></div>
			<div class="topTitle">财经新闻</div>
			<ul class="news_a">
				<c:forEach items="${economics}" var="news">
					<li style="margin-left: -28px;"/>
						<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
				</c:forEach>
			</ul>
		</div>
		<div class="typeItems1">
			<div class="title_border"></div>
			<div class="topTitle">猜你喜欢</div>
			<ul class="news_a">
				<c:forEach items="${military}" var="news">
					<li style="margin-left: -28px;"/>
						<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
				</c:forEach>
			</ul>
		</div>
		<div class="typeItems2">
			<div class="title_border"></div>
			<div class="topTitle">体育新闻</div>
			<ul class="news_a">
				<c:forEach items="${sports}" var="news">
					<li style="margin-left: -28px;"/>
						<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
				</c:forEach>
			</ul>
		</div>
		<div class="typeItems3">
			<div class="title_border"></div>
			<div class="topTitle">娱乐新闻</div>
			<ul class="news_a">
				<c:forEach items="${entertainment}" var="news">
					<li style="margin-left: -28px;"/>
						<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">${news.title}</a>
				</c:forEach>
			</ul>
		</div>
		<div class="clear"></div>
		<div>
			<jsp:include page="/foot.jsp"></jsp:include>
		</div>
	</body>
  
</html>
