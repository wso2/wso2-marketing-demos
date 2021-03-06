<%@page import="org.wso2.appserver.samples.ToolPurchase"%>
<%@page import="org.wso2.appserver.samples.DBUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Tenant Database Demo</title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/styles.css" />	
</head>

<body>
	<%	
		int tenantID = (Integer) session.getAttribute("tenantID");
		String toolID = request.getParameter("toolID");
		if (toolID != null &&  toolID.trim().length() > 0) {
			DBUtils.putData(tenantID, toolID);					 	   				
		}
	%>
<h1>Multi-tenant Keyed Database Example</h1>
<h2>Make a tool purchase!</h2> 
	<form action="database.jsp">
		<table>
			<tr>
				<td>toolID</td>
				<td><input type="text" name="toolID" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" value="Purchase" /></td>
			</tr>
		</table>
	</form>

	<p>
	<b>List all Tools Purchased by the Tenant</b>
	<table border="1">
		<tr><th>TenantId</th><th>ToolID</th><th>Time</th></tr>
		<%
		ToolPurchase[] purchases = DBUtils.getData(tenantID);
		for (ToolPurchase purchase : purchases) {
		%>
		<tr>
			<td><%=purchase.getTenantID() %></td>
			<td><%=purchase.getToolID() %></td>
			<td><%=purchase.getTime() %></td>
		</tr>
		<%	}   %>
	</table>
	
		 <h2>Available Navigation Actions</h2> 
	<ul>
		<li><a href="../context/context.jsp">Set Context Values</a></li>
		<li><a href="../test/view.jsp">View current tenant identity and context values</a></li>
		<li><a href="../usermgt/usermgt.jsp">Manage Tenant's User Realm</a></li>
		<li><a href="../logout.jsp">Logout current user</a></li>
	</ul>
	
</body>
</html>