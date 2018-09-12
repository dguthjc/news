<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>注册</title>
    <script type="text/javascript">
    	function valName(){
			var pattern = new RegExp("^[a-z]([a-z0-9])*[-_]?([a-z0-9]+)$","i");//创建模式对象
			var str1=document.getElementById("name").value;//获取文本框的内容
			
			if(document.getElementById("name").value==null || document.getElementById("name").value==""){
				document.getElementById("namespan").innerHTML="*不能为空";
				document.getElementById("namespan").style.color="red";
				return false;
			}else if(str1.length>=4 && pattern.test(str1)){//pattern.test() 模式如果匹配，会返回true，不匹配返回false
				document.getElementById("namespan").innerHTML="ok";
				document.getElementById("namespan").style.color="green";
				return true;
			}else{
				document.getElementById("namespan").innerHTML="*用户名至少需要4个字符，以字母开头，以字母或数字结尾，可以有-和_";
				document.getElementById("namespan").style.color="red";
				return false;
			}
		}
		
		function valPassword(){
			var str = document.getElementById("password").value;
			var pattern=/^(\w){6,20}$/;
			
			if(document.getElementById("password").value==null || document.getElementById("password").value==""){
				document.getElementById("passwordspan").innerHTML="*不能为空";
				document.getElementById("passwordspan").style.color="red";
				return false;
			}else if(str.match(pattern)==null){
				document.getElementById("passwordspan").innerHTML="*密码只能输入6-20个字母、数字、下划线";
				document.getElementById("passwordspan").style.color="red";
				return false;
			}else{
				document.getElementById("passwordspan").innerHTML="ok";
				document.getElementById("passwordspan").style.color="green";
				return true;
			}
		}
	
		function passwordSame(){
			var str = document.getElementById("password").value;
			if(document.getElementById("password2").value==null || document.getElementById("password2").value==""){
				document.getElementById("passwordspan2").innerHTML="*不能为空";
				document.getElementById("passwordspan2").style.color="red";
				return false;
			}else if(document.getElementById("password").value==document.getElementById("password2").value){			
				document.getElementById("passwordspan2").innerHTML="ok";
				document.getElementById("passwordspan2").style.color="green";
				return true ;
			}else{
				document.getElementById("passwordspan2").innerHTML="*两次密码不一样";
				document.getElementById("passwordspan2").style.color="red";
				return false;
			}
					
		}
		function valHobby(){
			var str = document.getElementById("hobby").value;
			if(str.length<=20){
				document.getElementById("hobbydiv").innerHTML="ok";
				document.getElementById("hobbydiv").style.color="green";
				return true;
			}else{
				document.getElementById("hobbydiv").innerHTML="*输入不能多于20字";
				document.getElementById("hobbydiv").style.color="red";
				return false;
			}
					
		}
		
		function submit1(){
			result1=valName();
			result1=valPassword() && result1;
			result1=passwordSame() && result1;
			result1=valHobby() && result1;
			if( result1)
				return true;//提交
			else 
				return false;//阻止提交
		}
		
		window.onload=function(){
	     	var dis=document.getElementsByClassName("display");
			if(document.getElementById("typeOption").value=="user"){
				dis[0].style.display="block";
				dis[1].style.display="block";
			}
			else{
				dis[0].style.display="none";
				dis[1].style.display="none";
			}
		}
	
		function displaycommen(){
			var dis=document.getElementsByClassName("display");
			if(document.getElementById("typeOption").value=="user"){
				dis[0].style.display="block";
				dis[1].style.display="block";
			}
			else{
				dis[0].style.display="none";
				dis[1].style.display="none";
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
    </script>
    <style type="text/css">
    	body{
			background-image: url("/news/img/registerImg.PNG");font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
		}
		#container{
			margin-top:50px;margin:auto;
	  		width:500px;
			border-top: 1px solid #E5E5E5;
			border-bottom: 1px solid #E5E5E5;
		    border-left:  1px solid #E5E5E5;
		    border-right:  1px solid #E5E5E5;
		    background-color:#E6E6FA;
		  	padding-top: 15px;
		    font-size: 18px;
		}
		#item1{
			font-size: 28px;text-align: center;margin-top: 20px;font-weight: 600px;margin-bottom: 20px;
		}
		.item2{
			margin-left: 120px;margin-top: 20px;
		}
		.text-align{
			margin-left: 2em;
		}
		#namespan{
			font-size: 15px;
		}
		#passwordspan{
			font-size: 15px;
		}
		#passwordspan2{
			font-size: 15px;
		}
		.tap-font{
			font-size: 14px;
		}
    </style>
    
  </head>
  
  <body>
  	<form action="/news/servlet/UserServlet?type1=register" method="post" onsubmit="return submit1()" enctype="multipart/form-data">
	<div id="container">
		<div id="item1">用户注册</div>
		<div>
		
		</div>
		<div class="item2">
			<span>用户类型：</span>
			<span>
				<select name="type" id="typeOption" onclick="displaycommen()" style="height: 25px;">
					<option value="user">普通用户</option>
					<option value="newsAuthor">新闻发布员</option>
					<option value="manager">管理员</option>
				</select>
			</span>
		</div>
		<div class="item2">
			<span style="margin-left: 6px;;">用 户 名：</span>
			<span>
				<input type="text" name="name" id="name" onBlur="valName()" style="height: 25px;"
				 placeholder="4个字符以上">
			</span>
			<span id="namespan" class="tap-font"></span>
		</div>
		<div class="item2">
			<span class="text-align">头像：</span>
			<span>
				<img alt="" src="/news/img/default.jpg" width="100" height="100" id="show">
			</span>
			<div style="margin-left: 5em;">
				<input type="file" name="headimg" style="height: 25px;" 
					placeholder="上传头像" id="file" onchange="changepic(this)">
			</div>
		</div>
		<div class="display item2">	
			<span class="text-align">性别：</span>
			<span>
				<select name="sex" id="sexOption" style="height: 25px;">
						<option value="man">男</option>
						<option value="felman">女</option>
				</select>
			</span>
		</div>
		<div class="item2">
			<span class="text-align">密码：</span>
			<span><input type="password" name="password" id="password" onBlur="valPassword()"
			 style="height: 25px;"  placeholder="6-20位数字或字母">
			<span id="passwordspan" class="tap-font"></span></span>
		</div>
		<div class="item2">
			<span>确认密码：</span>
			<span><input type="password" name="password2" id="password2" onBlur="passwordSame()"  style="height: 25px;">
			<span id="passwordspan2" class="tap-font"></span></span>
		</div>
		<div class="display item2" style="position: relative;">
			<span style="position: relative;top: -30px" class="text-align">爱好：</span>
			<span>
				<textarea  rows="3" cols="30" name="hobby" id="hobby" onBlur="valHobby()" 
					placeholder="最多输入20字" style="resize: none;"></textarea>
			</span>
			<div id="hobbydiv" class="tap-font" style="position: absolute;left: 5em;"></div>
		</div>
		<div style="margin-left: 200px;margin-top: 20px;">
			<span><input type="submit" value="注册"  style="height: 28px"/></span>
			<span style="padding-left: 20px;" ><input type="reset" value="重置"  style="height: 28px"/></span>
		</div>
		<div style="margin-top: 20px;">&nbsp;</div>
	</div>
	</form>
  </body>
</html>
