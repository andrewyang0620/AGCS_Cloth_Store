<!DOCTYPE html>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="styles.css">
    <script>
        function validateForm() {
            var username = document.forms["MyForm"]["username"].value;
            var password = document.forms["MyForm"]["password"].value;
            var email = document.forms["MyForm"]["email"].value;

            if (username === "" || password === "" || email === "") {
                alert("Please fill in all fields");
                return false;
            }

        

            return true;
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div style="margin:0 auto;text-align:center;display:inline">
        <h3>Please Register To Use This Site</h3>
        <br>
        <form name="MyForm" method="post" action="register2.jsp" onsubmit="return validateForm()">
            <table style="display:inline">
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
                    <td><input type="text" name="username" size="10" maxlength="10"></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
                    <td><input type="password" name="password" size="10" maxlength="10"></td>
                </tr>
                <tr>
                    <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Email:</font></div></td>
                    <td><input type="email" name="email" size="10" maxlength="50"></td>
                </tr>
            </table>
            <br/>
            <input class="submit" type="submit" name="Submit2" value="Register">
        </form>
    </div>
</body>
</html>
