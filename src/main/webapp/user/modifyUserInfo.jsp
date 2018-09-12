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
		$(function(){
			$("#hobby").html("${user.hobby}");
			$("#sex option[value='${user.sex}']").prop("selected",true);
		});
		function checkHobby(){
			var str = document.getElementById("hobby").innerHTML;
			if(str.length > 20){
				document.getElementById("hobbyTip").innerHTML="*最多20字";
				document.getElementById("hobbyTip").style.color="red";
				return false;
			}else{
				$("#hobbyTip").html("");
				return true;
			}
		}
		
		function isModify(){
			var str1 = document.getElementById("hobby").innerHTML;
			var str2 = document.getElementById("sex").value;
			var str3 = document.getElementById("show").src;
			var str4 = "http://localhost:8080"+"${user.headimg}";
			if(str1=="${user.hobby}" && str2=="${user.sex}" && str3==str4){
				$("#isModifyTip").html("*信息未修改");
				document.getElementById("isModifyTip").style.color="red";
				return false;
			}else{
				$("#isModifyTip").html("");
				return true;
			}
		}
		
		 function changepic() {
	        var reads= new FileReader();
	        f=document.getElementById('file').files[0];
	        reads.readAsDataURL(f);
	        reads.onload=function (e) {
	            document.getElementById('show').src=this.result;
	        };
	    }
		
		function submit1(){
			var result=false;
			result=checkHobby() && isModify();
			return result; 
		}
		
		function check(){
			checkHobby();
			isModify();
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
    	<form action="${pageContext.request.contextPath}/servlet/UserServlet?type1=modifyUserInfo"
    		 method="post" id="myform" enctype="multipart/form-data">
	    	<div id="title">
	    		<h3>用户信息修改</h3>
	    	</div>
	    	<div style="text-align: center;" id="isModifyTip"></div>
	    	<div style="margin-left: 20%;margin-top: 25px;">
	    		<div style="float: left;font-size: 18px;line-height: 35px;">
	    			头像：
	    		</div>
	    		<div>
	    			<img alt="" src="${user.headimg}" width="100" height="100" id="show">
	    		</div>
	    		<div style="margin-left: 4em;">
	    			<input type="file" name="headImg" 
	    			style="width: 63%;" onchange="changepic(this)" id="file">
	    		</div>
	    	</div>
	    	<div class="tip" id="birthdayTip"></div>
	    	<div style="margin-left: 20%;margin-top: 25px;">
	    		<div style="float: left;font-size: 18px;line-height: 35px;">
	    			性别：
	    		</div>
	    		<div>
	    			<select  class="form-control" name="sex" id="sex" style="width: 63%;">
	    				<option value="man">男</option>
	    				<option value="felman">女</option>
	    			</select>
	    		</div>
	    	</div>
	    	<div style="margin-left: 20%;margin-top: 25px;">
	    		<div style="float: left;font-size: 18px;line-height: 35px;">
	    			爱好：
	    		</div>
	    		<div>
	    			<textarea class="form-control" rows="3" 
	    				style="width: 63%;" id="hobby" name="hobby"  onblur="checkHobby();">
	    			</textarea>
	    		</div>
	    	</div>
	    	<div class="tip" id="birthdayTip"></div>
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
