<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	background-color: rgb(39,130,150);
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

		function showTip(id,info){
			document.getElementById(id+"Warming").innerHTML="<font color='gray' size='2'>"+info+"</font>";
		}
		var submit=0;
		function checkLogin(id,info){
            var Value = document.getElementById(id).value;
            var pattern1=/^(\w){6,20}$/;
            var pattern2= new RegExp("^[a-z]([a-z0-9])*[-_]?([a-z0-9]+)$","i");
			if(Value==""){
			  	document.getElementById(id+"Warming").innerHTML="<font color='red' size='2'>"+info+"</font>";
			  	submit=0;
			  	return false;
			 }else if(id=="user" && (Value.match(pattern2)==null || Value.length<4)){
				document.getElementById(id+"Warming").innerHTML="<font color='red' size='2'>用户名至少4个字符</font>";
				submit=0;
				return false;
			}else if(id=="password" && Value.match(pattern1)==null){
				document.getElementById(id+"Warming").innerHTML="<font color='red' size='2'>密码6-20位</font>";
				submit=0;
				return false;
			}else{
			  document.getElementById(id+"Warming").innerHTML="";
			  submit=1;
			  return true;
			}
		}
		function submit1(){
			if(submit)
				return true;//提交
			else 
				return false;//阻止提交
		}
		
</script>
</head>
<body>
	<form action="/news/servlet/UserServlet?type1=managerLogin" method="post"
		onsubmit="return submit1()" >
		<table border="0" cellspacing="0" cellpadding="0" width="550"
			height="300" cellpadding="20">
			<tr>

			</tr>
			<tr>
				<th colspan="2">管理员登录</th>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;"><span
					style="color: red;">${loginInfo}</span></td>
			</tr>
			<tr>
				<td class="text_with">管理员姓名 ：</td>
				<td><input type="text" name="name" id="user"
					onfocus="showTip('user','用户名必填')"
					onblur="checkLogin('user','用户名不能为空!')" /><span id="userWarming"></span>
				</td>
			</tr>
			<tr>
				<td class="text_with">管理员密码 ：</td>
				<td><input type="password" name="password" id="password"
					onfocus="showTip('password','密码必填')"
					onblur="checkLogin('password','密码名不能为空!')" /><span
					id="passwordWarming"></span></td>
			</tr>
			<tr>
				<td colspan="2" id="login_buttom"><input type="submit"
					id="submit" value="进入系统"
					style="height: 30px; letter-spacing: 8px;"/></td>
			</tr>
			<tr></tr>

		</table>
	</form>
</body>
</html>