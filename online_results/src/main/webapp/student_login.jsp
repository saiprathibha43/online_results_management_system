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

String id=request.getParameter("sid");
String pswd=request.getParameter("spswd");
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	Statement st=con.createStatement();
	PreparedStatement stmt=con.prepareStatement("select * from student_login");  

	ResultSet rs=stmt.executeQuery();
	int c=0;
	while(rs.next()) 
	{

		String m1=rs.getString(1);
		if(m1.equals(id))
		{
			c=1;
			String m2=rs.getString(2);
			if(m2.equals(pswd)){
				HttpSession s = request.getSession();
				s.setAttribute("id",id);
				s.setAttribute("pswd",pswd);
				response.sendRedirect("student_success_login.jsp");
			}
			
			else
			{
				%>
				<script type="text/javascript">
				alert("Wrong password.");
				window.location = 'index.html';
				</script>
				<% 
			}
		}
		if(c==0)
		{
			%>
			<script type="text/javascript">
			alert("Only Anurag Students can view their results.");
			window.location = 'index.html';
			</script>
			<% 
		}
	}
}
catch(Exception e)
{
	System.out.println(e);
}
%>

</body>
</html>