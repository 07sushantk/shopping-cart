<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{--charcoal:#1C1C1E;--mid:#5A5A5A;--accent:#3B5BDB;--white:#FFFFFF;--radius:14px;--radius-lg:20px;--danger:#E03131;--success:#2F9E44;--warning:#F59F00}
body{background:#F0F2F5;font-family:'DM Sans',sans-serif;color:var(--charcoal);margin:0;display:flex;min-height:100vh}
.admin-sidebar{width:260px;background:var(--accent);color:var(--white);display:flex;flex-direction:column;position:fixed;top:0;left:0;bottom:0;z-index:100;overflow-y:auto}
.sidebar-brand{padding:28px 24px;border-bottom:1px solid rgba(255,255,255,0.12)}
.sidebar-brand h2{font-family:'Cormorant Garamond',serif;font-size:22px;font-weight:600;color:var(--white);margin:0}
.sidebar-brand p{font-size:11px;color:rgba(255,255,255,0.5);margin:4px 0 0;text-transform:uppercase;letter-spacing:0.06em}
.sidebar-nav{padding:16px 12px;flex:1}
.sidebar-nav a{display:flex;align-items:center;gap:12px;padding:12px 16px;border-radius:10px;font-size:14px;font-weight:500;color:rgba(255,255,255,0.7);text-decoration:none!important;transition:all 0.25s;margin-bottom:4px}
.sidebar-nav a:hover{background:rgba(255,255,255,0.12);color:var(--white)}
.sidebar-nav a.active{background:var(--white);color:var(--accent);font-weight:600;box-shadow:0 4px 12px rgba(0,0,0,0.1)}
.sidebar-nav a svg{flex-shrink:0;width:20px;height:20px}
.sidebar-section-label{font-size:10px;font-weight:600;text-transform:uppercase;letter-spacing:0.12em;color:rgba(255,255,255,0.35);padding:16px 16px 8px}
.sidebar-footer{padding:20px 16px;border-top:1px solid rgba(255,255,255,0.12)}
.sidebar-footer a{display:flex;align-items:center;gap:10px;padding:10px 14px;border-radius:10px;font-size:13px;color:rgba(255,255,255,0.6);text-decoration:none!important;transition:all 0.25s}
.sidebar-footer a:hover{background:rgba(255,255,255,0.1);color:var(--white)}
.admin-main{margin-left:260px;flex:1;display:flex;flex-direction:column;min-height:100vh}
.admin-topbar{display:flex;align-items:center;justify-content:space-between;padding:20px 40px;background:var(--white);border-bottom:1px solid #E8E8E8;position:sticky;top:0;z-index:50}
.topbar-left h1{font-family:'Cormorant Garamond',serif;font-size:28px;font-weight:600;color:var(--charcoal);margin:0}
.topbar-left p{font-size:13px;color:var(--mid);margin:2px 0 0}
.admin-avatar{width:38px;height:38px;border-radius:50%;background:var(--accent);display:flex;align-items:center;justify-content:center;color:var(--white);font-weight:600;font-size:14px}
.admin-content{padding:32px 40px;flex:1}

/* Dashboard Cards */
.dash-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:24px;margin-bottom:40px}
.dash-card{background:var(--white);border-radius:var(--radius-lg);padding:32px 28px;box-shadow:0 2px 12px rgba(0,0,0,0.04);transition:all 0.3s;cursor:pointer;text-decoration:none!important;color:var(--charcoal);display:block}
.dash-card:hover{transform:translateY(-4px);box-shadow:0 12px 32px rgba(0,0,0,0.1)}
.dash-card-icon{width:52px;height:52px;border-radius:14px;display:flex;align-items:center;justify-content:center;margin-bottom:20px}
.icon-blue{background:rgba(59,91,219,0.1);color:var(--accent)}
.icon-green{background:rgba(47,158,68,0.1);color:var(--success)}
.icon-red{background:rgba(224,49,49,0.1);color:var(--danger)}
.icon-orange{background:rgba(245,159,0,0.1);color:var(--warning)}
.dash-card h3{font-family:'Cormorant Garamond',serif;font-size:22px;font-weight:600;margin-bottom:6px}
.dash-card p{font-size:13px;color:var(--mid);line-height:1.5}
.dash-card .card-arrow{display:flex;align-items:center;gap:6px;margin-top:16px;font-size:12px;font-weight:600;color:var(--accent);text-transform:uppercase;letter-spacing:0.06em}

/* Welcome banner */
.welcome-banner{background:linear-gradient(135deg,var(--accent) 0%,#5C7CFA 100%);border-radius:var(--radius-lg);padding:40px;margin-bottom:32px;color:var(--white);position:relative;overflow:hidden}
.welcome-banner::after{content:'';position:absolute;top:-40px;right:-40px;width:180px;height:180px;border-radius:50%;background:rgba(255,255,255,0.08)}
.welcome-banner h2{font-family:'Cormorant Garamond',serif;font-size:32px;font-weight:600;margin-bottom:8px}
.welcome-banner p{font-size:14px;color:rgba(255,255,255,0.7);max-width:400px}

@media(max-width:992px){
.admin-sidebar{width:72px}.admin-sidebar .sidebar-brand h2,.admin-sidebar .sidebar-brand p,.sidebar-nav a span,.sidebar-section-label,.sidebar-footer a span{display:none}
.sidebar-nav a{justify-content:center;padding:14px}.sidebar-brand{padding:20px 16px;text-align:center}
.admin-main{margin-left:72px}.admin-content{padding:20px}.admin-topbar{padding:16px 20px}
.dash-grid{grid-template-columns:1fr 1fr}
}
</style>
</head>
<body>
    <%
    String userType = (String) session.getAttribute("admin_usertype");
    String userName = (String) session.getAttribute("admin_username");
    String password = (String) session.getAttribute("admin_password");
    if (userType == null || !userType.equals("admin")) { response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!"); return; }
    else if (userName == null || password == null) { response.sendRedirect("login.jsp?message=Session Expired, Login Again!!"); return; }
    %>

    <aside class="admin-sidebar">
        <div class="sidebar-brand"><h2>Ellison.</h2><p>Admin Panel</p></div>
        <nav class="sidebar-nav">
            <div class="sidebar-section-label">Main</div>
            <a href="adminViewProduct.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg><span>Products</span></a>
            <a href="adminStock.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg><span>Stock</span></a>
            <div class="sidebar-section-label">Orders</div>
            <a href="unshippedItems.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg><span>Pending Orders</span></a>
            <a href="shippedItems.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg><span>Shipped</span></a>
            <div class="sidebar-section-label">Manage</div>
            <a href="addProduct.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg><span>Add Product</span></a>
            <a href="removeProduct.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg><span>Remove Product</span></a>
            <a href="updateProductById.jsp"><svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg><span>Update Product</span></a>
        </nav>
        <div class="sidebar-footer"><a href="./LogoutSrv?role=admin"><svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg><span>Logout</span></a></div>
    </aside>

    <main class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left"><h1>Dashboard</h1><p>Welcome back, Admin</p></div>
            <div class="admin-avatar">A</div>
        </div>
        <div class="admin-content">

            <div class="welcome-banner">
                <h2>Welcome to Admin Panel</h2>
                <p>Manage your products, track orders, and monitor inventory from one central dashboard.</p>
            </div>

            <div class="dash-grid">
                <a href="adminViewProduct.jsp" class="dash-card">
                    <div class="dash-card-icon icon-blue">
                        <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
                    </div>
                    <h3>View Products</h3>
                    <p>Browse and manage all products in your catalog</p>
                    <div class="card-arrow">Go to Products <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></div>
                </a>

                <a href="addProduct.jsp" class="dash-card">
                    <div class="dash-card-icon icon-green">
                        <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                    </div>
                    <h3>Add Product</h3>
                    <p>Add new products to the electronics catalog</p>
                    <div class="card-arrow">Add Now <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></div>
                </a>

                <a href="unshippedItems.jsp" class="dash-card">
                    <div class="dash-card-icon icon-orange">
                        <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                    </div>
                    <h3>Pending Orders</h3>
                    <p>View and ship orders waiting for delivery</p>
                    <div class="card-arrow">View Orders <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></div>
                </a>

                <a href="adminStock.jsp" class="dash-card">
                    <div class="dash-card-icon icon-red">
                        <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                    </div>
                    <h3>Stock Overview</h3>
                    <p>Monitor inventory levels and stock status</p>
                    <div class="card-arrow">Check Stock <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg></div>
                </a>
            </div>
        </div>
    </main>
</body>
</html>