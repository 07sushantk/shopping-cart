<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard - Ellison Electronics</title>
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
    --accent: #3B5BDB;
    --accent-light: #5C7CFA;
    --accent-bg: rgba(59,91,219,0.08);
    --white: #FFFFFF;
    --radius: 14px;
    --radius-lg: 20px;
    --transition: 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    --danger: #E03131;
    --success: #2F9E44;
}

body {
    background-color: #F0F2F5;
    font-family: 'DM Sans', sans-serif;
    color: var(--charcoal);
    margin: 0;
    display: flex;
    min-height: 100vh;
}

/* ─── SIDEBAR ────────────────────────────────── */
.admin-sidebar {
    width: 260px;
    background: var(--accent);
    color: var(--white);
    display: flex;
    flex-direction: column;
    padding: 0;
    position: fixed;
    top: 0;
    left: 0;
    bottom: 0;
    z-index: 100;
    overflow-y: auto;
}

.sidebar-brand {
    padding: 28px 24px;
    border-bottom: 1px solid rgba(255,255,255,0.12);
}

.sidebar-brand h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 600;
    color: var(--white);
    margin: 0;
    letter-spacing: 0.04em;
}

.sidebar-brand p {
    font-size: 11px;
    color: rgba(255,255,255,0.5);
    margin: 4px 0 0 0;
    letter-spacing: 0.06em;
    text-transform: uppercase;
}

.sidebar-nav {
    padding: 16px 12px;
    flex: 1;
}

.sidebar-nav a {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 500;
    color: rgba(255,255,255,0.7);
    text-decoration: none !important;
    transition: all 0.25s;
    margin-bottom: 4px;
}

.sidebar-nav a:hover {
    background: rgba(255,255,255,0.12);
    color: var(--white);
}

.sidebar-nav a.active {
    background: var(--white);
    color: var(--accent);
    font-weight: 600;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.sidebar-nav a svg {
    flex-shrink: 0;
    width: 20px;
    height: 20px;
}

.sidebar-section-label {
    font-size: 10px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    color: rgba(255,255,255,0.35);
    padding: 16px 16px 8px;
}

.sidebar-footer {
    padding: 20px 16px;
    border-top: 1px solid rgba(255,255,255,0.12);
}

.sidebar-footer a {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 10px 14px;
    border-radius: 10px;
    font-size: 13px;
    color: rgba(255,255,255,0.6);
    text-decoration: none !important;
    transition: all 0.25s;
}

.sidebar-footer a:hover {
    background: rgba(255,255,255,0.1);
    color: var(--white);
}

/* ─── MAIN CONTENT ───────────────────────────── */
.admin-main {
    margin-left: 260px;
    flex: 1;
    padding: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

/* Top bar */
.admin-topbar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 40px;
    background: var(--white);
    border-bottom: 1px solid #E8E8E8;
    position: sticky;
    top: 0;
    z-index: 50;
}

.topbar-left h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 600;
    color: var(--charcoal);
    margin: 0;
}

.topbar-left p {
    font-size: 13px;
    color: var(--mid);
    margin: 2px 0 0 0;
}

.topbar-right {
    display: flex;
    align-items: center;
    gap: 16px;
}

.search-box {
    display: flex;
    align-items: center;
    background: #F0F2F5;
    border-radius: 10px;
    padding: 8px 14px;
    gap: 8px;
    border: 1px solid transparent;
    transition: border-color 0.25s;
}

.search-box:focus-within {
    border-color: var(--accent);
    background: var(--white);
}

.search-box input {
    border: none;
    background: transparent;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    color: var(--charcoal);
    outline: none;
    width: 180px;
}

.search-box button {
    border: none;
    background: none;
    cursor: pointer;
    color: var(--mid);
    padding: 0;
    display: flex;
}

.admin-avatar {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: var(--accent);
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--white);
    font-weight: 600;
    font-size: 14px;
}

/* ─── CONTENT AREA ───────────────────────────── */
.admin-content {
    padding: 32px 40px;
    flex: 1;
}

.content-message {
    font-size: 14px;
    color: var(--mid);
    margin-bottom: 24px;
    padding: 10px 16px;
    background: var(--white);
    border-radius: 10px;
    border-left: 3px solid var(--accent);
}

/* ─── PRODUCT TABLE ──────────────────────────── */
.data-table-wrap {
    background: var(--white);
    border-radius: var(--radius-lg);
    box-shadow: 0 2px 12px rgba(0,0,0,0.04);
    overflow: hidden;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table thead th {
    background: #FAFAFA;
    padding: 14px 20px;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: var(--mid);
    border-bottom: 1px solid #EBEBEB;
    text-align: left;
}

.data-table tbody tr {
    transition: background 0.2s;
    border-bottom: 1px solid #F5F5F5;
}

.data-table tbody tr:last-child {
    border-bottom: none;
}

.data-table tbody tr:hover {
    background: #F8F9FF;
}

.data-table tbody td {
    padding: 14px 20px;
    font-size: 14px;
    color: var(--charcoal);
    vertical-align: middle;
}

.prod-table-img {
    width: 48px;
    height: 48px;
    border-radius: 8px;
    background: #F0F2F5;
    object-fit: contain;
    padding: 4px;
}

.prod-name-cell {
    font-weight: 500;
}

.prod-id-cell {
    font-size: 12px;
    color: var(--mid);
    font-family: monospace;
}

.prod-price-cell {
    font-weight: 600;
    color: var(--accent);
}

/* Action buttons */
.action-btns {
    display: flex;
    gap: 8px;
}

.btn-action {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    text-decoration: none !important;
    border: none;
    font-family: 'DM Sans', sans-serif;
}

.btn-action-edit {
    background: rgba(59,91,219,0.08);
    color: var(--accent);
}

.btn-action-edit:hover {
    background: var(--accent);
    color: var(--white) !important;
}

.btn-action-delete {
    background: rgba(224,49,49,0.08);
    color: var(--danger);
}

.btn-action-delete:hover {
    background: var(--danger);
    color: var(--white) !important;
}

/* Empty state */
.empty-table-state {
    text-align: center;
    padding: 60px 20px;
    color: var(--mid);
}

/* ─── RESPONSIVE ──────────────────────────────── */
@media (max-width: 992px) {
    .admin-sidebar { width: 72px; padding: 0; }
    .admin-sidebar .sidebar-brand h2, .admin-sidebar .sidebar-brand p,
    .sidebar-nav a span, .sidebar-section-label, .sidebar-footer a span { display: none; }
    .sidebar-nav a { justify-content: center; padding: 14px; }
    .sidebar-brand { padding: 20px 16px; text-align: center; }
    .admin-main { margin-left: 72px; }
    .admin-content { padding: 20px; }
    .admin-topbar { padding: 16px 20px; }
}
</style>
</head>
<body>

    <%
    /* Checking the user credentials */
    String userName = (String) session.getAttribute("admin_username");
    String password = (String) session.getAttribute("admin_password");
    String userType = (String) session.getAttribute("admin_usertype");

    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    }

    else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }

    ProductServiceImpl prodDao = new ProductServiceImpl();
    List<ProductBean> products = new ArrayList<ProductBean>();

    String search = request.getParameter("search");
    String type = request.getParameter("type");
    String message = "All Products";
    if (search != null) {
        products = prodDao.searchAllProducts(search);
        message = "Showing Results for '" + search + "'";
    } else if (type != null) {
        products = prodDao.getAllProductsByType(type);
        message = "Showing Results for '" + type + "'";
    } else {
        products = prodDao.getAllProducts();
    }
    if (products.isEmpty()) {
        message = "No items found for the search '" + (search != null ? search : type) + "'";
        products = prodDao.getAllProducts();
    }
    %>

    <!-- ─── SIDEBAR ──────────────────────────────── -->
    <aside class="admin-sidebar">
        <div class="sidebar-brand">
            <h2>Ellison.</h2>
            <p>Admin Panel</p>
        </div>

        <nav class="sidebar-nav">
            <div class="sidebar-section-label">Main</div>
            <a href="adminViewProduct.jsp" class="active">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
                <span>Products</span>
            </a>
            <a href="adminStock.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                <span>Stock</span>
            </a>

            <div class="sidebar-section-label">Orders</div>
            <a href="unshippedItems.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                <span>Pending Orders</span>
            </a>
            <a href="shippedItems.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                <span>Shipped</span>
            </a>

            <div class="sidebar-section-label">Manage</div>
            <a href="addProduct.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
                <span>Add Product</span>
            </a>
            <a href="removeProduct.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                <span>Remove Product</span>
            </a>
            <a href="updateProductById.jsp">
                <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                <span>Update Product</span>
            </a>
        </nav>

        <div class="sidebar-footer">
            <a href="./LogoutSrv?role=admin">
                <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
                <span>Logout</span>
            </a>
        </div>
    </aside>

    <!-- ─── MAIN CONTENT ─────────────────────────── -->
    <main class="admin-main">

        <!-- Top Bar -->
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1>Products</h1>
                <p><%=products.size()%> products found</p>
            </div>
            <div class="topbar-right">
                <form method="get" action="adminViewProduct.jsp" style="margin:0;">
                    <div class="search-box">
                        <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
                        <input type="text" name="search" placeholder="Search products..." value="<%= search != null ? search : "" %>">
                        <button type="submit">
                            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                        </button>
                    </div>
                </form>
                <div class="admin-avatar">A</div>
            </div>
        </div>

        <!-- Content -->
        <div class="admin-content">
            <div class="content-message"><%=message%></div>

            <div class="data-table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product</th>
                            <th>ID</th>
                            <th>Info</th>
                            <th>Price</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (ProductBean product : products) {
                            String info = product.getProdInfo();
                            info = info.substring(0, Math.min(info.length(), 60)) + "...";
                        %>
                        <tr>
                            <td><img src="./ShowImage?pid=<%=product.getProdId()%>" alt="<%=product.getProdName()%>" class="prod-table-img"></td>
                            <td class="prod-name-cell"><%=product.getProdName()%></td>
                            <td class="prod-id-cell"><%=product.getProdId()%></td>
                            <td style="font-size:12px;color:var(--mid);max-width:200px;"><%=info%></td>
                            <td class="prod-price-cell">&#8377; <%=product.getProdPrice()%></td>
                            <td>
                                <div class="action-btns">
                                    <form method="post" style="display:inline;">
                                        <button type="submit" formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>" class="btn-action btn-action-edit">
                                            <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                                            Edit
                                        </button>
                                    </form>
                                    <form method="post" style="display:inline;">
                                        <button type="submit" formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>" class="btn-action btn-action-delete">
                                            <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                                            Delete
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <% } %>

                        <% if (products.isEmpty()) { %>
                        <tr>
                            <td colspan="6">
                                <div class="empty-table-state">
                                    <svg width="48" height="48" fill="none" stroke="#ccc" stroke-width="1" viewBox="0 0 24 24" style="margin-bottom:12px;"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/></svg>
                                    <p>No products available</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </main>

</body>
</html>