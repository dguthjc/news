<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
	<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
    <title>My JSP 'addNews.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.config.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.all.min.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/lang/zh-cn/zh-cn.js'	type="text/javascript"></script> 
	<style>
		html { overflow-x:hidden; }
		
	</style>
	<script type="text/javascript">
  	var result=false;
  	function checkTitle(){
  		var str=document.getElementById("title").value;
  		if(str.length>25){
  			document.getElementById("titlespan").innerHTML="*字数太多";
  			document.getElementById("titlespan").style.color="red";
  			result=false;
  		}else if(str==null || str==""){
  			document.getElementById("titlespan").innerHTML="*标题不能为空";
  			document.getElementById("titlespan").style.color="red";
  			result=false;
  		}else{
  			document.getElementById("titlespan").innerHTML="ok";
  			document.getElementById("titlespan").style.color="green";
  			result=true;
  		}
	  	}
	  	function submit1(){
	  		return result;
	  	}
  </script>
  </head>
  <body>
  <div style="margin-top: 20px;margin-left: 8%">
  	<form action="${pageContext.request.contextPath}/newsServlet?type1=modifyMyNews&newsId=${news.newsId}"
  		 method="post" enctype="multipart/form-data" onsubmit="return submit1()">
    	<table>
    		<tr>
				<td align="right">新闻类型：</td>
				<td>
					<select name="type" id="typeOption">
						<option value="military">军事</option>
						<option value="economics">财经</option>
						<option value="sports">体育</option>
						<option value="education">教育</option>
						<option value="charity">慈善</option>
						<option value="entertainment">娱乐</option>
					</select>
				</td>
			</tr>	
    		<tr>
				<td align="right">标题：</td>
				<td><textarea id="title" rows="3" cols="40" name="title" onblur="checkTitle()" style="resize: none; margin-top: 20px;"></textarea>
				<span id="titlespan"></span></td>
			</tr>
    		<tr>
    			<td align="right">详细内容：</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td>
    				<div>
 						<script id="container" type="text/plain" style="width:800px;height:500px;">${news.content}</script>
					</div>		
    			</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td style="position: relative;left: 715px;">
    				<input type="submit" value="提交修改" onclick="checkTitle()" style="margin-top: 20px;">
    			</td>
    		</tr>
    	</table>
    </form>
    </div>
  </body>
  <script type="text/javascript">
   
   		window.onload = function(){
     		 var ue = UE.getEditor('container');
     		 $("#typeOption option[value='${news.type }']").prop("selected",true);
			 $("#title").val("${news.title}");
  		};
  		
  </script>
</html>
