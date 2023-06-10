<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
successfully logged in as a student...
<div style="float:right;"><form action="logout.jsp"><input type="submit" value="logout"></form></div> 

<%@page import="java.sql.*" %>

<%
String id=(String)session.getAttribute("id");
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement stmt=con.prepareStatement("select student_batch from student_login where student_id='"+id+"';");
	ResultSet rs=stmt.executeQuery();
	rs.next();
	String batch=rs.getString(1);
	session.setAttribute("batch",batch);
}
catch (Exception e)
{
	System.out.println(e);
}
%>



<h1 align=center>VIEW RESULTS</h1>
<div  align=center>
<form action="result_page.jsp" method=post>
<table border=1>
<tr>
<td>Year:</td>
<td><select name="year">
<option value="1">1st</option>
<option value="2">2nd</option>
<option value="3">3rd</option>
<option value="4">4th</option>
</select>
</td>
</tr>
<tr>
<td>exam:</td>
<td>
<select name="exam">
<option value="mid1">mid1</option>
<option value="mid2">mid2</option>
<option value="supply">supply</option>
<option value="sem">semister</option>
</select>
</td>
</tr>
</table>
<input type=submit>
</form>
</div>


</body>
</html>