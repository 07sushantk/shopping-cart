<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Login - Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
    /* ─── BASE STYLES ─── */
    body {
        background-color: #F7F7F8;
        font-family: 'DM Sans', sans-serif;
        color: #1C1C1E;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* ─── AUTH LAYOUT ─── */
    .auth-wrapper {
        flex: 1;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px 20px;
    }

    .auth-card {
        display: flex;
        width: 100%;
        max-width: 480px;
        background: #FFFFFF;
        border-radius: 24px;
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }

    /* ─── RIGHT SIDE (FORM) ─── */
    .auth-right {
        flex: 1;
        padding: 48px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    
    .back-home {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #8A8D93;
        text-decoration: none;
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 24px;
        transition: color 0.3s;
    }
    .back-home:hover {
        color: #1C1C1E;
        text-decoration: none;
    }

    .auth-title {
        font-size: 28px;
        font-weight: 700;
        color: #1C1C1E;
        margin-bottom: 32px;
        text-align: left;
    }

    /* ─── FORM ELEMENTS ─── */
    .form-group {
        margin-bottom: 20px;
        position: relative;
    }

    .form-control {
        height: 48px;
        background-color: #F4F5F7;
        border: 1px solid transparent;
        border-radius: 8px;
        padding: 10px 16px 10px 42px;
        font-size: 14px;
        color: #1C1C1E;
        box-shadow: none;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        background-color: #FFFFFF;
        border-color: #B8860B;
        box-shadow: 0 0 0 4px rgba(184, 134, 11, 0.1);
    }

    .form-control::placeholder {
        color: #8A8D93;
    }

    /* Input Icons */
    .input-icon {
        position: absolute;
        left: 14px;
        top: 15px;
        color: #8A8D93;
        width: 18px;
        height: 18px;
        z-index: 2;
    }

    /* Password Toggle */
    .pwd-toggle {
        position: absolute;
        right: 14px;
        top: 15px;
        color: #8A8D93;
        cursor: pointer;
        z-index: 2;
        width: 18px;
        height: 18px;
    }

    /* Custom Select */
    select.form-control {
        appearance: none;
        -webkit-appearance: none;
        padding-left: 42px;
    }
    .select-arrow {
        position: absolute;
        right: 14px;
        top: 18px;
        color: #8A8D93;
        pointer-events: none;
    }

    /* ─── BUTTONS ─── */
    .btn-auth {
        width: 100%;
        height: 48px;
        background-color: #8C949D; /* Match mockup button color */
        color: #FFFFFF;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 500;
        margin-top: 12px;
        transition: background-color 0.3s;
    }

    .btn-auth:hover {
        background-color: #7A818A;
        color: white;
    }

    .auth-links {
        margin-top: 24px;
        text-align: center;
        font-size: 14px;
        color: #8A8D93;
    }

    .auth-links a {
        color: #1C1C1E;
        font-weight: 500;
        text-decoration: none;
        border-bottom: 1px solid #1C1C1E;
        padding-bottom: 2px;
    }

    /* ─── ERROR MESSAGE ─── */
    .alert-msg {
        background-color: #FDE8E8;
        color: #C53030;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 13px;
        margin-bottom: 24px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    /* ─── RESPONSIVE ─── */
    @media (max-width: 768px) {
        .auth-right {
            padding: 40px 24px;
        }
    }
</style>
</head>
<body>

    <%
    String message = request.getParameter("message");
    %>

    <div class="auth-wrapper">
        <div class="auth-card">
            
            <!-- RIGHT SIDE (FORM) -->
            <div class="auth-right">
                <a href="index.jsp" class="back-home">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="19" y1="12" x2="5" y2="12"></line><polyline points="12 19 5 12 12 5"></polyline></svg>
                    Back to Home
                </a>
                <h2 class="auth-title">Login</h2>

                <% if (message != null) { %>
                <div class="alert-msg">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line>
                    </svg>
                    <%=message%>
                </div>
                <% } %>

                <form action="./LoginSrv" method="post">
                    
                    <!-- Username / Email -->
                    <div class="form-group">
                        <svg class="input-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        <input type="email" name="username" class="form-control" placeholder="What is your e-mail?" required>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <svg class="input-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                        </svg>
                        <input type="password" name="password" id="pwdInput" class="form-control" placeholder="Enter your password" required>
                        <svg class="pwd-toggle" id="togglePwd" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle>
                        </svg>
                    </div>

                    <!-- Role Selection -->
                    <div class="form-group">
                        <svg class="input-icon" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        <select name="usertype" class="form-control" required>
                            <option value="customer" selected>Login as Customer</option>
                            <option value="admin">Login as Admin</option>
                        </select>
                        <svg class="select-arrow" width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <polyline points="6 9 12 15 18 9"></polyline>
                        </svg>
                    </div>

                    <button type="submit" class="btn-auth">Continue</button>
                </form>

                <div class="auth-links">
                    Don't have an account? <a href="register.jsp">Sign up</a>
                </div>

            </div>
        </div>
    </div>

    <script>
        // Password visibility toggle
        document.getElementById('togglePwd').addEventListener('click', function() {
            var pwdInput = document.getElementById('pwdInput');
            if (pwdInput.type === 'password') {
                pwdInput.type = 'text';
                this.innerHTML = '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path><line x1="1" y1="1" x2="23" y2="23"></line>';
            } else {
                pwdInput.type = 'password';
                this.innerHTML = '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle>';
            }
        });
    </script>
</body>
</html>