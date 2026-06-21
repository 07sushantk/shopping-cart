<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>My Profile - Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --cream: #F7F4EF;
    --warm: #EDE8E0;
    --charcoal: #1C1C1E;
    --mid: #5A5A5A;
    --accent: #B8860B;
    --accent2: #D4A843;
    --white: #FFFFFF;
    --radius: 18px;
    --radius-lg: 28px;
    --transition: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

body {
    background-color: var(--cream);
    font-family: 'DM Sans', sans-serif;
    color: var(--charcoal);
    padding-top: 90px;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* ─── NAVBAR ──────────────────────────────────── */
.ee-navbar {
    position: fixed; top: 0; left: 0; right: 0; z-index: 1000;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 48px; height: 72px;
    background: rgba(247,244,239,0.88);
    backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px);
    border-bottom: 1px solid rgba(184,134,11,0.12);
}
.ee-brand { font-family: 'Cormorant Garamond', serif; font-size: 22px; font-weight: 600; letter-spacing: 0.04em; color: var(--charcoal); text-decoration: none !important; }
.ee-brand span { color: var(--accent); }
.ee-nav-links { display: flex; gap: 36px; list-style: none; margin: 0; }
.ee-nav-links a { font-size: 13px; font-weight: 400; letter-spacing: 0.06em; text-transform: uppercase; color: var(--mid); text-decoration: none !important; transition: color 0.25s; }
.ee-nav-links a:hover { color: var(--charcoal); }
.ee-nav-right { display: flex; align-items: center; gap: 20px; }
.ee-icon-btn { width: 38px; height: 38px; border-radius: 50%; background: var(--warm); border: none; display: flex; align-items: center; justify-content: center; cursor: pointer; color: var(--charcoal); transition: background 0.25s, transform 0.2s; text-decoration: none !important; }
.ee-icon-btn:hover { background: var(--accent2); color: var(--white); transform: scale(1.08); }

/* ─── PROFILE LAYOUT ─────────────────────────── */
.profile-container {
    max-width: 1100px;
    margin: 0 auto;
    padding: 20px 48px 80px;
    flex: 1;
    width: 100%;
    display: grid;
    grid-template-columns: 320px 1fr;
    gap: 40px;
}

/* ─── LEFT: Avatar Card ──────────────────────── */
.profile-avatar-card {
    background: var(--white);
    border-radius: var(--radius-lg);
    padding: 48px 32px;
    text-align: center;
    box-shadow: 0 4px 30px rgba(0,0,0,0.06);
    height: fit-content;
    position: sticky;
    top: 100px;
}

.avatar-circle {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--accent) 0%, var(--accent2) 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 24px;
    box-shadow: 0 8px 24px rgba(184,134,11,0.25);
    position: relative;
    overflow: hidden;
}

.avatar-circle::after {
    content: '';
    position: absolute;
    inset: 3px;
    border-radius: 50%;
    background: var(--white);
    display: flex;
    align-items: center;
    justify-content: center;
}

.avatar-initials {
    font-family: 'Cormorant Garamond', serif;
    font-size: 42px;
    font-weight: 600;
    color: var(--accent);
    z-index: 1;
}

.profile-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 600;
    color: var(--charcoal);
    margin-bottom: 6px;
}

.profile-email-sub {
    font-size: 13px;
    color: var(--mid);
    margin-bottom: 28px;
}

.profile-nav {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.profile-nav a {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 500;
    color: var(--mid);
    text-decoration: none !important;
    transition: all 0.25s;
}

.profile-nav a:hover, .profile-nav a.active {
    background: var(--cream);
    color: var(--charcoal);
}

.profile-nav a.active {
    color: var(--accent);
}

.profile-nav a svg {
    flex-shrink: 0;
}

/* ─── RIGHT: Details ─────────────────────────── */
.profile-details-card {
    background: var(--white);
    border-radius: var(--radius-lg);
    padding: 48px;
    box-shadow: 0 4px 30px rgba(0,0,0,0.06);
}

.details-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    font-weight: 600;
    color: var(--charcoal);
    margin-bottom: 8px;
}

.details-subtitle {
    font-size: 14px;
    color: var(--mid);
    margin-bottom: 36px;
    padding-bottom: 24px;
    border-bottom: 1px solid var(--warm);
}

.detail-row {
    display: flex;
    align-items: flex-start;
    padding: 20px 0;
    border-bottom: 1px solid var(--warm);
    gap: 20px;
}

.detail-row:last-child {
    border-bottom: none;
}

.detail-icon {
    width: 44px;
    height: 44px;
    border-radius: 12px;
    background: var(--cream);
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    color: var(--accent);
}

.detail-content {
    flex: 1;
}

.detail-label {
    font-size: 12px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--mid);
    margin-bottom: 4px;
}

.detail-value {
    font-size: 16px;
    font-weight: 500;
    color: var(--charcoal);
    line-height: 1.4;
}

/* Quick action buttons */
.profile-actions {
    display: flex;
    gap: 16px;
    margin-top: 36px;
    padding-top: 28px;
    border-top: 1px solid var(--warm);
}

.btn-ee-primary {
    display: inline-flex; align-items: center; gap: 8px;
    background: var(--charcoal); color: var(--white) !important; border: none; border-radius: 50px;
    padding: 14px 28px; font-size: 13px; font-weight: 500; letter-spacing: 0.05em; text-transform: uppercase;
    cursor: pointer; transition: background 0.3s, transform 0.2s; text-decoration: none !important;
    font-family: 'DM Sans', sans-serif;
}
.btn-ee-primary:hover { background: var(--accent); transform: translateY(-2px); color: var(--white) !important; }

.btn-ee-outline {
    display: inline-flex; align-items: center; gap: 8px;
    background: transparent; color: var(--mid) !important; border: 1px solid var(--warm); border-radius: 50px;
    padding: 14px 28px; font-size: 13px; font-weight: 500; letter-spacing: 0.05em; text-transform: uppercase;
    cursor: pointer; transition: all 0.3s; text-decoration: none !important;
    font-family: 'DM Sans', sans-serif;
}
.btn-ee-outline:hover { border-color: var(--charcoal); color: var(--charcoal) !important; }

/* ─── FOOTER ───────────────────────────────────── */
.ee-footer { background: var(--charcoal); color: rgba(255,255,255,0.55); padding: 56px 48px 32px; margin-top: auto; }
.ee-footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 48px; margin-bottom: 48px; }
.ee-footer-brand { font-family: 'Cormorant Garamond', serif; font-size: 22px; font-weight: 600; color: var(--white); letter-spacing: 0.04em; margin-bottom: 14px; }
.ee-footer-brand span { color: var(--accent2); }
.ee-footer p { font-size: 13px; line-height: 1.7; max-width: 260px; }
.ee-footer-col h4 { font-size: 11px; font-weight: 600; letter-spacing: 0.12em; text-transform: uppercase; color: var(--white); margin-bottom: 18px; }
.ee-footer-col ul { list-style: none; padding: 0; }
.ee-footer-col ul li { margin-bottom: 10px; }
.ee-footer-col ul li a { font-size: 13px; color: rgba(255,255,255,0.45); text-decoration: none !important; transition: color 0.25s; }
.ee-footer-col ul li a:hover { color: var(--accent2); }
.ee-footer-bottom { border-top: 1px solid rgba(255,255,255,0.08); padding-top: 28px; display: flex; align-items: center; justify-content: space-between; font-size: 12px; }

@media (max-width: 768px) {
    .profile-container { grid-template-columns: 1fr; }
    .profile-avatar-card { position: static; }
    .ee-navbar { padding: 0 20px; }
    .profile-container { padding: 20px; }
    .profile-details-card { padding: 28px; }
    .profile-actions { flex-direction: column; }
    .ee-footer-grid { grid-template-columns: 1fr 1fr; }
}
</style>
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");

    if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }

    UserService dao = new UserServiceImpl();
    UserBean user = dao.getUserDetails(userName, password);
    if (user == null)
        user = new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");

    // Get initials for avatar
    String fullName = user.getName();
    String initials = "";
    if (fullName != null && fullName.length() > 0) {
        String[] parts = fullName.trim().split("\\s+");
        initials = String.valueOf(parts[0].charAt(0));
        if (parts.length > 1) initials += String.valueOf(parts[parts.length-1].charAt(0));
        initials = initials.toUpperCase();
    }
    %>

    <!-- ─── NAVBAR ──────────────────────────────────── -->
    <nav class="ee-navbar" id="mainNav">
        <a href="userHome.jsp" class="ee-brand">Ellison<span>.</span></a>
        <ul class="ee-nav-links hidden-xs">
            <li><a href="userHome.jsp">Home</a></li>
            <li><a href="userHome.jsp?type=mobile">Mobiles</a></li>
            <li><a href="userHome.jsp?type=laptop">Laptops</a></li>
            <li><a href="userHome.jsp?type=tv">TVs</a></li>
            <li><a href="userHome.jsp?type=camera">Cameras</a></li>
        </ul>
        <div class="ee-nav-right">
            <a href="cartDetails.jsp" class="ee-icon-btn" title="Cart">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            </a>
            <a href="userProfile.jsp" class="ee-icon-btn" title="Profile" style="background:var(--accent2);color:var(--white);">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            </a>
            <a href="./LogoutSrv" class="ee-icon-btn" title="Logout">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            </a>
        </div>
    </nav>

    <!-- ─── PROFILE LAYOUT ───────────────────────── -->
    <div class="profile-container">

        <!-- LEFT: Avatar & Navigation -->
        <div>
            <div class="profile-avatar-card">
                <div class="avatar-circle">
                    <span class="avatar-initials"><%=initials%></span>
                </div>
                <div class="profile-name"><%=user.getName()%></div>
                <div class="profile-email-sub"><%=user.getEmail()%></div>

                <div class="profile-nav">
                    <a href="userProfile.jsp" class="active">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        My Profile
                    </a>
                    <a href="orderDetails.jsp">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                        My Orders
                    </a>
                    <a href="cartDetails.jsp">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                        My Cart
                    </a>
                    <a href="./LogoutSrv">
                        <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                        Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- RIGHT: Profile Details -->
        <div>
            <div class="profile-details-card">
                <h1 class="details-title">Personal Information</h1>
                <p class="details-subtitle">Your account details and contact information</p>

                <!-- Full Name -->
                <div class="detail-row">
                    <div class="detail-icon">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Full Name</div>
                        <div class="detail-value"><%=user.getName()%></div>
                    </div>
                </div>

                <!-- Email -->
                <div class="detail-row">
                    <div class="detail-icon">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Email Address</div>
                        <div class="detail-value"><%=user.getEmail()%></div>
                    </div>
                </div>

                <!-- Phone -->
                <div class="detail-row">
                    <div class="detail-icon">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Phone Number</div>
                        <div class="detail-value"><%=user.getMobile()%></div>
                    </div>
                </div>

                <!-- Address -->
                <div class="detail-row">
                    <div class="detail-icon">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Address</div>
                        <div class="detail-value"><%=user.getAddress()%></div>
                    </div>
                </div>

                <!-- Pin Code -->
                <div class="detail-row">
                    <div class="detail-icon">
                        <svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                    </div>
                    <div class="detail-content">
                        <div class="detail-label">Pin Code</div>
                        <div class="detail-value"><%=user.getPinCode()%></div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="profile-actions">
                    <a href="orderDetails.jsp" class="btn-ee-primary">
                        <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                        View Orders
                    </a>
                    <a href="userHome.jsp" class="btn-ee-outline">
                        Continue Shopping
                    </a>
                </div>
            </div>
        </div>

    </div>

    <!-- ─── FOOTER ────────────────────────────────────── -->
    <footer class="ee-footer">
        <div class="ee-footer-grid">
            <div>
                <div class="ee-footer-brand">Ellison<span>.</span></div>
                <p>Your premium destination for electronics. From mobiles to home theatre, we bring the finest technology to your doorstep.</p>
            </div>
            <div class="ee-footer-col">
                <h4>Customer Service</h4>
                <ul><li><a href="#">Help &amp; Contact Us</a></li><li><a href="#">Orders &amp; Shipping</a></li><li><a href="#">Payment</a></li><li><a href="#">Returns &amp; Refunds</a></li></ul>
            </div>
            <div class="ee-footer-col">
                <h4>About Us</h4>
                <ul><li><a href="#">About us</a></li><li><a href="#">Showrooms</a></li><li><a href="#">Shops</a></li></ul>
            </div>
            <div class="ee-footer-col">
                <h4>Legal</h4>
                <ul><li><a href="#">Terms &amp; Conditions</a></li><li><a href="#">Privacy Policy</a></li><li><a href="#">Cookies Policy</a></li></ul>
            </div>
        </div>
        <div class="ee-footer-bottom">
            <span>&copy; 2024 Ellison Electronics. All rights reserved.</span>
            <span>Made with care for tech lovers.</span>
        </div>
    </footer>

</body>
</html>