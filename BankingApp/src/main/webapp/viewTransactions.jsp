<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Transactions</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Last 10 Transactions</h2>
    <%
        String accountNo = (String) session.getAttribute("account_no");
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM Transactions WHERE customer_id=(SELECT customer_id FROM Customer WHERE account_no=?) ORDER BY transaction_date DESC LIMIT 10");
        ps.setString(1, accountNo);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            out.print("Date: " + rs.getTimestamp("transaction_date") + ", Amount: " + rs.getDouble("amount") + ", Type: " + rs.getString("type") + "<br>");
        }
    %>
    <form action="PrintTransactionServlet" method="get"><input type="submit" value="Print"></form>
    <a href="customerDashboard.jsp">Back to Dashboard</a>
</body>
</html>