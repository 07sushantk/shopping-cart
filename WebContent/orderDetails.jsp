<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>My Orders - Ellison Electronics</title>
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
    --shadow: 0 8px 40px rgba(0,0,0,0.08);
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

/* ─── PAGE CONTENT ───────────────────────────── */
.page-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px 48px 80px;
    flex: 1;
    width: 100%;
}

.page-header {
    margin-bottom: 40px;
}

.page-header h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 40px;
    font-weight: 300;
    color: var(--charcoal);
    margin: 0 0 8px 0;
}

.page-header p {
    font-size: 14px;
    color: var(--mid);
}

/* ─── ORDER CARDS ────────────────────────────── */
.orders-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.order-card {
    display: flex;
    background: var(--white);
    border-radius: var(--radius);
    padding: 24px;
    gap: 28px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.04);
    transition: box-shadow var(--transition), transform var(--transition);
    position: relative;
    overflow: hidden;
}

.order-card:hover {
    box-shadow: 0 12px 40px rgba(0,0,0,0.1);
    transform: translateY(-3px);
}

.order-img-wrap {
    width: 120px;
    height: 120px;
    border-radius: 12px;
    background: var(--warm);
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 12px;
    flex-shrink: 0;
    transition: background 0.4s;
}

.order-card:hover .order-img-wrap {
    background: #E8E2D5;
}

.order-img-wrap img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.5s ease;
}

.order-card:hover .order-img-wrap img {
    transform: scale(1.1);
}

.order-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 6px;
}

.order-product-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 600;
    color: var(--charcoal);
    line-height: 1.2;
}

.order-meta {
    display: flex;
    gap: 24px;
    flex-wrap: wrap;
    margin-top: 4px;
}

.order-meta-item {
    font-size: 13px;
    color: var(--mid);
}

.order-meta-item span {
    font-weight: 600;
    color: var(--charcoal);
}

.order-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    justify-content: center;
    gap: 8px;
    flex-shrink: 0;
    min-width: 140px;
}

.order-amount {
    font-family: 'Cormorant Garamond', serif;
    font-size: 24px;
    font-weight: 600;
    color: var(--accent);
}

.order-amount .currency {
    font-size: 14px;
    vertical-align: super;
}

/* Status badges */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 50px;
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.06em;
    text-transform: uppercase;
}

.status-placed {
    background: rgba(59,130,246,0.1);
    color: #3B82F6;
}

.status-shipped {
    background: rgba(34,197,94,0.1);
    color: #22C55E;
}

.order-time {
    font-size: 12px;
    color: var(--mid);
}

/* Empty state */
.empty-state {
    text-align: center;
    padding: 80px 20px;
    background: var(--white);
    border-radius: var(--radius-lg);
}

.empty-state h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    color: var(--charcoal);
    margin-bottom: 12px;
}

.empty-state p {
    color: var(--mid);
    margin-bottom: 28px;
}

.btn-ee-primary {
    display: inline-flex; align-items: center; gap: 8px;
    background: var(--charcoal); color: var(--white) !important; border: none; border-radius: 50px;
    padding: 14px 32px; font-size: 13px; font-weight: 500; letter-spacing: 0.05em; text-transform: uppercase;
    cursor: pointer; transition: background 0.3s, transform 0.2s; text-decoration: none !important;
}
.btn-ee-primary:hover { background: var(--accent); transform: translateY(-2px); }

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
    .order-card { flex-direction: column; gap: 16px; }
    .order-right { align-items: flex-start; flex-direction: row; gap: 16px; }
    .ee-navbar { padding: 0 20px; }
    .page-container { padding: 20px; }
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

    OrderService dao = new OrderServiceImpl();
    List<OrderDetails> orders = dao.getAllOrderDetails(userName);
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
            <a href="userProfile.jsp" class="ee-icon-btn" title="Profile">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
            </a>
            <a href="./LogoutSrv" class="ee-icon-btn" title="Logout">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            </a>
        </div>
    </nav>

    <!-- ─── ORDER DETAILS CONTENT ─────────────────── -->
    <div class="page-container">
        <div class="page-header">
            <h1>My Orders</h1>
            <p>Track and review your purchase history</p>
        </div>

        <% if (orders != null && !orders.isEmpty()) { %>

        <div class="orders-list">
            <% for (OrderDetails order : orders) { %>
            <div class="order-card">
                <!-- Product Image -->
                <div class="order-img-wrap">
                    <img src="./ShowImage?pid=<%=order.getProductId()%>" alt="<%=order.getProdName()%>">
                </div>

                <!-- Order Info -->
                <div class="order-info">
                    <div class="order-product-name"><%=order.getProdName()%></div>
                    <div class="order-meta">
                        <div class="order-meta-item">Order ID: <span>#<%=order.getOrderId()%></span></div>
                        <div class="order-meta-item">Qty: <span><%=order.getQty()%></span></div>
                    </div>
                </div>

                <!-- Amount & Status -->
                <div class="order-right">
                    <div class="order-amount"><span class="currency">&#8377;</span><%=order.getAmount()%></div>
                    <% if (order.getShipped() == 0) { %>
                        <span class="status-badge status-placed">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                            Order Placed
                        </span>
                    <% } else { %>
                        <span class="status-badge status-shipped">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                            Shipped
                        </span>
                    <% } %>
                    <div class="order-time"><%=order.getTime()%></div>
                </div>
            </div>
            <% } %>
        </div>

        <% } else { %>

        <div class="empty-state">
            <svg width="64" height="64" fill="none" stroke="var(--mid)" stroke-width="1" viewBox="0 0 24 24" style="margin-bottom:20px;opacity:0.4;"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
            <h2>No Orders Yet</h2>
            <p>You haven't placed any orders. Start browsing our collection!</p>
            <a href="userHome.jsp" class="btn-ee-primary">Start Shopping</a>
        </div>

        <% } %>
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