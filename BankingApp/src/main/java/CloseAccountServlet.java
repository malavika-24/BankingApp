

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CloseAccountServlet")
public class CloseAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNo = (String) session.getAttribute("account_no");

        if (accountNo == null) {
            response.sendRedirect("error.jsp?message=Invalid session. Please log in again.");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");

            // Start transaction
            con.setAutoCommit(false);

            // Retrieve customer_id for the given account_no
            ps = con.prepareStatement("SELECT customer_id FROM Customer WHERE account_no = ?");
            ps.setString(1, accountNo);
            var rs = ps.executeQuery();
            int customerId = 0;
            if (rs.next()) {
                customerId = rs.getInt("customer_id");
            }

            // Delete related transactions
            ps = con.prepareStatement("DELETE FROM transactions WHERE customer_id = ?");
            ps.setInt(1, customerId);
            ps.executeUpdate();

            // Delete the customer
            ps = con.prepareStatement("DELETE FROM Customer WHERE account_no = ?");
            ps.setString(1, accountNo);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                con.commit();  // Commit transaction
                session.invalidate();
                response.sendRedirect("customerLogin.jsp?message=Account closed successfully.");
            } else {
                con.rollback();  // Rollback transaction on failure
                response.sendRedirect("customerDashboard.jsp?message=Failed to close account. Please try again.");
            }
        } catch (Exception e) {
            try {
                if (con != null) con.rollback();  // Rollback transaction on error
            } catch (Exception rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=An error occurred while closing the account. Please check the logs for details.");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
