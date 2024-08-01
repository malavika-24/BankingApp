<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Close Account</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Close Account</h2>
    <%
        // Display message if available
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
    %>
        <div class="message"><%= message %></div>
    <%
        }
    %>
    <form action="CloseAccountServlet" method="post">
        <label for="confirm">Are you sure you want to close your account?</label><br><br>
        <input type="submit" value="Yes">
        <a href="customerDashboard.jsp">No</a>
    </form>
</body>
</html>
