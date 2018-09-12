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
		function findCommentByNewsId(newsId){
			//清理上一次显示的内容覆盖
			$("#showDivTab").html("");
			$("#shodDivOid").html("");
			$("#loading").css("display","block");
			
			
			//ajax异步访问数据
			$.post(
				"${pageContext.request.contextPath }/admin?type1=findCommentByNewsId",
				{"newsId":newsId},
				function(data){
					
					//隐藏加载图片
					$("#loading").css("display","none");
					var content = "<div><input id='checkboxAll' type='checkbox' onchange='checkAll1(this);'>全选</div>";
					for(var i=0;i<data.length;i++){
						content+="<div>"+
						"<div style='margin-top: 15px;'>"+
							"<span><input name='checkbox1'  type='checkbox' value='"+data[i].commentId+"'></span>"+
							"<span style='margin-left: 10px;'>"+
								"<img src='"+data[i].userhead+"' width='40' height='40' style='border-radius:40px'>"+
							"</span>"+
							"<span style='margin-left: 10px;position: relative;top:-15px;'>"+data[i].userName+"</span>"+
							"<span style='float: right;margin-right: 10px;position: relative;top:10px;'>"+data[i].commentData+"</span>"+
						"</div>"+
						"<div  style='margin-left: 30px;margin-top: 5px;'>"+data[i].content+"</div>"+
						"<hr style='margin-top: 5px;''>"+
					"</div>"
						
					}
					content+="<div style='float:left;margin-top:20px;margin-left:30px;'>"+
						"<input type='button'  value='删除所选项' onclick='deleteComment();'"+
						"style='height:25px;padding:1px 5px 5px 5px;border:none' id='deletebtn'></div>"+
						"<div style='margin-top:50px'>&nbsp;</div>";
					
					$("#showDivTab").html(content);
					
					//新闻编号
					$("#shodDivOid").html(newsId);
					$("#myform2").attr("action","/news/admin?type1=deleteComment&newsId="+newsId);
				
				},
				"json"
			);
		}
	  
	  function checkAll1(obj){
	  	var checkboxs= document.getElementsByName("checkbox1");
	  	for (var i = 0; i < checkboxs.length; i++) 
	  		checkboxs[i].checked =obj.checked;	  
	  }
	  function deleteComment(){
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
		ids2=document.getElementById("ids1"); 
	  	ids2.value=ids;
	  	//提交
    	document.getElementById('myform2').submit();
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
		#item7{width: 60px;height: 35px;font-size: 16px;text-align: center}
		#content td{text-align: center;font-size: 14px;}
		#table2 table{
			border: none;text-align: center;font-size: 14px;
		}
		td a{
			text-decoration: none;
		}
		body {
			
		}
		#deletebtn:hover{
			background-color: red;
		}
	</style>
  </head>
  <body>
  	<form action="/news/admin?type1=showPageInComment" id="myform" method="post">
  	 <table align="center" border='1' cellspacing="0" cellpadding="3" style="margin-top: 20px;margin: auto;
  	 	position: relative;top:20px;">
	    <tr bgcolor='#ccc'>
	      <td id="item1"><a href='javascript:void(0);' onclick="getOnePage('','newsId');">newsId</a></td>
	      <td id="item2"><a href='javascript:void(0);' onclick="getOnePage('','type');">类型</a></td>
	      <td id="item3"><a href='javascript:void(0);' onclick="getOnePage('','author');">作者</a></td>
	      <td id="item4">标题</td>
	        <td id="item7"><a href='javascript:void(0);' onclick="getOnePage('','commentnumber');">评论数</a></td>
	      <td id="item6"><a href='javascript:void(0);' onclick="getOnePage('','publicdata');">申请日期</a></td>
	      <td></td>
	    </tr>	    
	    <c:forEach items="${requestScope.news}"  var="news">      
	   		<tr id="content">
		   		<td style="height: 30px;"><c:out value="${news.newsId}" /></td>     
		   		<td><c:out value="${news.type}" /> </td>
		   		<td><c:out value="${news.author}"/></td>	
		   		<td style="margin-left: 2px;text-align: left;"><c:out value="${news.title}" /></td>     
		   		<td><c:out value="${news.commentnumber}"/></td>	
		   		<td><c:out value="${news.publicdata}" /></td>
		   		<td style="width: 80px;" >
		   			<input type="button" value="查看评论" class="clickedElement" onclick="findCommentByNewsId('${news.newsId }')"/>
				</td>  
		   	</tr>
		</c:forEach> 	    
	</table>
	<div id="table2">
		 <table align="center" border='1' cellpadding="3"  cellspacing="7"  style="margin-top: 20px;margin: auto;
  	 		position: relative;top:30px;">     
		   	<tr>			
				<c:if test="${requestScope.pageInformation.page > 1}">
					<td td style="height: 30px;"><a href="javascript:void(0);" onclick="getOnePage('first','');">首页</a></td>  
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
             <h2>新闻编号：<span id="shodDivOid" style="font-size: 13px;color: #999">123456789</span></h2>
             <a href="javascript:void(0);" id="closeBtn" class="closeBtn">关闭</a>
             <div id="loading" style="padding-top:30px;text-align: center;">
             	<img alt="" style="width:100px;height:100px;" src="${pageContext.request.contextPath }/img/loading.gif">
        	 </div>
			 <div style="padding:20px;">
			    <form action="" method="post" id="myform2">
			    	<div id="showDivTab" style="width:100%">
					
					</div>
					<input type="hidden" name="page" id="page" value="${requestScope.pageInformation.page}">
					<input type="hidden" name="pageSize" id="pageSize" value="${requestScope.pageInformation.pageSize}">
				 	<input type="hidden" name="totalPageCount" id="totalPageCount" value="${requestScope.pageInformation.totalPageCount}">
					<input type="hidden" name="allRecordCount" id="allRecordCount" value="${requestScope.pageInformation.allRecordCount}">
				 	<input type="hidden" name="orderField" id="orderField" value="${requestScope.pageInformation.orderField}">
					<input type="hidden" name="order" id="order" value="${requestScope.pageInformation.order}">
				 	<input type="hidden" name="ids" id="ids1" value="${requestScope.pageInformation.ids}">
					<input type="hidden" name="searchSql" id="searchSql" value="${requestScope.pageInformation.searchSql}">
				 	<input type="hidden" name="result" id="result" value="${requestScope.pageInformation.result}">
			    </form>
			 </div>
         </div>
         
     </div>
  
  </body>
</html>
