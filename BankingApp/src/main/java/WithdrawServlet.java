import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/WithdrawServlet")
public class WithdrawServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html");
		
		HttpSession session = request.getSession();
        String accountNo = (String) session.getAttribute("account_no");
        double amount = Double.parseDouble(request.getParameter("amount"));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");

            PreparedStatement ps = con.prepareStatement("SELECT initial_balance FROM Customer WHERE account_no = ?");
            ps.setString(1, accountNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double currentBalance = rs.getDouble("initial_balance");
                if (currentBalance >= amount) {
                    ps = con.prepareStatement("UPDATE Customer SET initial_balance = initial_balance - ? WHERE account_no = ?");
                    ps.setDouble(1, amount);
                    ps.setString(2, accountNo);
                    ps.executeUpdate();
                    
                    ps = con.prepareStatement("INSERT INTO Transactions (customer_id, amount, type) VALUES ((SELECT customer_id FROM Customer WHERE account_no=?), ?, 'Withdraw')");
                    ps.setString(1, accountNo);
                    ps.setDouble(2, amount);
                    ps.executeUpdate();

                    response.sendRedirect("customerDashboard.jsp");
                } else {
                    out.print("Insufficient Balance");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 