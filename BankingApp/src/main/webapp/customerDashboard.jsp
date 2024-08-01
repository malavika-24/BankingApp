<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>
        <%
            HttpSession currentSession = request.getSession(false);
            if (currentSession == null || currentSession.getAttribute("account_no") == null) {
                response.sendRedirect("customerLogin.jsp");
                return;
            }

            String accountNo = (String) currentSession.getAttribute("account_no");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            String customerName = "Customer"; // Default name in case of an error

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");
                ps = con.prepareStatement("SELECT full_name, account_no, initial_balance FROM Customer WHERE account_no=?");
                ps.setString(1, accountNo);
                rs = ps.executeQuery();
                
                if (rs.next()) {
                    customerName = rs.getString("full_name");
                    out.print("Welcome, " + customerName + "<br>");
                    out.print("Account No: " + rs.getString("account_no") + "<br>");
                    out.print("Balance: " + rs.getDouble("initial_balance") + "<br>");
                } else {
                    out.print("No customer found with the given account number.<br>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.print("An error occurred while fetching customer details.<br>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </h2>
    <div class="dashboard-links">
        <a href="viewTransactions.jsp">View Transactions</a> |
        <a href="deposit.jsp">Deposit</a> |
        <a href="withdraw.jsp">Withdraw</a> |
        <a href="closeAccount.jsp">Close Account</a> |
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>
