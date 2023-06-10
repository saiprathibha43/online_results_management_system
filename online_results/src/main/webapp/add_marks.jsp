<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%

String duration=request.getParameter("duration");
String year=request.getParameter("year");
String exam=request.getParameter("exam");


try
{
	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement stmt=con.prepareStatement("select * from batch");  
	ResultSet rs=stmt.executeQuery();
	int c=0;
	while(rs.next()) 
	{

		String m1=rs.getString(1);
		if(m1.equals(duration))
		{
			c=1;
		}
		
	}
	if(c==0)
	{
		%>
		<script type="text/javascript">
		alert("No batch exists. Try adding the new batch.");
		window.location = 'teacher_success_login.jsp';
		</script>
		<% 
	}
}
catch(Exception e)
{
	System.out.println(e);
}

out.println("Fill the following details to enter marks for batch "+duration+" year "+year+" for the "+exam+" exam. Put -1 in marks in case of absent");
	
%>

<div style="float:right;"><form action="teacher_success_login.jsp"><input type="submit" value="home page"></form></div>
<h1 align=center><%=duration %> - year<%=year %> - <%=exam %></h1>


<h2>enter new marks:</h2>
<form action="insert_marks.jsp">

<table>
<tr>
<td>batch</td>
<td><input name="batch" value="<%=duration %>" onBlur="this.value=this.value==''
         ? 'default' 
         : this.value;" /></td>
</tr>
<tr>
<td>year</td>
<td><input name="year" value="<%=year %>" onBlur="this.value=this.value==''
         ? 'default' 
         : this.value;" /></td>
</tr>
<tr>
<td>exam</td>
<td><input name="exam" value="<%=exam %>" onBlur="this.value=this.value==''
         ? 'default' 
         : this.value;" /></td>
</tr>
<tr>
<td>student id:</td>
<td><input type="text" name="studentid"></td>
</tr>
<tr>
<td>student name</td>
<td><input type="text" name="studentname"></td>
</tr>
<tr>
<td>Subject</td>
<td><input type="text" name="subject"></td>
</tr>
<tr>
<td>Marks</td>
<td><input type="number" name="marks"></td>
</tr>
</table>
<input type="submit" value="insert">
</form>



<%
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement stmt3=con.prepareStatement("select student_id,student_name,subject,marks from "+duration+" where exam='"+exam+"' and year="+year+" order by student_name;");
	ResultSet rs=stmt3.executeQuery();
	%>
	<h2>Existing Details</h2>
	<table border=1>
	<tr>
	<th>Student Id</th>
	<th>Student name</th>
	<th>Subject</th>
	<th>Marks</th>
	</tr>
	<% 
	
	while(rs.next())
	{
		%>
		<tr>
		<td><%=rs.getString(1) %></td>
		<td><%=rs.getString(2) %></td>
		<td><%=rs.getString(3) %></td>
		<td><%=rs.getInt(4) %></td>
		</tr>
		<%
	}
	%></table><%
}
catch(Exception e)
{
	System.out.println(e);
}


%>


</body>
</html>