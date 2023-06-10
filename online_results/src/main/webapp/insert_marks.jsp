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
String id=request.getParameter("studentid");
String name=request.getParameter("studentname");
String subject=request.getParameter("subject");
int marks=Integer.parseInt(request.getParameter("marks"));
String duration=request.getParameter("batch");
String year=request.getParameter("year");
String exam=request.getParameter("exam");
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
	PreparedStatement s=con.prepareStatement("insert into "+duration+" values (?,?,?,?,?,?,NULL);");
	s.setString(1,id);
	s.setString(2,name);
	s.setString(3,year);
	s.setString(4,exam);
	s.setString(5,subject);
	s.setInt(6,marks);
	s.executeUpdate();	
	
	
	
	try{
	PreparedStatement check=con.prepareStatement("select student_id from student_login where student_id=? ;");
	check.setString(1,id);
	ResultSet k=check.executeQuery();
	PreparedStatement st=con.prepareStatement("insert into student_login values(?,?,?);");
	st.setString(1,id);
	st.setString(2,id);
	st.setString(3,duration);
	st.executeUpdate();
	}
	catch(java.sql.SQLIntegrityConstraintViolationException e)
	{
		//already exists
	}
	
	
	
	
	
	
}
catch(Exception e)
{
	System.out.println(e);
}
%>
<h2>Results record</h2>
<table border=1>
<tr>
<th>Student Id</th>
<th>Student name</th>
<th>Subject</th>
<th>Marks</th>
</tr>
<%
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement stmt3=con.prepareStatement("select * from "+duration+" where year=? and exam=? order by student_name ;");
	stmt3.setString(1,year);
	stmt3.setString(2,exam);
	ResultSet rs=stmt3.executeQuery();
	while(rs.next())
	{
		%>
		<tr>
		<td><%=rs.getString(1) %></td>
		<td><%=rs.getString(2) %></td>
		<td><%=rs.getString(5) %></td>
		<td><%=rs.getInt(6) %></td>
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