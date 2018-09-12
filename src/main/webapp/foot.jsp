<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'foot.jsp' starting page</title>
  </head>
  <style>
  	.foot1{
  		margin-top:20px;
  		height:25px;
		border-top: 1px solid #E5E5E5;
		border-bottom: 1px solid #E5E5E5;
	    border-left:  1px solid #E5E5E5;
	    border-right:  1px solid #E5E5E5;
	    background-color:#E5E5E5;
	  	padding-top: 5px;
	  	text-align: center;
  	}
  	.span1{
  		font-size: 13px;color:#4D4D4D
  	}
  	.border{
  		border-right: 1px dashed #7F7F7F;margin-left: 15px;margin-right: 15px;
  	}
  	.foot2{
  		font-size: 12px;color:#4D4D4D;text-align: center;margin-top: 15px;
  	}
  	.foot3{
  		font-size: 12px;color:#4D4D4D;text-align: center;margin-top: 5px;
  	}
  	#footImg{
  		margin-top: 15px;
  	}
  </style>
  <body>
    <div>
	    <div class="foot1">
			<a href="#"><span class="span1">军事</span></a>
			<span class="border"></span>
			<a href=""><span class="span1">财经</span></a>
			<span class="border"></span>
			<a href=""><span class="span1">体育</span></a>
			<span class="border"></span>
			<a href=""><span class="span1">教育</span></a>
			<span class="border"></span>
			<a href=""><span class="span1">娱乐</span></a>
			<span class="border"></span>
			<c:if test="${empty user }"><a href=""><span class="span1">登录</span></a>
				<span class="border"></span>
			</c:if>
			<a href=""><span class="span1">注册</span></a>
			<span class="border"></span>
			<c:if test="${!empty user }"><a href=""><span class="span1">注销</span></a></c:if>
		</div>
		<div class="foot2">Copyright ©1996-2018 SINA Corporation, All Rights Reserved</div>
		<div class="clear"></div>
		<div id="footImg">
			<span><img src="/news/img/foot/footer_logo01.gif" width="124" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo02.gif" width="123" height="55"/></span>
			<span><img src="/news/img/foot/12377logo.png"  width="124" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo04.gif" width="124" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo05.gif" width="123" height="55"/></span>
			<span><img src="/news/img/foot/creditchina.gif" width="124" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo07.gif" width="123" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo09.gif" width="123" height="55"/></span>
			<span><img src="/news/img/foot/footer_logo10_1.gif" width="124" height="55"/></span>
		</div>
		<div class="foot2">隐私保护　xxxx公司　版权所有@201641404142</div>
		<div class="foot3">客户服务热线：15625738672　违法和不良信息举报电话：15625738672　qq@2248005433@qq.com</div>
	</div>
  </body>
</html>
