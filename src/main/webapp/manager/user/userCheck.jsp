<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<script type="text/javascript">
	
	  function checkAUser(userId){
	  	var ids=document.getElementById("ids");
	  	ids.value=userId;
   	  	//提交
   	  	document.getElementById('myform').submit();	  		  	
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
		#item1{width: 63px;height: 35px;font-size: 16px;text-align: center}
		#item2{width: 110px;height: 35px;font-size: 16px;text-align: center}
		#item3{width: 100px;height: 35px;font-size: 16px;text-align: center}
		#item4{width: 250px;height: 35px;font-size: 16px;text-align: center}
		#item5{width: 155px;height: 35px;font-size: 16px;text-align: center}
		#item6{width: 150px;height: 35px;font-size: 16px;text-align: center}
		#item7{width: 58px;height: 35px;font-size: 16px;text-align: center}
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
  	<form action="/news/admin?type1=check" id="myform" method="post">
  	 <table align="center" border='1' cellpadding="3" cellspacing="0"  style="margin-top: 30px;">
	    <tr bgcolor='#ccc'>
	      <td id="item1"><a href='javascript:void(0);' onclick="getOnePage('','userId');">userId</a></td>
	      <td id="item2">用户类型</td>
	      <td id="item3">用户名</td>
	      <td id="item4"><a href='javascript:void(0);' onclick="getOnePage('','registerDate');">注册日期</a></td>
	      <td id="item5"><a href='javascript:void(0);' onclick="getOnePage('','enable');">帐号可用性</a></td>
	      <td id="item6"><a href='javascript:void(0);' onclick="getOnePage('','enable');">切换帐号可用性</a></td>
	      <td id="item7">&nbsp;</td>
	    </tr>	    
	    <c:forEach items="${requestScope.users}"  var="user">      
	   		<tr id="content">
		   		<td><c:out value="${user.userId}" /></td>     
		   		<td><c:out value="${user.type}" /> </td>	
		   		<td><c:out value="${user.name}" /></td>     
		   		<td><c:out value="${user.registerDate}" /> </td>	
		   		<td><c:out value="${user.enable}" /></td>  
		   		<td>
					<c:choose>
					    <c:when test="${user.enable == 'use'}">
					        <a href="javascript:void(0);" onclick="checkAUser('${user.userId}');">停用</a> 
					    </c:when>
					    <c:when test="${user.enable == 'stop'}">
					        <a href="javascript:void(0);" onclick="checkAUser('${user.userId}');">启用</a>
					    </c:when>
					</c:choose>
		   		 </td>     
		   		 <td><a href="/news/manager/user/userDetails.jsp" target="_blank">详情</a></td>
		   	</tr>
		</c:forEach> 	    
	</table>
	<div id="table2">
		<table align="center" border='1' cellpadding="3"  cellspacing="5">   
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
  </body>
</html>
