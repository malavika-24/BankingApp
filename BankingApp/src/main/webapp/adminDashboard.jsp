<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("username") %></h2>
    <div class="dashboard-links">
        <a href="registerCustomer.jsp">Register Customer</a> |
        <a href="viewCustomer.jsp">View Customers</a> |
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>
