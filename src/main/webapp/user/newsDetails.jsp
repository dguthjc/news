<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'addNews.jsp' starting page</title>
	<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<!-- <meta http-equiv="refresh" content="30"> -->
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript">
	
		var count="show";
		var a,b;
		window.onload = function(){
			if(${update==1})
				alert("评论修改成功！");
     		
     		if(${update==0})
     		    alert("很抱歉，评论提交5分钟后不能修改！");
     		 
  		}; 
		var modifyId1=null;
		var modifyId2=null;
		var tip=null;var x,y,z,c,co;
		function modifyComment(content2,id1,id2,id3,vs){
			modifyId1=id1;
			modifyId2=id2;
			tip=id3;co=content2;
			var dis=document.getElementById(modifyId2);
			if(count=="show"){
				dis.style.display="block";
				count="close";
				a=vs;x=modifyId1,y=modifyId2,z=tip;c=co;
			}else{
				b=vs;
				if(a!=b){
					modifyId1=x;modifyId2=y;tip=z;co=c;
					alert("请先关闭其他修改框");
				}else{
					dis.style.display="none";
					count="show";modifyId1=x;modifyId2=y;tip=z;co=c;
				}
			}
			document.getElementById(modifyId1).value=co;
		}
		function inputContent(){
			var val=document.getElementById("contents").value;
			if(val=="" || val==null){
				document.getElementById("tip").innerHTML="*不能提交空评论";
				document.getElementById("tip").style.color="red";
				return false;
			}else if(val.length>100){
				document.getElementById("tip").innerHTML="*字数太多";
				document.getElementById("tip").style.color="red";
				return false;
			}
			else return true;
		}
		function submit1(){
			var result=inputContent();
			if(result) return true;
			else return false;
		}
		var result2=false;
		function inputContent2(content){
			var val=document.getElementById(modifyId1).value;
			if(val=="" || val==null){
				document.getElementById(tip).innerHTML="*不能提交空评论";
				document.getElementById(tip).style.color="red";
				result2=false;
			}else if(val.length>100){
				document.getElementById(tip).innerHTML="*字数太多";
				document.getElementById(tip).style.color="red";
				result2=false;
			}else if(val==content){
				document.getElementById(tip).innerHTML="*内容未修改";
				document.getElementById(tip).style.color="red";
				result2=false;
			}else{
				 result2=true;
			}
		}
		function submit2(){
			return result2;
		}
	</script>
	<style type="text/css">
		body{
			font-family: "微软雅黑";width: 1152px;margin: auto;
		}
	</style>
  </head>
  <body>
  	<div id="head">
  		<jsp:include page="/head.jsp"></jsp:include>
  	</div>
  	<div style="width: 960px;margin: 0 auto;text-align: left;">
    	<div>
			<div style="text-align: center"><h2>${news.title}</h2></div>
    	</div>
    	<div style="width: 960px;">
    		<div>
    			${news.content}
    		</div>
    		<div style="text-align: left;margin-bottom: 20px">编译   ${news.author}</div>
    	
    		<hr style="width: 960px;margin: center">
    		<div style="width: 960px;margin: center;">
    			<div align="left" ><h3>用户评论</h3></div>
    			<div style="border-top: #BFBFBF 0.5px dashed; overflow: hidden; height: 0.5px"></div>
				<c:forEach items="${comments}" var="items" varStatus="vs">
					<div style="margin-bottom: 14px;margin-top: 14px;position: relative;">
						<span><img alt="" src="${items.userhead}" width="40" height="40" style="border-radius: 40px"></span>
						<span style="text-indent: 1em;font-weight: 600;position: absolute;top:10px;">${items.userName}</span>
						<span style="text-align: right;margin-left: 730px;position: absolute;top:10px;">${items.commentData}</span>
					</div>
					<div style="text-indent: 4em;margin-bottom: 14px;width: ">${items.content}</div>
					<c:if test="${items.modifyAvalible=='yes' && items.userName==user.name}">
						<div align="right">
							<button onclick="modifyComment('${items.content}','${items.commentId}','id_${items.commentId}','iid_${items.commentId}','${vs.count}')">修改</button>
						</div>
						<div style="text-indent: 4em;margin-bottom: 14px;color: red">
							<form action="${pageContext.request.contextPath}/commentServlet?type1=modifyComment&
								commentData=${items.commentData}&newsId=${news.newsId}&commentId=${items.commentId}"
								 method="post" onsubmit="return submit2()">
								<div id="id_${items.commentId}" style="display: none" >
									<textarea rows="3" cols="108" name="modifyContent" id="${items.commentId}" placeholder="最多可评论100字" style="resize: none;"></textarea>
									<div id="iid_${items.commentId}"></div>
									<div style="margin-left: 850px;margin-top: 10px;">
										<input type="submit" value="提交"  onclick="inputContent2('${items.content}')">
									</div>
								</div>
							</form>
						</div>
					</c:if>
					<div style="border-top: #BFBFBF 0.5px dashed; overflow: hidden; height: 0.5px"></div>
				</c:forEach>
			</div>
		</div>
		
		<form action="${pageContext.request.contextPath}/commentServlet?type1=addComment&newsId=${news.newsId}" 
			method="post" onsubmit="return submit1()">
			<div style="margin-top: 70px;margin-bottom: 100px;">
				<div style="text-indent: 0em;margin-bottom: 10px;">我来说两句</div>
				<div style="text-indent: 0em">
					<textarea rows="4" cols="116" name="content" id="contents" placeholder="最多可评论100字" style="resize: none;"></textarea>
				</div>
				<div id="tip"></div>
				<div style="margin-left: 918px;margin-top: 15px;">
					<input type="submit" value="分享" id="submit" onclick="inputContent()">
				</div>
			</div>
    	</form>
    </div>
    <div>
		<jsp:include page="/foot.jsp"></jsp:include>
	</div>
  </body>
</html>
