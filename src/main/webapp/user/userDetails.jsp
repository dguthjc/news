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
    
    <title>My JSP 'userDetails.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
		body{
			background-image: url("/news/img/registerImg.PNG");font-family: "微软雅黑";
		}
		#container{
			margin-top:30px;margin-left:30%;
	  		width:500px;
			border-top: 1px solid #E5E5E5;
			border-bottom: 1px solid #E5E5E5;
		    border-left:  1px solid #E5E5E5;
		    border-right:  1px solid #E5E5E5;
		    background-color:#E6E6FA;
		  	padding-top: 15px;
		  	font-family: "微软雅黑";font-size: 18px;
		}
		.items{
			margin-left: 100px;margin-top: 20px;font-size: 18px;
		}
		.top{
			margin-left: 100px;margin-top: 20px;font-size: 22px;font-weight: 800px;
		}
	</style>

  </head>
  
  <body>
    <div id="container">
    	<div class="top">你在本网站中的详细信息如下：</div>
    	<div style="margin-top: 5px;">&nbsp;</div>
    	<div class="items">
    		<img alt="" src="${user.headimg}" width="100" height="100">
    	</div>
    	<div class="items">
    		<span>注册编号：</span>
    		<span>${user.userId}</span>
    	</div>
    	<div class="items">
    		<span>注册日期：</span>
    		<span>${user.registerDate}</span>
    	</div>
    	<div class="items">
    		<span>用户类型：</span>
    		<c:if test="${user.type=='user'}"><span>普通会员</span></c:if>
    		<c:if test="${user.type=='newsAuthor'}"><span>新闻发布员</span></c:if>
    		<c:if test="${user.type=='manager'}"><span>管理员</span></c:if>
    	</div>
    	<div class="items">
    		<span>用户名：</span>
    		<span>${user.name}</span>
    	</div>
    	<c:if test="${user.type=='user'}">
    		<div class="items">
    			<span>性别：</span>
    			<c:if test="${user.sex=='man'}">
    				<span>男</span>
    			</c:if>
    			<c:if test="${user.sex!='man'}">
    				<span>女</span>
    			</c:if>
    			
    		</div>
    		<div class="items">
    			<span>爱好：</span>
    			<c:if test="${empty user.hobby}">
    				<span>不详</span>
    			</c:if>
    			<c:if test="${!empty user.hobby}">
    				<span>${user.hobby}</span>
    			</c:if>
    		</div>
    	</c:if>
    	<div style="margin-top: 30px;margin-left: 100px;font-size: 14px;">
			<c:if test="${user.type=='user'}">
				<span><a href="${pageContext.request.contextPath }/user/modifyUserInfo.jsp"
				 target="_parent" style="text-decoration: none">信息修改</a></span>
			</c:if>
			<span style="margin-left: 10px;">
				<a href="${pageContext.request.contextPath }/user/modifyPwd.jsp"
				 target="_parent" style="text-decoration: none">密码修改</a>
			</span>
		</div>
    	<div class="items">&nbsp;</div>
    </div>
  </body>
</html>
