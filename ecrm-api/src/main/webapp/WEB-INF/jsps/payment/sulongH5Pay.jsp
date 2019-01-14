<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>

<%
//////////////////////////////////// 请求参数 //////////////////////////////////////
		
	// 接收表单提交参数
		request.setCharacterEncoding("UTF-8");			
		String merchant_code = request.getParameter("merchant_code");	
		String service_type = request.getParameter("service_type");
		String interface_version = request.getParameter("interface_version");		
		String input_charset = request.getParameter("input_charset");				
		String notify_url = request.getParameter("notify_url");
		String sign_type = request.getParameter("sign_type");		
		String sign = request.getParameter("sign");		
		String order_no = request.getParameter("order_no");		
		String order_time = request.getParameter("order_time");		
		String order_amount = request.getParameter("order_amount");		
		String product_name = request.getParameter("product_name");		
		String return_url = request.getParameter("return_url");
		String bank_code = request.getParameter("bank_code");		
		String redo_flag = request.getParameter("redo_flag");
		String product_code = request.getParameter("product_code");
		String product_num = request.getParameter("product_num");
		String product_desc = request.getParameter("product_desc");
		String pay_type = request.getParameter("pay_type");
		String client_ip = request.getParameter("client_ip");
		String extend_param = request.getParameter("extend_param");
		String extra_return_param = request.getParameter("extra_return_param");
		String show_url = request.getParameter("show_url");		
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
</head>
<body onLoad="document.dinpayForm.submit();">
  <form name="dinpayForm" method="post" action="https://pay.islpay.com/gateway?input_charset=<%=input_charset%>" >
	<input type="hidden" name="sign" value="<%=sign%>" />
	<input type="hidden" name="merchant_code" value="<%=merchant_code%>" />
	<input type="hidden" name="service_type" value="<%=service_type%>" />	
	<input type="hidden" name="interface_version" value="<%=interface_version%>" />			
	<input type="hidden" name="input_charset" value="<%=input_charset%>" />	
	<input type="hidden" name="notify_url" value="<%=notify_url%>"/>
	<input type="hidden" name="sign_type" value="<%=sign_type%>" />		
	<input type="hidden" name="order_no" value="<%=order_no%>"/>
	<input type="hidden" name="order_time" value="<%=order_time%>" />	
	<input type="hidden" name="order_amount" value="<%=order_amount%>"/>
	<input type="hidden" name="product_name" value="<%=product_name%>" />	
	<input type="hidden" name="return_url" value="<%=return_url%>"/>	
	<input type="hidden" name="bank_code" value="<%=bank_code%>" />	
	<input type="hidden" name="redo_flag" value="<%=redo_flag%>"/>
	<input type="hidden" name="product_code" value="<%=product_code%>"/>
	<input type="hidden" name="product_num" value="<%=product_num%>"/>
	<input type="hidden" name="product_desc" value="<%=product_desc%>"/>
	<input type="hidden" name="pay_type" value="<%=pay_type%>"/>
	<input type="hidden" name="client_ip" value="<%=client_ip%>"/>
	<input type="hidden" name="extend_param" value="<%=extend_param%>"/>
	<input type="hidden" name="extra_return_param" value="<%=extra_return_param%>"/>
	<input type="hidden" name="show_url" value="<%=show_url%>"/>
  </form>
</body>
</html>
