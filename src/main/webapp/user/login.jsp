<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	background-image: url("/news/img/loginImg.png");
}
.text_with {
	width: 200px;
	text-align: right;
}

#login_buttom {
	text-align: center;
}

table {
	background-color: #cccccc;
	margin: 0 auto;margin-top: 100px;
}

#login_buttom input:hover {
	background-color: rgb(30, 144, 255);
}

tr {
	line-height: 30px;
}

tr th {
	font-size: 20px;
}

input {
	height: 22px;
}
</style>
<script type="text/javascript">

		function checkUser(){
	            var Value = document.getElementById("user").value;
	            var pattern= new RegExp("^[a-z]([a-z0-9])*[-_]?([a-z0-9]+)$","i");
				if(Value=="" || Value==null){
				  	document.getElementById("userWarming").innerHTML="<font color='red' size='2'>用户名不能为空</font>";
				  	return false;
				 }else if(Value.match(pattern)==null || Value.length<4){
					document.getElementById("userWarming").innerHTML="<font color='red' size='2'>用户名至少4个字符</font>";
					return false;
				}else{
				  document.getElementById("userWarming").innerHTML="";
				  return true;
				}
			}
			function checkLogin(){
	            var Value = document.getElementById("password").value;
	            var pattern=/^(\w){6,20}$/;
				if(Value=="" || Value==null){
				  	document.getElementById("passwordWarming").innerHTML="<font color='red' size='2'>密码不能为空</font>";
				  	return false;
				 }else if(Value.match(pattern)==null){
					document.getElementById("passwordWarming").innerHTML="<font color='red' size='2'>密码6-20位</font>";
					return false;
				}else{
				  document.getElementById("passwordWarming").innerHTML="";
				  return true;
				}
			}
			function checkCode(){
	            var Value = document.getElementById("code").value;
				if(Value=="" || Value==null){
				  	document.getElementById("codeWarming").innerHTML="<font color='red' size='2'>验证码不能为空</font>";
				  	return false;
				 }else{
				  document.getElementById("codeWarming").innerHTML="";
				  return true;
				}
			}
			function changeImg(obj){
				obj.src="${pageContext.request.contextPath}/code?time="+new Date().getTime();
			}
			function submit1(){
				return checkLogin() && checkLogin() && checkCode(); 
			}
		
</script>
</head>
<body>
	<form action="/news/servlet/UserServlet?type1=login" method="post"
		onsubmit="return submit1();" id="myForm" >
		<table border="0" cellspacing="0" cellpadding="0" width="550"
			height="300" cellpadding="20">
			<tr>

			</tr>
			<tr>
				<th colspan="2">用户登录</th>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><span
					style="color: red;font-size: 12px;">${loginInfo}</span></td>
			</tr>
			<tr>
				<td class="text_with">用户名 ：</td>
				<td><input type="text" name="name" id="user"
					onblur="checkUser()" /><span id="userWarming"></span>
				</td>
			</tr>
			<tr>
				<td class="text_with">密&nbsp;码 ：</td>
				<td><input type="password" name="password" id="password" onblur="checkLogin();"/>
					<span id="passwordWarming"></span>
				</td>
			</tr>
			<tr>
				<td class="text_with">验证码 ：</td>
				<td>
					<span>
						<input type="text" name="checkcode" id="code" onblur="checkCode()" >
					</span>
					<span>
						<img src="${pageContext.request.contextPath}/code" onclick="changeImg(this);"
							style="position: relative;z-index:9999;top:9px;left:10px; height: 28px"><br/>
					</span>
					<span id="codeWarming"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2"  id="login_buttom">
					<input type="submit" id="submit" value="登录" style="width: 55px; height: 35px; 
						letter-spacing: 8px;margin-left: 140px;position: relative;" 
							onclick="checkLogin(),checkLogin(),checkCode()"/>
					<%-- <a href="${pageContext.request.contextPath }/servlet/UserServlet?type1=modifyPwdCheck" 
						style="font-size: 12px;margin-left: 80px;text-decoration: none" target="_parent">
						修改密码
					</a> --%>
				</td>
			</tr>

		</table>
	</form>
</body>
</html>