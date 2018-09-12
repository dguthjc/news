<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'addNews.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.config.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/ueditor.all.min.js'	type="text/javascript"></script>
	<script src='/news/plugin/ueditor1_4_3_3-utf8-jsp/lang/zh-cn/zh-cn.js'	type="text/javascript"></script>  
  </head>
  <style>
  	html { overflow-x:hidden; }
  	body{
  		margin: 0;
  	}
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
  <body>
  <div style="margin-top: 20px;margin-left: 8%">
  	<form action="${pageContext.request.contextPath}/newsServlet?type1=addNews" method="post" enctype="multipart/form-data" onsubmit="return submit1()">
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
				<td>
					<textarea  style="margin-top: 15px;" rows="3" cols="40" name="title" id="title" onblur="checkTitle()" style="resize: none;" placeholder="标题最多25字"></textarea>
					<span id="titlespan"></span>
				</td>	
			</tr>
    		<tr>
    			<td align="right">详细内容：</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td>
    				<div>
 						<script id="container" type="text/plain" style="width:800px;height:500px;">

						</script>
					</div>
					<div id="contentdiv"></div>		
    			</td>
    		</tr>
    		<tr>
    			<td></td>
    			<td style="position: relative;left: 725px;">
    				<input type="submit" value="申请发布" onclick="checkTitle()" style="margin-top: 15px;">
    			</td>
    		</tr>
    	</table>
    </form>
    </div>
  </body>
  <script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('container');
  </script>
</html>
