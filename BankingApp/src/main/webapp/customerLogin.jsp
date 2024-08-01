<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        .forgot-password {
            display: block;
            margin-top: 20px;
            font-size: 12px;
            color: #00796b;
            text-decoration: none;
            text-align: right;
        }
    </style>
</head>
<body>
    <h2>Customer Login</h2>
    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        }
    %>
    <form action="CustomerLoginServlet" method="post">
        <label for="account_no">Account No:</label>
        <input type="text" id="account_no" name="account_no" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        <a href="resetPassword.jsp" class="forgot-password">Forgot Password?</a><br><br>
        <input type="submit" value="Login">
    </form>
</body>
</html>
