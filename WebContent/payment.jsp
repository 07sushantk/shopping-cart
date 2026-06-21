<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Payment - Ellison Electronics</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">

<style>
/* ─── RESET & BASE ─────────────────────────────── */
*, *::before, *::after {
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
    --transition: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

body {
    font-family: 'DM Sans', sans-serif;
    color: var(--charcoal);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #1a0533 0%, #2d1b69 25%, #4a2c8a 50%, #6b3fa0 75%, #8b5fbf 100%);
    padding: 40px 20px;
    position: relative;
    overflow: hidden;
}

/* Ambient background blobs */
body::before {
    content: '';
    position: fixed;
    top: -200px;
    left: -200px;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(139, 92, 246, 0.4) 0%, transparent 70%);
    border-radius: 50%;
    animation: floatBlob1 12s ease-in-out infinite;
}

body::after {
    content: '';
    position: fixed;
    bottom: -200px;
    right: -200px;
    width: 500px;
    height: 500px;
    background: radial-gradient(circle, rgba(236, 72, 153, 0.3) 0%, transparent 70%);
    border-radius: 50%;
    animation: floatBlob2 10s ease-in-out infinite;
}

@keyframes floatBlob1 {
    0%, 100% { transform: translate(0, 0) scale(1); }
    33% { transform: translate(80px, 60px) scale(1.1); }
    66% { transform: translate(-40px, 100px) scale(0.95); }
}

@keyframes floatBlob2 {
    0%, 100% { transform: translate(0, 0) scale(1); }
    33% { transform: translate(-60px, -80px) scale(1.05); }
    66% { transform: translate(50px, -40px) scale(1.1); }
}

/* ─── PAYMENT CARD CONTAINER ──────────────────── */
.payment-container {
    display: grid;
    grid-template-columns: 1fr 1.1fr;
    max-width: 960px;
    width: 100%;
    min-height: 600px;
    border-radius: var(--radius-lg);
    overflow: hidden;
    box-shadow: 0 32px 80px rgba(0, 0, 0, 0.35);
    position: relative;
    z-index: 1;
    animation: cardAppear 0.8s ease-out;
}

@keyframes cardAppear {
    from {
        opacity: 0;
        transform: translateY(30px) scale(0.97);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

/* ─── LEFT PANEL (Card Visuals) ───────────────── */
.payment-left {
    background: linear-gradient(160deg, #1a0a3e 0%, #2d1769 40%, #4a2c8a 100%);
    padding: 48px 40px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

/* Decorative circles */
.payment-left::before {
    content: '';
    position: absolute;
    top: -60px;
    right: -60px;
    width: 200px;
    height: 200px;
    border-radius: 50%;
    background: rgba(139, 92, 246, 0.2);
}

.payment-left::after {
    content: '';
    position: absolute;
    bottom: -40px;
    left: -40px;
    width: 160px;
    height: 160px;
    border-radius: 50%;
    background: rgba(236, 72, 153, 0.15);
}

/* Floating Credit Cards */
.cards-stack {
    position: relative;
    width: 320px;
    height: 380px;
    margin-bottom: 24px;
}

.credit-card {
    position: absolute;
    width: 280px;
    height: 170px;
    border-radius: 16px;
    padding: 24px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
}

.credit-card:nth-child(1) {
    background: linear-gradient(135deg, rgba(255,255,255,0.15) 0%, rgba(255,255,255,0.05) 100%);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255,255,255,0.15);
    top: 0;
    left: 20px;
    transform: rotate(-8deg);
    z-index: 1;
}

.credit-card:nth-child(2) {
    background: linear-gradient(135deg, rgba(139,92,246,0.4) 0%, rgba(79,70,229,0.3) 100%);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255,255,255,0.12);
    top: 80px;
    left: 0;
    transform: rotate(-3deg);
    z-index: 2;
}

.credit-card:nth-child(3) {
    background: linear-gradient(135deg, rgba(236,72,153,0.35) 0%, rgba(139,92,246,0.3) 100%);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255,255,255,0.1);
    top: 170px;
    left: 10px;
    transform: rotate(2deg);
    z-index: 3;
}

.cards-stack:hover .credit-card:nth-child(1) {
    transform: rotate(-12deg) translateY(-10px);
}
.cards-stack:hover .credit-card:nth-child(2) {
    transform: rotate(0deg) translateY(-5px);
}
.cards-stack:hover .credit-card:nth-child(3) {
    transform: rotate(5deg) translateY(-10px);
}

.card-chip {
    width: 40px;
    height: 28px;
    border-radius: 6px;
    background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, rgba(255,255,255,0.1) 100%);
    border: 1px solid rgba(255,255,255,0.15);
}

.card-number {
    font-size: 14px;
    letter-spacing: 0.2em;
    color: rgba(255,255,255,0.7);
    font-weight: 300;
}

.card-bottom {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
}

.card-holder {
    font-size: 10px;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    color: rgba(255,255,255,0.5);
    line-height: 1.4;
}

.card-holder span {
    display: block;
    font-size: 12px;
    color: rgba(255,255,255,0.8);
    font-weight: 500;
}

.card-brand {
    font-size: 18px;
    font-weight: 700;
    font-style: italic;
    color: rgba(255,255,255,0.6);
}

.left-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 26px;
    font-weight: 300;
    color: rgba(255,255,255,0.9);
    text-align: center;
    z-index: 2;
    margin-top: 12px;
}

.left-subtitle {
    font-size: 13px;
    color: rgba(255,255,255,0.45);
    text-align: center;
    z-index: 2;
    margin-top: 6px;
}

/* ─── RIGHT PANEL (Form) ─────────────────────── */
.payment-right {
    background: var(--white);
    padding: 48px 44px;
    display: flex;
    flex-direction: column;
}

.form-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    font-weight: 600;
    color: var(--charcoal);
    margin-bottom: 8px;
}

.form-subtitle {
    font-size: 14px;
    color: var(--mid);
    margin-bottom: 32px;
}

/* Payment method pills */
.pay-methods {
    display: flex;
    gap: 10px;
    margin-bottom: 32px;
}

.pay-pill {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 16px;
    border: 1px solid var(--warm);
    border-radius: 50px;
    font-size: 12px;
    font-weight: 500;
    color: var(--mid);
    cursor: pointer;
    transition: all 0.25s;
    background: transparent;
}

.pay-pill:hover, .pay-pill.active {
    border-color: #6b3fa0;
    color: #6b3fa0;
    background: rgba(107, 63, 160, 0.06);
}

.pay-pill svg {
    width: 16px;
    height: 16px;
}

/* Form Fields */
.form-row {
    display: flex;
    gap: 16px;
    margin-bottom: 20px;
}

.form-group {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-size: 12px;
    font-weight: 500;
    color: var(--mid);
    text-transform: uppercase;
    letter-spacing: 0.06em;
    margin-bottom: 8px;
}

.form-group input {
    border: 1px solid var(--warm);
    border-radius: 12px;
    padding: 14px 16px;
    font-family: 'DM Sans', sans-serif;
    font-size: 15px;
    color: var(--charcoal);
    outline: none;
    transition: border-color 0.3s, box-shadow 0.3s;
    background: var(--cream);
    width: 100%;
}

.form-group input::placeholder {
    color: #bbb;
}

.form-group input:focus {
    border-color: #6b3fa0;
    box-shadow: 0 0 0 3px rgba(107, 63, 160, 0.1);
    background: var(--white);
}

/* Amount Display */
.total-display {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 24px 0;
    padding: 20px 0;
    border-top: 1px solid var(--warm);
    border-bottom: 1px solid var(--warm);
}

.total-label {
    font-size: 15px;
    font-weight: 500;
    color: var(--mid);
}

.total-amount {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    font-weight: 600;
    color: #6b3fa0;
}

.total-amount .currency {
    font-size: 18px;
    vertical-align: super;
}

/* Pay Button */
.btn-pay {
    width: 100%;
    border: none;
    border-radius: 14px;
    padding: 18px;
    font-family: 'DM Sans', sans-serif;
    font-size: 15px;
    font-weight: 600;
    letter-spacing: 0.04em;
    color: var(--white);
    cursor: pointer;
    background: linear-gradient(135deg, #6b3fa0 0%, #8b5fbf 50%, #a855f7 100%);
    background-size: 200% 200%;
    transition: all 0.4s ease;
    box-shadow: 0 8px 24px rgba(107, 63, 160, 0.35);
    margin-top: 16px;
    position: relative;
    overflow: hidden;
}

.btn-pay::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
    transition: left 0.5s;
}

.btn-pay:hover {
    background-position: 100% 0;
    transform: translateY(-2px);
    box-shadow: 0 12px 32px rgba(107, 63, 160, 0.45);
}

.btn-pay:hover::before {
    left: 100%;
}

.btn-pay:active {
    transform: translateY(0);
}

/* Back to Cart link */
.back-link {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    color: var(--mid);
    text-decoration: none !important;
    margin-top: 20px;
    transition: color 0.25s;
    align-self: center;
}

.back-link:hover {
    color: #6b3fa0;
}

/* Security badge */
.security-badge {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 11px;
    color: var(--mid);
    margin-top: auto;
    padding-top: 20px;
    justify-content: center;
}

.security-badge svg {
    color: #22c55e;
}

/* ─── RESPONSIVE ──────────────────────────────── */
@media (max-width: 768px) {
    .payment-container {
        grid-template-columns: 1fr;
        max-width: 480px;
    }
    
    .payment-left {
        padding: 32px 24px;
    }
    
    .cards-stack {
        width: 260px;
        height: 320px;
        transform: scale(0.85);
    }
    
    .payment-right {
        padding: 32px 24px;
    }
    
    .pay-methods {
        flex-wrap: wrap;
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
        return;
    }

    String sAmount = request.getParameter("amount");
    double amount = 0;
    if (sAmount != null) {
        amount = Double.parseDouble(sAmount);
    }
    %>

    <div class="payment-container">

        <!-- ─── LEFT: Card Visuals ─────────────────────── -->
        <div class="payment-left">
            <div class="cards-stack">
                <!-- Card 1 -->
                <div class="credit-card">
                    <div class="card-chip"></div>
                    <div class="card-number">4455 &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; 8914</div>
                    <div class="card-bottom">
                        <div class="card-holder">
                            Card Holder
                            <span>Your Name</span>
                        </div>
                        <div class="card-brand">VISA</div>
                    </div>
                </div>
                <!-- Card 2 -->
                <div class="credit-card">
                    <div class="card-chip"></div>
                    <div class="card-number">5412 &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; 3467</div>
                    <div class="card-bottom">
                        <div class="card-holder">
                            Card Holder
                            <span>Your Name</span>
                        </div>
                        <div class="card-brand">VISA</div>
                    </div>
                </div>
                <!-- Card 3 -->
                <div class="credit-card">
                    <div class="card-chip"></div>
                    <div class="card-number">3782 &bull;&bull;&bull;&bull; &bull;&bull;&bull;&bull; 0005</div>
                    <div class="card-bottom">
                        <div class="card-holder">
                            Card Holder
                            <span>Your Name</span>
                        </div>
                        <div class="card-brand">MC</div>
                    </div>
                </div>
            </div>
            <div class="left-title">Secure Payment Gateway</div>
            <div class="left-subtitle">Your transaction is encrypted and secure</div>
        </div>

        <!-- ─── RIGHT: Payment Form ───────────────────── -->
        <div class="payment-right">
            <h1 class="form-title">Payment Details</h1>
            <p class="form-subtitle">Complete your purchase securely</p>

            <!-- Payment Method Pills -->
            <div class="pay-methods">
                <div class="pay-pill active">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                    Credit Card
                </div>
                <div class="pay-pill">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20z"/><path d="M2 12h20"/></svg>
                    Google Pay
                </div>
                <div class="pay-pill">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83"/><path d="M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/></svg>
                    Apple Pay
                </div>
            </div>

            <!-- Form -->
            <form action="./OrderServlet" method="post" id="paymentForm">
                <input type="hidden" name="amount" value="<%=amount%>">

                <div class="form-row">
                    <div class="form-group">
                        <label for="cardnumber">Card Number</label>
                        <input type="text" id="cardnumber" name="cardnumber" placeholder="4242  4242  4242  4242" maxlength="19" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="cardholder">Card Holder Name</label>
                        <input type="text" id="cardholder" name="cardholder" placeholder="John Doe" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="expmonth">Expiry Date</label>
                        <input type="text" id="expmonth" name="expmonth" placeholder="MM / YY" maxlength="7" required>
                    </div>
                    <div class="form-group">
                        <label for="cvv">CVV/CVC</label>
                        <input type="password" id="cvv" name="cvv" placeholder="&bull;&bull;&bull;" maxlength="4" required>
                    </div>
                </div>

                <div class="total-display">
                    <span class="total-label">Total Amount</span>
                    <span class="total-amount"><span class="currency">&#8377;</span><%=amount%></span>
                </div>

                <button type="submit" class="btn-pay">
                    Pay &#8377; <%=amount%>
                </button>
            </form>

            <a href="cartDetails.jsp" class="back-link">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="19 12 5 12"/><polyline points="12 19 5 12 12 5"/></svg>
                Back to Cart
            </a>

            <div class="security-badge">
                <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                SSL Encrypted &bull; 100% Secure Payment
            </div>
        </div>

    </div>

    <script>
        // Card number formatting (add spaces every 4 digits)
        document.getElementById('cardnumber').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formatted = value.match(/.{1,4}/g);
            e.target.value = formatted ? formatted.join('  ') : '';
        });

        // Expiry date formatting (MM / YY)
        document.getElementById('expmonth').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '').replace('/', '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + ' / ' + value.substring(2, 4);
            }
            e.target.value = value;
        });

        // Payment pill selection
        document.querySelectorAll('.pay-pill').forEach(function(pill) {
            pill.addEventListener('click', function() {
                document.querySelectorAll('.pay-pill').forEach(function(p) { p.classList.remove('active'); });
                this.classList.add('active');
            });
        });
    </script>

</body>
</html>