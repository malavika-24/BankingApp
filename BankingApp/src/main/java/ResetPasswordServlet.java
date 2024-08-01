import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("account_no");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("resetPassword.jsp?error=Passwords do not match.");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/BankingSystem", "root", "mysqlpass@12");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM Customer WHERE account_no=?");
            ps.setString(1, accountNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                ps = con.prepareStatement("UPDATE Customer SET password=? WHERE account_no=?");
                ps.setString(1, newPassword);
                ps.setString(2, accountNo);
                ps.executeUpdate();
                response.sendRedirect("customerLogin.jsp?message=Password reset successful. Please login with your new password.");
            } else {
                response.sendRedirect("resetPassword.jsp?error=Invalid account number.");
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("resetPassword.jsp?error=An error occurred. Please try again.");
        }
    }
}
