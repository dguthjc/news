<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<script type="text/javascript">
	
	  function checkAll1(obj){
	  	var checkboxs= document.getElementsByName("checkbox1");
	  	for (var i = 0; i < checkboxs.length; i++) 
	  		checkboxs[i].checked =obj.checked;	  
	  }
	
	  function deleteUsers(){
	  	var checkboxs= document.getElementsByName("checkbox1"); 
	  	var ids="";
	  	//拼接id为 ：1,2,
	   	for(i=0;i<checkboxs.length;i++){
        	if(checkboxs[i].checked == true)
            	ids+=checkboxs[i].value+",";            	
        }
		if(ids.length<1){
			alert("请选择至少一个需删除的元素！");
			return false;//阻止提交
		}
		ids=ids.substring(0,ids.length-1);//删除最后的逗号
		ids1=document.getElementById("ids"); 
	  	ids1.value=ids;
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
		#item4{width: 350px;height: 35px;font-size: 16px;text-align: center}
		#item5{width: 55px;height: 35px;font-size: 16px;text-align: center}
		#item6{width: 180px;height: 35px;font-size: 16px;text-align: center}
		#item7{width: 38px;height: 35px;font-size: 16px;text-align: center}
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
  	<form action="/news/admin?type1=deleteNews" id="myform" method="post">
  	 <table align="center" border='1' cellpadding="3" cellspacing="0"  style="margin-top: 30px;">
	    <tr bgcolor='#ccc'>
	      <td><input id="checkboxAll" type='checkbox' onchange="checkAll1(this);"></td>
	      <td><a href='javascript:void(0);' onclick="getOnePage('','newsId');">Id</a></td>
	      <td id="item2"><a href='javascript:void(0);' onclick="getOnePage('','type');">新闻类型</a></td>
	      <td id="item3"><a href='javascript:void(0);' onclick="getOnePage('','author');">作者</a></td>
	      <td id="item4">标题</td>
	      <td id="item5"><a href='javascript:void(0);' onclick="getOnePage('','status');">状态</a></td>
	      <td id="item6"><a href='javascript:void(0);' onclick="getOnePage('','publicdata');">申请日期</a></td>
	      <td id="item7">&nbsp;</td>
	    </tr>	    
	    <c:forEach items="${news}"  var="news">      
	   		<tr id="content">
	   			<td><input name="checkbox1"  type="checkbox" value="${news.newsId}"></td>
		   		<td><c:out value="${news.newsId}" /></td>     
		   		<td><c:out value="${news.type}" /> </td>	
		   		<td><c:out value="${news.author}" /></td>     
		   		<td style="margin-left: 2px;text-align: left;"><c:out value="${news.title}" /> </td>	
		   		<td><c:out value="${news.status}" /></td>  
		   		<td><c:out value="${news.publicdata}" /></td>
		   		<td><a href="/news/newsServlet?type1=details&newsId=${news.newsId}">查看</a></td>    
		   	</tr>
		</c:forEach> 	    
	</table>
	<div id="table2">
		 <table align="center" border='1' cellpadding="3"  cellspacing="5">     
		   	<tr>	
		   		<td style="border: none;">
		   			<input type="button"  value="删除所选项" onclick="deleteUsers();">
		   		</td>		
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
