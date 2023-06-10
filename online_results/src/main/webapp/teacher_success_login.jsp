<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<font color="#09e070">Successfully logged in as teacher...</font>
<div style="float:right;"><form action="logout.jsp"><input type="submit" value="logout"></form></div> 
<h1 align=center>Enter following details to add marks</h1>
<form action="add_marks.jsp" method=post>
<div align=center>
<table  style= border-spacing:20px; >
<tr>
<td>Enter batch duration</td>
<td><input type="text" name="duration" placeholder="eg:2020_2024"></td>
</tr>
<tr>
<td>Enter year</td>
<td><select name="year" >
<option value="1">1st</option>
<option value="2">2nd</option>
<option value="3">3rd</option>
<option value="4">4th</option>
</select></td>
</tr>
<tr>
<td>Choose exam</td>
<td>
<select name="exam" >
<option value="mid1">mid1</option>
<option value="mid2">mid2</option>
<option value="sem">semister</option>
<option value="supply">supply</option>
</select>
</td>
</table>
<input type="submit">
</div>
</form>
<form align="center" action="add_new_batch.jsp" method="post">
<h1></h1>
<h1></h1>
<h2>ADD NEW BATCH IF IT DOESN'T EXIST: </h2>
 Enter batch duration <input type="text" placeholder="eg:2020_2024" name="duration"> <input type="submit" value="add">
</form>




</body>
</html>