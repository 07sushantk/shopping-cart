<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Cart Details - Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
/* ─── RESET & BASE ─────────────────────────────── */
*,
*::before,
*::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

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
    --shadow: 0 8px 40px rgba(0, 0, 0, 0.08);
    --shadow-hover: 0 20px 60px rgba(0, 0, 0, 0.12);
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
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 48px;
    height: 72px;
    background: rgba(247, 244, 239, 0.88);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border-bottom: 1px solid rgba(184, 134, 11, 0.12);
}

.ee-brand {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 600;
    letter-spacing: 0.04em;
    color: var(--charcoal);
    text-decoration: none !important;
}

.ee-brand span {
    color: var(--accent);
}

.ee-nav-links {
    display: flex;
    gap: 36px;
    list-style: none;
    margin: 0;
}

.ee-nav-links a {
    font-size: 13px;
    font-weight: 400;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    color: var(--mid);
    text-decoration: none !important;
    position: relative;
    transition: color 0.25s;
}

.ee-nav-links a:hover {
    color: var(--charcoal);
}

.ee-nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.ee-icon-btn {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    background: var(--warm);
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: var(--charcoal);
    transition: background 0.25s, transform 0.2s;
    text-decoration: none !important;
}

.ee-icon-btn:hover {
    background: var(--accent2);
    color: var(--white);
    transform: scale(1.08);
}

/* ─── CART LAYOUT ────────────────────────────── */
.cart-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 20px 48px 80px;
    display: grid;
    grid-template-columns: 2fr 1fr;
    gap: 40px;
    flex: 1;
}

.cart-header {
    margin-bottom: 30px;
}

.cart-header h1 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 40px;
    font-weight: 300;
    color: var(--charcoal);
    margin: 0;
}

/* ─── CART ITEMS (LEFT) ───────────────────────── */
.cart-items-wrapper {
    display: flex;
    flex-direction: column;
    gap: 24px;
}

.cart-item-card {
    display: flex;
    background: var(--white);
    border-radius: var(--radius);
    padding: 24px;
    gap: 32px;
    box-shadow: 0 4px 24px rgba(0,0,0,0.04);
    position: relative;
    transition: box-shadow var(--transition), transform var(--transition);
}

.cart-item-card:hover {
    box-shadow: var(--shadow-hover);
    transform: translateY(-4px);
}

.item-img-container {
    width: 240px;
    height: 240px;
    background: var(--warm);
    border-radius: 12px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    flex-shrink: 0;
    transition: background 0.4s ease;
}

.cart-item-card:hover .item-img-container {
    background: #E8E2D5;
}

.item-img-container img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    mix-blend-mode: multiply; /* Helps transparent background blend */
    transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.cart-item-card:hover .item-img-container img {
    transform: scale(1.15);
}

.item-details {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.item-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 600;
    color: var(--charcoal);
    margin-bottom: 8px;
    line-height: 1.2;
}

.item-price {
    font-size: 20px;
    color: var(--accent);
    font-weight: 500;
    margin-bottom: 24px;
}

.item-price .currency {
    font-size: 14px;
    vertical-align: super;
}

/* Quantity Controls */
.qty-controls {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 24px;
}

.qty-btn {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: 1px solid var(--warm);
    background: var(--white);
    color: var(--charcoal);
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    text-decoration: none !important;
    transition: all 0.2s;
}

.qty-btn:hover {
    background: var(--charcoal);
    color: var(--white);
    border-color: var(--charcoal);
}

.qty-form {
    display: flex;
    align-items: center;
    background: var(--cream);
    border-radius: 50px;
    padding: 4px 6px;
}

.qty-input {
    width: 40px;
    border: none;
    background: transparent;
    text-align: center;
    font-family: 'DM Sans', sans-serif;
    font-size: 15px;
    font-weight: 500;
    color: var(--charcoal);
    -moz-appearance: textfield;
}

.qty-input::-webkit-outer-spin-button,
.qty-input::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

.update-btn {
    background: transparent;
    border: none;
    font-size: 12px;
    font-weight: 500;
    color: var(--mid);
    text-transform: uppercase;
    letter-spacing: 0.05em;
    padding: 0 10px;
    cursor: pointer;
    transition: color 0.2s;
}

.update-btn:hover {
    color: var(--accent);
}

.item-actions {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-top: auto;
    padding-top: 20px;
    border-top: 1px solid var(--warm);
}

.item-total {
    font-size: 15px;
    color: var(--mid);
    font-weight: 500;
}

.item-total span {
    color: var(--charcoal);
    font-size: 18px;
    font-weight: 600;
    margin-left: 4px;
}

.remove-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: #A93226;
    font-size: 13px;
    font-weight: 500;
    text-decoration: none !important;
    transition: opacity 0.2s;
}

.remove-btn:hover {
    opacity: 0.7;
    color: #A93226;
}

/* ─── ORDER SUMMARY (RIGHT) ───────────────────── */
.summary-wrapper {
    position: sticky;
    top: 100px;
    background: var(--white);
    border-radius: var(--radius-lg);
    padding: 40px;
    box-shadow: 0 4px 30px rgba(0,0,0,0.06);
    height: fit-content;
}

.summary-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 28px;
    font-weight: 600;
    color: var(--charcoal);
    margin-bottom: 24px;
    border-bottom: 1px solid var(--warm);
    padding-bottom: 16px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 16px;
    font-size: 15px;
    color: var(--mid);
}

.summary-total {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 24px;
    padding-top: 24px;
    border-top: 1px solid var(--warm);
    font-size: 18px;
    font-weight: 500;
    color: var(--charcoal);
}

.summary-total span {
    font-size: 26px;
    color: var(--accent);
    font-weight: 600;
}

.summary-actions {
    margin-top: 40px;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.btn-ee-primary {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    background: var(--charcoal);
    color: var(--white) !important;
    border: none;
    border-radius: 50px;
    padding: 16px;
    font-size: 14px;
    font-weight: 500;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    cursor: pointer;
    transition: background 0.3s, transform 0.2s;
    text-decoration: none !important;
}

.btn-ee-primary:hover {
    background: var(--accent);
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(184, 134, 11, 0.2);
}

.btn-ee-cancel {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    background: transparent;
    color: var(--mid) !important;
    border: 1px solid var(--mid);
    border-radius: 50px;
    padding: 14px;
    font-size: 13px;
    font-weight: 500;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    cursor: pointer;
    transition: all 0.3s;
    text-decoration: none !important;
}

.btn-ee-cancel:hover {
    border-color: var(--charcoal);
    color: var(--charcoal) !important;
    background: rgba(0,0,0,0.03);
}

.empty-cart-msg {
    grid-column: 1 / -1;
    text-align: center;
    padding: 80px 20px;
    background: var(--white);
    border-radius: var(--radius-lg);
}

.empty-cart-msg h2 {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    color: var(--charcoal);
    margin-bottom: 16px;
}

.empty-cart-msg p {
    color: var(--mid);
    margin-bottom: 32px;
}

/* ─── FOOTER ───────────────────────────────────── */
.ee-footer {
    background: var(--charcoal);
    color: rgba(255, 255, 255, 0.55);
    padding: 56px 48px 32px;
    margin-top: auto;
}

.ee-footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr 1fr;
    gap: 48px;
    margin-bottom: 48px;
}

.ee-footer-brand {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 600;
    color: var(--white);
    letter-spacing: 0.04em;
    margin-bottom: 14px;
}

.ee-footer-brand span {
    color: var(--accent2);
}

.ee-footer p {
    font-size: 13px;
    line-height: 1.7;
    max-width: 260px;
}

.ee-footer-col h4 {
    font-size: 11px;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--white);
    margin-bottom: 18px;
}

.ee-footer-col ul {
    list-style: none;
    padding: 0;
}

.ee-footer-col ul li {
    margin-bottom: 10px;
}

.ee-footer-col ul li a {
    font-size: 13px;
    color: rgba(255, 255, 255, 0.45);
    text-decoration: none !important;
    transition: color 0.25s;
}

.ee-footer-col ul li a:hover {
    color: var(--accent2);
}

.ee-footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.08);
    padding-top: 28px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 12px;
}

@media (max-width: 992px) {
    .cart-container {
        grid-template-columns: 1fr;
    }
    
    .item-img-container {
        width: 160px;
        height: 160px;
    }
}

@media (max-width: 768px) {
    .cart-item-card {
        flex-direction: column;
        gap: 20px;
    }
    
    .item-img-container {
        width: 100%;
        height: 240px;
    }
    
    .ee-footer-grid {
        grid-template-columns: 1fr 1fr;
    }
    
    .ee-navbar {
        padding: 0 20px;
    }
    .cart-container {
        padding: 20px;
    }
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
    }

    String addS = request.getParameter("add");
    if (addS != null) {
        int add = Integer.parseInt(addS);
        String uid = request.getParameter("uid");
        String pid = request.getParameter("pid");
        int avail = Integer.parseInt(request.getParameter("avail"));
        int cartQty = Integer.parseInt(request.getParameter("qty"));
        CartServiceImpl cartService = new CartServiceImpl();

        if (add == 1) {
            cartQty += 1;
            if (cartQty <= avail) {
                cartService.addProductToCart(uid, pid, 1);
            } else {
                response.sendRedirect("./AddtoCart?pid=" + pid + "&pqty=" + cartQty);
            }
        } else if (add == 0) {
            cartService.removeProductFromCart(uid, pid);
        }
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
            <li><a href="userHome.jsp?type=speaker">Speakers</a></li>
        </ul>

        <div class="ee-nav-right">
            <a href="cartDetails.jsp" class="ee-icon-btn" title="Cart">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" />
                    <line x1="3" y1="6" x2="21" y2="6" />
                    <path d="M16 10a4 4 0 0 1-8 0" />
                </svg>
            </a>
            <a href="userProfile.jsp" class="ee-icon-btn" title="Profile">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                    <circle cx="12" cy="7" r="4" />
                </svg>
            </a>
            <a href="./LogoutSrv" class="ee-icon-btn" title="Logout">
                <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                    <polyline points="16 17 21 12 16 7" />
                    <line x1="21" y1="12" x2="9" y2="12" />
                </svg>
            </a>
        </div>
    </nav>

    <!-- ─── CART LAYOUT ────────────────────────────── -->
    <div class="cart-container">
        
        <%
        CartServiceImpl cart = new CartServiceImpl();
        List<CartBean> cartItems = cart.getAllCartItems(userName);
        double totAmount = 0;
        int totalItems = 0;

        if (cartItems != null && !cartItems.isEmpty()) {
        %>
        
        <!-- LEFT: Cart Items -->
        <div>
            <div class="cart-header">
                <h1>Shopping Cart</h1>
            </div>
            
            <div class="cart-items-wrapper">
                <%
                for (CartBean item : cartItems) {
                    String prodId = item.getProdId();
                    int prodQuantity = item.getQuantity();
                    ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
                    
                    if (prodQuantity > 0) {
                        double currAmount = product.getProdPrice() * prodQuantity;
                        totAmount += currAmount;
                        totalItems += prodQuantity;
                %>
                
                <div class="cart-item-card">
                    <!-- Left Side: Large Image -->
                    <div class="item-img-container">
                        <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="<%=product.getProdName()%>">
                    </div>
                    
                    <!-- Right Side: Details -->
                    <div class="item-details">
                        <div class="item-name"><%=product.getProdName()%></div>
                        <div class="item-price"><span class="currency">&#8377;</span><%=product.getProdPrice()%></div>
                        
                        <div class="qty-controls">
                            <a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="qty-btn" title="Decrease">
                                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            </a>
                            
                            <form method="post" action="./UpdateToCart" class="qty-form">
                                <input type="number" name="pqty" value="<%=prodQuantity%>" class="qty-input" min="0" max="<%=product.getProdQuantity()%>">
                                <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                                <button type="submit" name="Update" class="update-btn">Save</button>
                            </form>
                            
                            <a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="qty-btn" title="Increase">
                                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
                            </a>
                        </div>
                        
                        <div class="item-actions">
                            <a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=1" class="remove-btn" title="Remove Item">
                                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path><line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line></svg>
                                Remove
                            </a>
                            <div class="item-total">
                                Total: <span><span class="currency">&#8377;</span><%=currAmount%></span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <%
                    }
                }
                %>
            </div>
        </div>
        
        <!-- RIGHT: Order Summary -->
        <div>
            <div class="summary-wrapper">
                <h2 class="summary-title">Order Summary</h2>
                
                <div class="summary-row">
                    <span>Subtotal (<%=totalItems%> items)</span>
                    <span>&#8377; <%=totAmount%></span>
                </div>
                <div class="summary-row">
                    <span>Estimated Shipping</span>
                    <span>Free</span>
                </div>
                
                <div class="summary-total">
                    Total
                    <span><span style="font-size: 16px;">&#8377;</span> <%=totAmount%></span>
                </div>
                
                <div class="summary-actions">
                    <form method="post" action="payment.jsp?amount=<%=totAmount%>">
                        <button type="submit" class="btn-ee-primary">
                            Proceed to Checkout
                            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24" style="margin-left:8px;">
                                <line x1="5" y1="12" x2="19" y2="12" />
                                <polyline points="12 5 19 12 12 19" />
                            </svg>
                        </button>
                    </form>
                    
                    <a href="userHome.jsp" class="btn-ee-cancel">Continue Shopping</a>
                </div>
            </div>
        </div>
        
        <%
        } else {
        %>
        
        <!-- Empty Cart -->
        <div class="empty-cart-msg">
            <h2>Your Cart is Empty</h2>
            <p>Looks like you haven't added anything to your cart yet.</p>
            <a href="userHome.jsp" class="btn-ee-primary" style="display: inline-flex; width: auto; padding: 14px 32px;">
                Start Shopping
            </a>
        </div>
        
        <%
        }
        %>
        
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
                <ul>
                    <li><a href="#">Help &amp; Contact Us</a></li>
                    <li><a href="#">Orders &amp; Shipping</a></li>
                    <li><a href="#">Payment</a></li>
                    <li><a href="#">Returns &amp; Refunds</a></li>
                    <li><a href="#">FAQs</a></li>
                </ul>
            </div>
            <div class="ee-footer-col">
                <h4>About Us</h4>
                <ul>
                    <li><a href="#">About us</a></li>
                    <li><a href="#">Showrooms</a></li>
                    <li><a href="#">Shops</a></li>
                </ul>
            </div>
            <div class="ee-footer-col">
                <h4>Legal</h4>
                <ul>
                    <li><a href="#">Terms &amp; Conditions</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Cookies Policy</a></li>
                </ul>
            </div>
        </div>
        <div class="ee-footer-bottom">
            <span>&copy; 2024 Ellison Electronics. All rights reserved.</span>
            <span>Made with care for tech lovers.</span>
        </div>
    </footer>

</body>
</html>