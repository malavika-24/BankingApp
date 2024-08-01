<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Withdraw</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <script>
        function validateForm() {
            var amount = document.getElementById("amount").value;
            if (amount == "" || isNaN(amount) || parseFloat(amount) <= 0) {
                alert("Please enter a valid amount.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <h2>Withdraw Amount</h2>
    <form action="WithdrawServlet" method="post" onsubmit="return validateForm()">
        <label for="amount">Amount:</label>
        <input type="text" id="amount" name="amount"><br><br>
        <input type="submit" value="Withdraw">
    </form>
</body>
</html>
