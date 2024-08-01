<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Admin Login</h2>
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        }
    %>
    <form action="AdminLoginServlet" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username"><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
