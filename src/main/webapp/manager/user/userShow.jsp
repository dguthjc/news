<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<!-- 弹出层插件 -->
	<link href="${pageContext.request.contextPath}/css/popup_layer.css" type="text/css" rel="stylesheet"/>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/popup_layer.js"></script>
  
	<script type="text/javascript">
	  
		$(function(){
			//弹出层插件调用
			new PopupLayer({
				trigger:".clickedElement",//触发点 点击谁弹出div
				popupBlk:"#showDiv",//弹出哪个div
				closeBtn:"#closeBtn",//关闭按钮
				useOverlay:true
			});
				
		});
	    //点击按钮查询某个订单的详情
	    function ajaxFindUserDetails(userId){
			//清理上一次显示的内容覆盖
			$("#showDivTab").html("");
			$("#shodDivOid").html("");
			$("#loading").css("display","block");
			
			
			//ajax异步访问数据
			$.post(
				"${pageContext.request.contextPath}/admin?type1=ajaxFindUserDetails",
				{"userId":userId},
				function(data){
					var content="";
					//隐藏加载图片
					$("#loading").css("display","none");
						content+="<div>"+
						"<div style='margin-top: 15px;'>"+
							"<span style='margin-left: 10px;'>"+
								"<img src='"+data.headimg+"' width='50' height='50'>"+
							"</span>"+
						"</div>"+
						"<div style='margin-top: 15px;'>"+
							"<span>姓名：</span><span style='margin-left: 10px;'>"+data.name+"</span>"+
						"</div>"+
							"<div style='margin-top: 15px;'>"+
							"<span>注册日期：</span><span style='margin-left: 10px;'>"+data.registerDate+"</span>"+
						"</div>"+
						"<div style='margin-top: 15px;'>"+
							"<span>用户类型：</span><span style='margin-left: 10px;'>"+data.type+"</span>"+
						"</div>"+
						"<div style='margin-top: 15px;'>"+
							"<span>可用状态：</span><span style='margin-left: 10px;'>"+data.enable+"</span>"+
						"</div>"+
						"<div style='margin-top: 15px;'>"+
							"<span>性别：</span><span style='margin-left: 10px;'>"+data.sex+"</span>"+
						"</div>"+
						"<div style='margin-top: 15px;'>"+
							"<span>爱好：</span><span style='margin-left: 10px;'>"+data.hobby+"</span>"+
						"</div>"+
					"</div>"
					
					$("#showDivTab").html(content);
					
					//用户编号
					$("#shodDivOid").html(userId);
				
				},
				"json"
			);
		}	
	
      function getOnePage(type,orderFieldName){
    	  	var url1;
    	  	var page=document.getElementById("page");
    	  	var pageSize=document.getElementById("pageSize");
    	  	var totalPageCount=document.getElementById("totalPageCount");
    	  	
  			var order=document.getElementById("order");
  			var orderField=document.getElementById("orderField");
			
			if(orderFieldName!=""){//切换排序
				orderField.value=orderFieldName;//设置排序字段名
				if(order.value == "asc")//切换排序
					order.value="desc";
				else
					order.value="asc";	
					
				page.value=1;//排序后从第一页开始显示												
			}
			
    	  	pageValue=parseInt(page.value);
    	  	if(type=="first")
    	  		page.value="1";
    	  	else if(type=="pre"){
    	  		pageValue-=1;
    	  		page.value=pageValue.toString();
    	  	}else if(type=="next"){
    	  		pageValue+=1;
    	  		page.value=pageValue.toString();
    	  	}else if(type=="last"){
    	  		page.value=totalPageCount.value;
    	  	}
    	  	//提交
    	  	document.getElementById('myform').submit();
      	}
	</script>  
	<style type="text/css">
		#item1{width: 63px;font-size: 16px;text-align: center}
		#item2{width: 110px;font-size: 16px;text-align: center}
		#item3{width: 100px;font-size: 16px;text-align: center}
		#item4{width: 250px;font-size: 16px;text-align: center}
		#item5{width: 155px;font-size: 16px;text-align: center}
		#item6{width: 90px;font-size: 16px;text-align: center}
		#item7{width: 58px;font-size: 16px;text-align: center}
		#content td{text-align: center;font-size: 14px;}
		#table2 table{
			margin-top: 10px;border: none;text-align: center;font-size: 14px;
		}
		td a{
			text-decoration: none;
		}
		body {
			
		}
	</style>
  </head>
  
  <body>
  	<form action="/news/admin?type1=showPage" id="myform" method="post">
  	 <table align="center" border='1' cellpadding="3" cellspacing="0" style="margin-top: 10px;margin-left: 15%">
	    <tr bgcolor='#ccc'>
	      <td id="item1"><a href='javascript:void(0);' onclick="getOnePage('','userId');">userId</a></td>
	      <td id="item2">用户类型</td>
	      <td id="item6">头像</td>
	      <td id="item3">用户名</td>
	      <td id="item4">注册日期</td>
	      <td id="item5">帐号可用性</td>
	       <td id="item7">&nbsp;</td>
	    </tr>	    
	    <c:forEach items="${requestScope.users}"  var="user">      
	   		<tr id="content">
		   		<td><c:out value="${user.userId}" /></td>     
		   		<td><c:out value="${user.type}" /> </td>
		   		<td>
		   			<img src="${user.headimg}" width="70px" height="70" style="margin: auto;"/>
		   		</td>	
		   		<td><c:out value="${user.name}" /></td>     
		   		<td><c:out value="${user.registerDate}" /> </td>	
		   		<td><c:out value="${user.enable}" /></td> 
		   		<td>
		   			<a class="clickedElement" href="javascript:void(0);" target="content_main" onclick="ajaxFindUserDetails('${user.userId}')">详情</a>
		   		</td>    
		   	</tr>
		</c:forEach> 	    
	</table>
	<div id="table2">
		<table align="center" border='1' cellpadding="3"  cellspacing="5" style="margin-left: 45%"> 
	   	<tr>			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('first','');">首页</a></td>  
			</c:if>
			
			<c:if test="${requestScope.pageInformation.page > 1}">
				<td><a href="javascript:void(0);" onclick="getOnePage('pre','');">上一页</a></td>  
			</c:if>			 
			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('next','');">下一页</a></td>
			</c:if>	  			
			<c:if test="${requestScope.pageInformation.page < requestScope.pageInformation.totalPageCount}">
				<td><a href="javascript:void(0);" onclick="getOnePage('last','');">尾页</a></td>
			</c:if>	
			<td>共${requestScope.pageInformation.totalPageCount}页</td>   		
		</tr>    
	 </table>
	 </div>
 	<input type="hidden" name="page" id="page" value="${requestScope.pageInformation.page}">
	<input type="hidden" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
 	<input type="hidden" name="totalPageCount" id="totalPageCount" value="${requestScope.pageInformation.totalPageCount}">
	<input type="hidden" name="allRecordCount" id="allRecordCount" value="${requestScope.pageInformation.allRecordCount}">
 	<input type="hidden" name="orderField" id="orderField" value="${requestScope.pageInformation.orderField}">
	<input type="hidden" name="order" id="order" value="${requestScope.pageInformation.order}">
 	<input type="hidden" name="ids" id="ids" value="${requestScope.pageInformation.ids}">
	<input type="hidden" name="searchSql" id="searchSql" value="${requestScope.pageInformation.searchSql}">
 	<input type="hidden" name="result" id="result" value="${requestScope.pageInformation.result}">
  </form>
  <!-- 弹出层  -->
     <div id="showDiv" class="blk" style="display:none;">
         <div class="main" style="height: 350px;">
             <h2>用户编号：<span id="shodDivOid" style="font-size: 13px;color: #999">123456789</span></h2>
             <a href="javascript:void(0);" id="closeBtn" class="closeBtn">关闭</a>
             <div id="loading" style="padding-top:30px;text-align: center;">
             	<img alt="" style="width:100px;height:100px;" src="${pageContext.request.contextPath }/img/loading.gif">
        	 </div>
			 <div style="padding:20px;">
			    <form action="" method="post" id="myform2">
			    	<div id="showDivTab" style="width:100%">
					
					</div>
			    </form>
			 </div>
         </div>
         
     </div>
  </body>
</html>
