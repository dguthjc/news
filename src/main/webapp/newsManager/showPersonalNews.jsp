<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<script src="js/jquery-1.11.3.min.js" type="text/javascript"></script>
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<script type="text/javascript">
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
      	$(function () {
      		$("a[name='refuse']").prop("href","javascript:void(0)");
      		$("a[name='refuse']").css("color","gray"); 
      		$("a[name='pass']").css("color","#0000FF"); 
      	});

	</script>  
	<style type="text/css">
		#item1{width: 67px;height: 35px;font-size: 16px;text-align: center}
		#item2{width: 120px;height: 35px;font-size: 16px;text-align: center}
		#item3{width: 63px;height: 35px;font-size: 16px;text-align: center}
		#item4{width: 350px;height: 35px;font-size: 16px;text-align: center}
		#item5{width: 58px;height: 35px;font-size: 16px;text-align: center}
		#item6{width: 184px;height: 35px;font-size: 16px;text-align: center}
		#item7{font-size: 16px;text-align: center}
		#content td{text-align: center;font-size: 14px;}
		#table2 table{
			margin-top: 20px;border: none;text-align: center;font-size: 14px;
		}
		td a{
			text-decoration: none;
		}
	</style>
  </head>
  
  <body>
  	<form action="/news/newsServlet?type1=showPersonalPage&author=${user.name}" id="myform" method="post" style="margin-top: 20px;">
  	 <table align="center" border='1' cellspacing="0"  cellpadding="3" style="margin-top:10px;">
	    <tr bgcolor='#FFACAC'>
	      <tr bgcolor='#ccc'>
	      <td id="item1"><a href='javascript:void(0);' onclick="getOnePage('','newsId');">newsId</a></td>
	      <td id="item2"><a href='javascript:void(0);' onclick="getOnePage('','type');">类型</a></td>
	      <td id="item4">标题</td>
	      <td id="item3"><a href='javascript:void(0);' onclick="getOnePage('','commentnumber');">评论数</a></td>
	      <td id="item5"><a href='javascript:void(0);' onclick="getOnePage('','status');">状态</a></td>
	      <td id="item6"><a href='javascript:void(0);' onclick="getOnePage('','publicdata');">申请日期</a></td>
	      <td id="item7" colspan="2"><a href='javascript:void(0);' onclick="getOnePage('','status');">可编辑性</a></td>
	    </tr>	
	    <c:forEach items="${requestScope.news}"  var="news">      
	   		<tr id="content">
		   		<td><c:out value="${news.newsId}" /></td>     
		   		<td><c:out value="${news.type}" /> </td>
		   		<td style="margin-left: 2px;text-align: left;"><c:out value="${news.title}" /></td>     
		   		<td><c:out value="${news.commentnumber}"/></td>	
		   		<td><c:out value="${news.status}" /> </td>	
		   		<td><c:out value="${news.publicdata}" /></td>
		   		<td style="width: 38px;"><a href="/news/newsServlet?type1=details&newsId=${news.newsId}">查看</a></td>  
		   		<td style="width: 38px;"><a id="ismodify" href="/news/newsServlet?type1=beforeModifyNews&newsId=${news.newsId}" name="${news.status }">修改</a></td>  
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
