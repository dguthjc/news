<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>菜单</title>
<link href="${pageContext.request.contextPath}/css/left.css" rel="stylesheet" type="text/css"/>
<link rel="StyleSheet" href="${pageContext.request.contextPath}/css/dtree.css" type="text/css" />
</head>
<body>
	<table width="100" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="12"></td>
	  </tr>
	</table>
	<table width="100%" border="0">
  		<tr>
    		<td>
				<div class="dtree">
					<a href="javascript: d.openAll();">展开所有</a> | <a href="javascript: d.closeAll();">关闭所有</a>
					<script type="text/javascript" src="${pageContext.request.contextPath}/js/dtree.js"></script>
					<script type="text/javascript">
	
						d = new dTree('d');
						d.add('01',-1,'系统菜单树');
						d.add('0102','01','用户管理');
						d.add('010201','0102','条件浏览','${pageContext.request.contextPath}/manager/user/searchFramset.jsp','','content');
						d.add('010202','0102','账号审核','${pageContext.request.contextPath}/admin?type1=check&page=1&pageSize=2','','content');
						d.add('010203','0102','删除账号','${pageContext.request.contextPath}/admin?type1=delete&page=1&pageSize=2','','content');
						d.add('0104','01','新闻管理');
						d.add('010401','0104','条件浏览','${pageContext.request.contextPath}/manager/news/searchFramset.jsp','','content');
						d.add('010402','0104','新闻审核','${pageContext.request.contextPath}/admin?type1=checkNews&page=1&pageSize=17','','content');
						d.add('010403','0104','删除新闻','${pageContext.request.contextPath}/admin?type1=deleteNews&page=1&pageSize=17','','content');
						d.add('0105','01','评论管理');
						d.add('010501','0105','条件浏览','${pageContext.request.contextPath}/manager/comment/searchFramset.jsp','','content');
						d.add('0106','01','统计管理');
						d.add('010601','0106','统计管理','${pageContext.request.contextPath}/manager/statistic/searchFramset.jsp','','content');
						document.write(d);
		
					</script>
				</div>	
			</td>
  		</tr>
	</table>
</body>
</html>
