<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@page import="java.sql.*" %>
<%
String id=(String)session.getAttribute("id");
String batch=(String)session.getAttribute("batch");
int year=Integer.parseInt(request.getParameter("year"));
String exam=request.getParameter("exam");
String name;
String y=(String)request.getParameter("year");
session.setAttribute("year",y);
session.setAttribute("exam",exam);
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement stmt=con.prepareStatement("select student_name from "+batch+" where student_id='"+id+"' ;");
	ResultSet r=stmt.executeQuery();
	r.next();
	name=r.getString(1);
	session.setAttribute("name",name);
}
catch(Exception e)
{
	System.out.println(e);
}
%>

<table align=center style="border-spacing:20px;">
<tr>
<td><b>NAME:</b></td>
<td><%=session.getAttribute("name") %></td>
<td><b>BATCH:</b></td>
<td><%=batch %></td>
</tr>
<tr>
<td><b>YEAR:</b></td>
<td><%=year %></td>
<td><b>EXAM:</b></td>
<td><%=exam %></td>
</tr>
<tr>
<td><b>ID:</b></td>
<td><%=id %></td>
</tr>
</table>


<%
if(exam.equals("mid1") || exam.equals("mid2"))
{
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
		PreparedStatement st=con.prepareStatement("select subject, marks from "+batch+" where student_id=? and year=? and exam=? ;");
		st.setString(1,id);
		st.setInt(2,year);
		st.setString(3,exam);
		ResultSet rs=st.executeQuery();	
		%>
		<table border=1 align=center>
		<tr>
		<th>subject</th>
		<th>marks/20</th>
		</tr>
		<%
		int sum=0,tot=0;
		while(rs.next())
		{
			%>
			<tr>
			<td><%=rs.getString(1)%></td>
			<%if(Integer.parseInt(rs.getString(2))==-1){%><td>NA</td><%}else{ %>
			<td><%=rs.getString(2)%></td><%} %>
			</tr>
			<%
			sum=sum+Integer.parseInt(rs.getString(2));
			tot=tot+20;
		}
		%>
		<tr>
		<td>total:</td>
		<td><%=sum %>/<%=tot %></td>
		</table>
		<%
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
}
%>



<%
if(exam.equals("supply"))
{
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
		PreparedStatement st=con.prepareStatement("select subject, marks from "+batch+" where student_id=? and year=? and exam=? ;");
		st.setString(1,id);
		st.setInt(2,year);
		st.setString(3,exam);
		ResultSet r=st.executeQuery();	
		%>
		<table border=1 align=center>
		<tr>
		<th>subject</th>
		<th>marks/60</th>
		</tr>
		<%
		int sum=0,tot=0;
		while(r.next())
		{
			%>
			<tr>
			<td><%=r.getString(1)%></td>
			<%if(Integer.parseInt(r.getString(2))==-1){%><td>NA</td><%}else{ %>
			<td><%=r.getString(2)%></td><%} %>
			</tr>
			<%
			if(Integer.parseInt(r.getString(2))==-1)
				sum=sum+0;
			else
				sum=sum+Integer.parseInt(r.getString(2));
			tot=tot+60;
		}
		%>
		<tr>
		<td>total:</td>
		<td><%=sum %>/<%=tot %></td>
		</table>
		<%
	}
	catch(Exception e)
	{
		System.out.println(e);
	}
}
%>
<%
if(exam.equals("sem"))
	response.sendRedirect("over.jsp");
%>





</body>
</html>