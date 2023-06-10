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
<div style="float:right;"><form action="student_success_login.jsp"><input type="submit" value="home page"></form></div>
<%
int grandtotal=-1,total=-1,overall=0,t=0;
try
{
	String batch=(String)session.getAttribute("batch");
	String id=(String)session.getAttribute("id");
	String exam=(String)session.getAttribute("exam");
	int year=Integer.parseInt((String)session.getAttribute("year"));
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/online_results","root","amulya");
	PreparedStatement s1=con.prepareStatement("select subject, marks from "+batch+" where student_id='"+id+"' and exam='mid1' and year='"+year+"' order by subject;");
	ResultSet mid1=s1.executeQuery();
	PreparedStatement s2=con.prepareStatement("select subject, marks from "+batch+" where student_id='"+id+"' and exam='mid2' and year='"+year+"' order by subject;" );
	ResultSet mid2=s2.executeQuery();
	PreparedStatement s3=con.prepareStatement("select subject, marks from "+batch+" where student_id='"+id+"' and exam='sem' and year='"+year+"' order by subject;" );
	ResultSet sem=s3.executeQuery();
	PreparedStatement s4=con.prepareStatement("select subject, marks from "+batch+" where student_id='"+id+"' and exam='supply' and year='"+year+"' order by subject;" );
	ResultSet supply=s4.executeQuery();
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
	<table align=center border=1 >
	<tr>
	<th>subject</th>
	<th>mid-1</th>
	<th>mid-2</th>
	<th>regular</th>
	<th>supply</th>
	<th>total/100</th>
	<th>Grade</th>
	<th>Status</th>
	</tr>
	<%
	while(mid1.next() && mid2.next() && sem.next() && supply.next())
	{
		t=t+100;
		%>
		<tr>
		<td><%if(mid1.getString(1)=="-1") out.print("NA"); else out.print(mid1.getString(1)); %></td>
		<td><%if(mid1.getString(2)=="-1") out.print("NA"); else out.print(mid1.getString(2)); %></td>
		<td><%if(mid2.getString(2)=="-1") out.print("NA"); else out.print(mid1.getString(2)); %></td>
		<td><%if(sem.getString(2)=="-1") out.print("NA"); else out.print(mid1.getString(2)); %></td>
		<td><%if(supply.getString(2)=="-1") out.print("NA"); else out.print(mid1.getString(2)); %></td>
		<td><%
		int max;
		if(Integer.parseInt(sem.getString(2))>Integer.parseInt(supply.getString(2)))
			max=Integer.parseInt(sem.getString(2));
		else
			max=Integer.parseInt(supply.getString(2));
		total=Integer.parseInt(mid1.getString(2))+Integer.parseInt(mid2.getString(2))+max; out.print(total); %></td>
		<td><%
		if(year==1)
			session.setAttribute("year1",total);
		else if(year==2)
			session.setAttribute("year2",total);
		else if(year==3)
			session.setAttribute("year3",total);
		else if(year==4)
			session.setAttribute("year4",total);
		int k=0;
		if(total==-1)
			out.print("Absent");
		if(total>=90 && total<=100)
			out.print("O");
		else if(total>=80 && total<90)
			out.print("A+");
		else if(total>=70 && total<80)
			out.print("A");
		else if(total>=60 && total<70)
			out.print("B+");
		else if(total>=50 && total<60)
			out.print("B");
		else if(total>=40 && total<50)
			out.print("C");
		else if(total>=30 && total<40)
			out.print("D"); 
		else
		{	out.print("E"); k=1;}
		grandtotal=grandtotal+total;
		%></td>
		<td>
		<%
		
		if(k==1)
			{out.print("F"); overall=1;}
		else
			out.print("P");
		%></td>
		<%
	}
	float i=((float)grandtotal/(float)t)*10;
	%>
	<tr>
	<td colspan=2>Overall GPA:</td><td colspan=2> <%if(overall==1) out.print("___"); else out.print(i); %></td>
	<td colspan=2>Status:</td><td colspan=2> <%if(overall==1) out.print("F"); else out.print("P"); %></td>
	</tr>
	</table>
	<%
}
catch(Exception e)
{
	System.out.println(e);
}
%>
</body>
</html>