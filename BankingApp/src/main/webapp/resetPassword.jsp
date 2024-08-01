<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Reset Password</h2>
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>
    <form action="ResetPasswordServlet" method="post">
        <label for="account_no">Account No:</label>
        <input type="text" id="account_no" name="account_no" required><br><br>
        <label for="new_password">New Password:</label>
        <input type="password" id="new_password" name="new_password" required><br><br>
        <label for="confirm_password">Confirm Password:</label>
        <input type="password" id="confirm_password" name="confirm_password" required><br><br>
        <input type="submit" value="Reset Password">
    </form>
</body>
</html>
