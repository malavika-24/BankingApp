<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Forgot Password</h2>
    <form action="VerifyAccountServlet" method="post">
        <label for="accountNo">Account Number:</label>
        <input type="text" id="accountNo" name="accountNo" required><br><br>
        <!-- Optionally, you can add additional fields for verification -->
        <input type="submit" value="Verify Account">
    </form>
</body>
</html>
