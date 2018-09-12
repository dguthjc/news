<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
	</script>  
	<style type="text/css">
	    #items a{
	    	color: black;
	    }
	    #items a:hover{
	    	color: red;
	    }
		#main{
			margin: auto;margin-left: 2%;margin-right: 2%;margin-top: 20px;
		}
		#items{
			padding-top: 10px;
		}
		#Newstitle{
			margin-left: 2%;text-align: left
		}
		#publicdata{
			margin-right:  2%;float: right;
		}
		#border{
			margin-left: 15px;margin-right: 15px;margin-bottom: 5px;margin-top:8px;border-top:1px dashed #BFBFBF;
		}
		td{
			width: 50px;
		}
		table{
			margin-top: 20px;border: none;text-align: center;
		}
		#head{
			margin-top: -16px;
		}
	</style>
  </head>
  
  <body>
  	<div id="head">
  		<jsp:include page="/head.jsp"></jsp:include>
  	</div>
  	<div id="main">
  		<form action="/news/newsVisible?type1=showPage" id="myform" method="post">
	  		<c:forEach items="${news}"  var="news">
	  			<div id="items">
	  				<span id="Newstitle">
	  					<a href="/news/newsVisible?type1=details&newsId=${news.newsId}" target="_blank">
			   				${news.title}
			   			</a>
	  				</span>
	  				<span id="publicdata">${news.publicdata}</span>
	  			</div>
	  			<div id="border"></div>
	  		</c:forEach>
		  	
			 <table align="center" border='1' cellspacing="8">     
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
  	</div>
  	<div style="margin-top: 40px;">
		<jsp:include page="/foot.jsp"></jsp:include>
  	</div>
  </body>
</html>
