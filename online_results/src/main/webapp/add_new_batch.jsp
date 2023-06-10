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
try
{
	Class.forName("com.mysql.cj.jdbc.Driver");

	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	Statement st=con.createStatement();
	PreparedStatement stmt=con.prepareStatement("insert into batch values (?)");
	stmt.setString(1,duration);
	stmt.executeUpdate();
	PreparedStatement stmt2=con.prepareStatement("CREATE TABLE `online_results`.`"+duration+"` (`student_id` VARCHAR(45) NOT NULL, `student_name` VARCHAR(45) NOT NULL,`year` VARCHAR(45) NOT NULL,`exam` VARCHAR(45) NOT NULL,`subject` VARCHAR(45) NOT NULL,`marks` INT NOT NULL, `sno` int not null auto_increment, primary key (`sno`));");
	stmt2.execute();
	
	%>
	<script type="text/javascript">
	alert("New batch added successfully...");
	window.location = 'teacher_success_login.jsp';
	</script>
	<%
}
catch(Exception e)
{
	System.out.println(e);
}
%>

</body>
</html>