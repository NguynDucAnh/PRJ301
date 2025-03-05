<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
    /* ========== Login Styles ========== */
    body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }

    .login-container {
        background: rgba(255, 255, 255, 0.95);
        padding: 2.5rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        width: 90%;
        max-width: 400px;
        margin: 2rem auto;
        transform: translateY(-20px);
    }

    .login-container h1 {
        color: #2d3748;
        text-align: center;
        margin-bottom: 2rem;
        font-size: 1.8rem;
        font-weight: 600;
    }

    .login-form {
        display: flex;
        flex-direction: column;
        gap: 1.8rem;
    }

    .input-group {
        position: relative;
    }

    .input-group input {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e2e8f0;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;
        background: #f8fafc;
    }

    .input-group input:focus {
        outline: none;
        border-color: #667eea;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .input-group input::placeholder {
        color: #94a3b8;
    }

    button[type="submit"] {
        width: 100%;
        padding: 14px;
        background: #667eea;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    button[type="submit"]:hover {
        background: #5a67d8;
        transform: translateY(-1px);
    }


    .register-link {
        text-align: center;
        margin-top: 1.5rem;
        color: #64748b;
    }

    .register-link a {
        color: #667eea;
        text-decoration: none;
        font-weight: 500;
    }

    .register-link a:hover {
        text-decoration: underline;
    }

    @media (max-width: 480px) {
        .login-container {
            padding: 2rem 1.5rem;
        }
        
        .login-container h1 {
            font-size: 1.5rem;
        }
    }
</style>
    </head>
    <body>
    <div class="login-container">
        <h1>Welcome to Startup Manager</h1>
        <form action="MainController" method="POST" class="login-form">
            <input type="hidden" name="action" value="login">
            <div class="input-group">
                <input type="text" name="username" placeholder="Username" required>
            </div>
            <div class="input-group">
                <input type="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit">Sign In</button>
            <div class="register-link">
                Don't have an account? <a href="#">Contact Admin</a>
            </div>
        </form>
    </div>
    <%@include file="footer.jsp" %>       
</body>
</html>