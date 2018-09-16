<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'register.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
		function changeImg(obj){
			obj.src="${pageContext.request.contextPath}/code?time="+new Date().getTime();
		}
		
		function checkNewPassword(){
			var str = document.getElementById("newPassword").value;
			var pattern=/^(\w){6,20}$/;
			if(str==null || str==""){
				document.getElementById("newPasswordTip").innerHTML="*密码不能为空";
				document.getElementById("newPasswordTip").style.color="red";
				return false;
			}else if(str=="${user.password}"){
				document.getElementById("newPasswordTip").innerHTML="*密码未修改";
				document.getElementById("newPasswordTip").style.color="red";
				return false;
			}else if(str.match(pattern)==null){
				document.getElementById("newPasswordTip").innerHTML="*密码只能输入6-20个字母、数字、下划线";
				document.getElementById("newPasswordTip").style.color="red";
				return false;
			}else{
				document.getElementById("newPasswordTip").innerHTML="";
				return true;
			}
		}
		
	
		function checkConfirmPwd(){
			var str = document.getElementById("confirmPwd").value;
			if(document.getElementById("confirmPwd").value==null || document.getElementById("confirmPwd").value==""){
				document.getElementById("confirmPwdTip").innerHTML="*请确认密码";
				document.getElementById("confirmPwdTip").style.color="red";
				return false;
			}else if(document.getElementById("newPassword").value==document.getElementById("confirmPwd").value){			
				document.getElementById("confirmPwdTip").innerHTML="";
				return true ;
			}else{
				document.getElementById("confirmPwdTip").innerHTML="*两次密码不一样";
				document.getElementById("confirmPwdTip").style.color="red";
				return false;
			}
					
		}
		
		function submit1(){
			var result=false;
			result=checkNewPassword() && checkConfirmPwd();
			return result; 
		}
		
		function check(){
			checkNewPassword();
			checkConfirmPwd();
			if(submit1()){
				$("#myform").submit();
			}
		}
	</script>
	
	<style type="text/css">
		body {
			background-image: url("${pageContext.request.contextPath}/images/register.jpg");
		}
		#main{
			width:580px;margin:auto;
			background-color:#e5f2d8;
			border-bottom: 1px solid;border-top: 1px solid;
			border-right: 1px solid;border-left: 1px solid;
			border-bottom-left-radius: 5px;border-bottom-right-radius: 5px;
			border-top-left-radius: 5px;border-top-right-radius: 5px;
		}
		#title,.mainInput{
			text-align: center;
		}
		.tip{
			margin-left: 20%;
		}
		#title{
			font-size: 25px;
		}
		.mainInput{
			margin-top: 25px;
		}
		.clear{
			clear: both;
		}
	</style>
  </head>
  
  <body>
    <div id="main" style="border-color: #b1d57e;">
    	<form id="myform" action="${pageContext.request.contextPath}/servlet/UserServlet?type1=modifyPwd" 
    		method="post" onsubmit="return submit1()">
	    	<div id="title">
	    		<h2>用户密码修改</h2>
	    	</div>
	    	<c:if test="${!empty registerInfo}">
	    		<div style="text-align: center;color: red">${registerInfo}</div>
	    	</c:if>
	    	<div class="mainInput">
		    	<input type="password" class="form-control" id="newPassword" name="newPassword"
		    		placeholder="请输入新密码" style="width: 60%;margin-left: 20%;" onblur="checkNewPassword();">
	    	</div>
	    	<div class="tip" id="newPasswordTip"></div>
	    	<div class="mainInput">
		    	<input type="password" class="form-control" id="confirmPwd" name="confirmPwd"
		    		placeholder="请确认密码" style="width: 60%;margin-left: 20%;" onblur="checkConfirmPwd();">
	    	</div>
	    	<div class="tip" id="confirmPwdTip"></div>
	    	<div class="mainInput">
	    		<div style="margin-left: 35%;float: left;">
	    			<input type="submit" id="sbt" name="sbt" class="btn btn-primary" data-toggle="button" value="提交"
	    			  onclick="check();">
	    		</div>
	    		<div style="margin-left: 10%;float: left;">
	    			<input type="reset" class="btn btn-primary" data-toggle="" value="重置">
	    		</div>
	    		
	    	</div>
	    	<div style="margin-top: 60px;">&nbsp;</div>
    	</form>
    </div>
  </body>
</html>
