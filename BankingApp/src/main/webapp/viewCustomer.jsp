<%@ page import="java.util.*, java.sql.*" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Customers</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<h2>Customer List</h2>
    <table border="1">
        <tr>
            <th>Customer ID</th>
            <th>Full Name</th>
            <th>Address</th>
            <th>Mobile No</th>
            <th>Email ID</th>
            <th>Account Type</th>
            <th>Initial Balance</th>
            <th>Date of Birth</th>
            <th>Account No</th>
            <th>Password</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM Customer");
                
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("customer_id") + "</td>");
                    out.println("<td>" + rs.getString("full_name") + "</td>");
                    out.println("<td>" + rs.getString("address") + "</td>");
                    out.println("<td>" + rs.getString("mobile_no") + "</td>");
                    out.println("<td>" + rs.getString("email_id") + "</td>");
                    out.println("<td>" + rs.getString("account_type") + "</td>");
                    out.println("<td>" + rs.getDouble("initial_balance") + "</td>");
                    out.println("<td>" + rs.getDate("date_of_birth") + "</td>");
                    out.println("<td>" + rs.getString("account_no") + "</td>");
                    out.println("<td>" + rs.getString("password") + "</td>");
                    out.println("</tr>");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
    <a href="adminDashboard.jsp">Back to Dashboard</a>
</body>
</html>