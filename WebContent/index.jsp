<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*" %>
		<!DOCTYPE html>
		<html>

		<head>
			<title>Ellison Electronics - Premium Electronics Store</title>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1">
			<meta name="description"
				content="Ellison Electronics - Your premium destination for electronics. Shop mobiles, laptops, TVs, cameras and more.">
			<link rel="preconnect" href="https://fonts.googleapis.com">
			<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
			<link
				href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,300&family=DM+Sans:wght@300;400;500&display=swap"
				rel="stylesheet">
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
					--shadow: 0 8px 40px rgba(0, 0, 0, 0.10);
					--shadow-hover: 0 20px 60px rgba(0, 0, 0, 0.18);
					--transition: 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
				}

				html {
					scroll-behavior: smooth;
				}

				body {
					background-color: var(--cream);
					font-family: 'DM Sans', sans-serif;
					color: var(--charcoal);
					overflow-x: hidden;
					padding-top: 72px;
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
					transition: background var(--transition);
				}

				.ee-navbar.scrolled {
					background: rgba(247, 244, 239, 0.98);
					box-shadow: 0 2px 24px rgba(0, 0, 0, 0.07);
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

				.ee-nav-links a::after {
					content: '';
					position: absolute;
					bottom: -4px;
					left: 0;
					width: 0;
					height: 1px;
					background: var(--accent);
					transition: width 0.3s;
				}

				.ee-nav-links a:hover {
					color: var(--charcoal);
				}

				.ee-nav-links a:hover::after {
					width: 100%;
				}

				.ee-nav-right {
					display: flex;
					align-items: center;
					gap: 20px;
				}

				.ee-search-wrap {
					display: flex;
					align-items: center;
					background: var(--warm);
					border-radius: 50px;
					padding: 8px 16px;
					gap: 8px;
					border: 1px solid transparent;
					transition: border-color 0.25s;
				}

				.ee-search-wrap:focus-within {
					border-color: var(--accent2);
				}

				.ee-search-wrap input {
					border: none;
					background: transparent;
					font-size: 13px;
					font-family: 'DM Sans', sans-serif;
					color: var(--charcoal);
					outline: none;
					width: 160px;
				}

				.ee-search-wrap button {
					border: none;
					background: none;
					cursor: pointer;
					color: var(--mid);
					padding: 0;
					display: flex;
					align-items: center;
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

				/* ─── HERO CAROUSEL ────────────────────────────── */
				.hero-section {
					padding: 40px 48px 0;
				}

				.hero-carousel-wrap {
					position: relative;
					border-radius: var(--radius-lg);
					overflow: hidden;
					height: 520px;
					background: var(--warm);
					box-shadow: var(--shadow);
				}

				.hero-carousel-wrap .carousel {
					height: 100%;
				}

				.hero-carousel-wrap .carousel-inner {
					height: 100%;
				}

				.hero-carousel-wrap .item {
					height: 100%;
					align-items: center;
					padding: 60px 72px;
					position: relative;
					overflow: hidden;
				}

				.hero-carousel-wrap .item.active,
				.hero-carousel-wrap .item.next,
				.hero-carousel-wrap .item.prev {
					display: flex !important;
				}

				.hero-slide-bg {
					position: absolute;
					inset: 0;
					width: 100%;
					height: 100%;
					object-fit: cover;
					background-size: cover;
					background-position: center;
					filter: brightness(0.70);
					transition: transform 8s ease;
				}

				.hero-carousel-wrap .item.active .hero-slide-bg {
					transform: scale(1.06);
				}

				.hero-content {
					position: relative;
					z-index: 2;
					max-width: 520px;
				}

				.hero-tag {
					display: inline-block;
					font-size: 11px;
					font-weight: 500;
					letter-spacing: 0.14em;
					text-transform: uppercase;
					color: var(--accent2);
					background: rgba(212, 168, 67, 0.15);
					border: 1px solid rgba(212, 168, 67, 0.35);
					padding: 5px 14px;
					border-radius: 50px;
					margin-bottom: 20px;
				}

				.hero-title {
					font-family: 'Cormorant Garamond', serif;
					font-size: 58px;
					font-weight: 300;
					line-height: 1.08;
					color: var(--white);
					margin-bottom: 18px;
					letter-spacing: -0.01em;
				}

				.hero-title em {
					font-style: italic;
					color: var(--accent2);
				}

				.hero-desc {
					font-size: 15px;
					color: rgba(255, 255, 255, 0.72);
					line-height: 1.6;
					margin-bottom: 36px;
					max-width: 380px;
				}

				.hero-cta {
					display: inline-flex;
					align-items: center;
					gap: 10px;
					background: var(--accent);
					color: var(--white);
					font-size: 13px;
					font-weight: 500;
					letter-spacing: 0.05em;
					text-transform: uppercase;
					padding: 14px 32px;
					border-radius: 50px;
					text-decoration: none !important;
					border: none;
					cursor: pointer;
					transition: background 0.25s, transform 0.2s, box-shadow 0.25s;
					box-shadow: 0 4px 20px rgba(184, 134, 11, 0.35);
				}

				.hero-cta:hover {
					background: var(--accent2);
					transform: translateY(-2px);
					box-shadow: 0 8px 28px rgba(184, 134, 11, 0.45);
					color: var(--white);
				}

				.carousel-control {
					width: 48px;
					height: 48px;
					background: rgba(255, 255, 255, 0.15) !important;
					backdrop-filter: blur(8px);
					border-radius: 50% !important;
					top: 50%;
					transform: translateY(-50%);
					display: flex;
					align-items: center;
					justify-content: center;
					opacity: 1 !important;
					transition: background 0.25s;
				}

				.carousel-control:hover {
					background: rgba(184, 134, 11, 0.6) !important;
				}

				.carousel-control.left {
					left: 20px;
				}

				.carousel-control.right {
					right: 20px;
				}

				.carousel-control .glyphicon {
					font-size: 14px;
				}

				.carousel-indicators li {
					background: rgba(255, 255, 255, 0.4);
					border: none;
					width: 6px;
					height: 6px;
					margin: 0 4px;
					border-radius: 50%;
				}

				.carousel-indicators .active {
					background: var(--accent2);
					width: 22px;
					border-radius: 10px;
				}

				/* ─── SECTION TITLES ───────────────────────────── */
				.section-label {
					font-size: 11px;
					font-weight: 500;
					letter-spacing: 0.16em;
					text-transform: uppercase;
					color: var(--accent);
					margin-bottom: 8px;
				}

				.section-title {
					font-family: 'Cormorant Garamond', serif;
					font-size: 40px;
					font-weight: 300;
					color: var(--charcoal);
					line-height: 1.15;
				}

				.section-header {
					display: flex;
					align-items: flex-end;
					justify-content: space-between;
					margin-bottom: 36px;
				}

				.view-all-link {
					font-size: 12px;
					font-weight: 500;
					letter-spacing: 0.08em;
					text-transform: uppercase;
					color: var(--mid);
					text-decoration: none !important;
					border-bottom: 1px solid var(--mid);
					padding-bottom: 2px;
					transition: color 0.25s, border-color 0.25s;
				}

				.view-all-link:hover {
					color: var(--accent);
					border-color: var(--accent);
				}

				/* ─── CATEGORIES GRID ──────────────────────────── */
				.categories-section {
					padding: 80px 48px;
				}

				.categories-grid {
					display: grid;
					grid-template-columns: 2fr 1fr 1fr;
					grid-template-rows: 260px 260px;
					gap: 16px;
				}

				.cat-card {
					position: relative;
					border-radius: var(--radius);
					overflow: hidden;
					cursor: pointer;
					background: var(--warm);
				}

				.cat-card:first-child {
					grid-row: 1 / 3;
				}

				.cat-card-img {
					width: 100%;
					height: 100%;
					object-fit: cover;
					transition: transform var(--transition);
				}

				.cat-card-overlay {
					position: absolute;
					inset: 0;
					background: linear-gradient(to top, rgba(28, 28, 30, 0.72) 0%, rgba(28, 28, 30, 0.1) 55%, transparent 100%);
					transition: background var(--transition);
				}

				.cat-card:hover .cat-card-overlay {
					background: linear-gradient(to top, rgba(28, 28, 30, 0.84) 0%, rgba(28, 28, 30, 0.35) 55%, transparent 100%);
				}

				.cat-card:hover .cat-card-img {
					transform: scale(1.06);
				}

				.cat-card-label {
					position: absolute;
					bottom: 22px;
					left: 24px;
					font-size: 18px;
					font-weight: 500;
					color: var(--white);
					font-family: 'Cormorant Garamond', serif;
					font-style: italic;
					letter-spacing: 0.02em;
				}

				.cat-card-link {
					position: absolute;
					inset: 0;
					z-index: 2;
				}

				/* ─── SEARCH RESULT HEADER ─────────────────────── */
				.result-bar {
					padding: 16px 48px;
					font-size: 13px;
					color: var(--mid);
					letter-spacing: 0.04em;
				}

				.result-bar span {
					color: var(--charcoal);
					font-weight: 500;
				}

				/* ─── PRODUCT GRID ─────────────────────────────── */
				.products-section {
					padding: 0 48px 80px;
				}

				.products-grid {
					display: grid;
					grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
					gap: 24px;
				}

				/* ─── PRODUCT CARD ─────────────────────────────── */
				.prod-card {
					background: var(--white);
					border-radius: var(--radius);
					overflow: hidden;
					box-shadow: 0 2px 16px rgba(0, 0, 0, 0.06);
					transition: box-shadow var(--transition), transform var(--transition);
					position: relative;
				}

				.prod-card:hover {
					box-shadow: var(--shadow-hover);
					transform: translateY(-6px);
				}

				.prod-img-wrap {
					position: relative;
					height: 220px;
					background: var(--warm);
					overflow: hidden;
				}

				.prod-img-wrap img {
					width: 100%;
					height: 100%;
					object-fit: contain;
					padding: 20px;
					transition: transform var(--transition);
				}

				.prod-card:hover .prod-img-wrap img {
					transform: scale(1.07);
				}

				/* Hover overlay with actions */
				.prod-hover-overlay {
					position: absolute;
					inset: 0;
					background: rgba(28, 28, 30, 0.55);
					backdrop-filter: blur(4px);
					display: flex;
					flex-direction: column;
					align-items: center;
					justify-content: center;
					gap: 10px;
					opacity: 0;
					transition: opacity 0.35s;
					padding: 24px;
				}

				.prod-card:hover .prod-hover-overlay {
					opacity: 1;
				}

				.prod-hover-title {
					font-family: 'Cormorant Garamond', serif;
					font-size: 18px;
					color: var(--white);
					text-align: center;
					margin-bottom: 4px;
				}

				.prod-hover-price {
					font-size: 15px;
					color: var(--accent2);
					font-weight: 500;
					margin-bottom: 10px;
				}

				.prod-hover-desc {
					font-size: 12px;
					color: rgba(255, 255, 255, 0.72);
					text-align: center;
					line-height: 1.5;
					margin-bottom: 12px;
				}

				.prod-hover-btns {
					display: flex;
					gap: 10px;
					flex-wrap: wrap;
					justify-content: center;
				}

				.btn-ee-primary {
					display: inline-flex;
					align-items: center;
					gap: 6px;
					background: var(--accent);
					color: var(--white) !important;
					border: none;
					border-radius: 50px;
					padding: 9px 20px;
					font-size: 12px;
					font-weight: 500;
					font-family: 'DM Sans', sans-serif;
					letter-spacing: 0.04em;
					cursor: pointer;
					transition: background 0.25s, transform 0.2s;
					text-decoration: none !important;
				}

				.btn-ee-primary:hover {
					background: var(--accent2);
					transform: scale(1.04);
					color: var(--white) !important;
				}

				.btn-ee-secondary {
					display: inline-flex;
					align-items: center;
					gap: 6px;
					background: transparent;
					color: var(--white) !important;
					border: 1px solid rgba(255, 255, 255, 0.55);
					border-radius: 50px;
					padding: 9px 20px;
					font-size: 12px;
					font-weight: 500;
					font-family: 'DM Sans', sans-serif;
					letter-spacing: 0.04em;
					cursor: pointer;
					transition: background 0.25s, border-color 0.25s;
					text-decoration: none !important;
				}

				.btn-ee-secondary:hover {
					background: rgba(255, 255, 255, 0.15);
					border-color: white;
					color: var(--white) !important;
				}

				.btn-ee-danger {
					display: inline-flex;
					align-items: center;
					gap: 6px;
					background: #C0392B;
					color: var(--white) !important;
					border: none;
					border-radius: 50px;
					padding: 9px 20px;
					font-size: 12px;
					font-weight: 500;
					font-family: 'DM Sans', sans-serif;
					letter-spacing: 0.04em;
					cursor: pointer;
					transition: background 0.25s;
					text-decoration: none !important;
				}

				.btn-ee-danger:hover {
					background: #A93226;
					color: var(--white) !important;
				}

				/* Card bottom info */
				.prod-info {
					padding: 18px 20px 20px;
				}

				.prod-name {
					font-family: 'Cormorant Garamond', serif;
					font-size: 17px;
					font-weight: 600;
					color: var(--charcoal);
					margin-bottom: 4px;
					white-space: nowrap;
					overflow: hidden;
					text-overflow: ellipsis;
				}

				.prod-price {
					font-size: 15px;
					color: var(--accent);
					font-weight: 500;
					letter-spacing: 0.02em;
				}

				.prod-price .currency {
					font-size: 12px;
					vertical-align: super;
					margin-right: 1px;
				}

				/* In-cart badge */
				.in-cart-badge {
					position: absolute;
					top: 14px;
					right: 14px;
					background: var(--accent);
					color: var(--white);
					font-size: 10px;
					font-weight: 600;
					letter-spacing: 0.08em;
					text-transform: uppercase;
					padding: 4px 10px;
					border-radius: 50px;
					z-index: 3;
				}

				/* ─── MESSAGE BAR ──────────────────────────────── */
				#message {
					position: fixed;
					bottom: 30px;
					left: 50%;
					transform: translateX(-50%);
					background: var(--charcoal);
					color: var(--white);
					padding: 12px 28px;
					border-radius: 50px;
					font-size: 13px;
					font-weight: 500;
					box-shadow: 0 8px 32px rgba(0, 0, 0, 0.22);
					z-index: 9999;
					display: none;
					animation: slideUp 0.4s ease;
				}

				@keyframes slideUp {
					from {
						opacity: 0;
						transform: translateX(-50%) translateY(16px);
					}

					to {
						opacity: 1;
						transform: translateX(-50%) translateY(0);
					}
				}

				/* ─── NEWSLETTER STRIP ─────────────────────────── */
				.newsletter-section {
					margin: 0 48px 80px;
					background: var(--charcoal);
					border-radius: var(--radius-lg);
					padding: 56px 64px;
					display: flex;
					align-items: center;
					justify-content: space-between;
					gap: 40px;
					position: relative;
					overflow: hidden;
				}

				.newsletter-section::before {
					content: '';
					position: absolute;
					top: -80px;
					right: -80px;
					width: 280px;
					height: 280px;
					border-radius: 50%;
					background: radial-gradient(circle, rgba(184, 134, 11, 0.25) 0%, transparent 70%);
				}

				.newsletter-text h3 {
					font-family: 'Cormorant Garamond', serif;
					font-size: 32px;
					font-weight: 300;
					color: var(--white);
					margin-bottom: 8px;
				}

				.newsletter-text p {
					font-size: 14px;
					color: rgba(255, 255, 255, 0.55);
					line-height: 1.6;
					max-width: 360px;
				}

				.newsletter-form {
					display: flex;
					gap: 12px;
					flex-shrink: 0;
				}

				.newsletter-form input {
					background: rgba(255, 255, 255, 0.09);
					border: 1px solid rgba(255, 255, 255, 0.15);
					border-radius: 50px;
					padding: 12px 22px;
					color: var(--white);
					font-family: 'DM Sans', sans-serif;
					font-size: 14px;
					outline: none;
					width: 240px;
					transition: border-color 0.25s;
				}

				.newsletter-form input:focus {
					border-color: var(--accent2);
				}

				.newsletter-form input::placeholder {
					color: rgba(255, 255, 255, 0.38);
				}

				.newsletter-form button {
					background: var(--accent);
					color: var(--white);
					border: none;
					border-radius: 50px;
					padding: 12px 28px;
					font-family: 'DM Sans', sans-serif;
					font-size: 13px;
					font-weight: 500;
					cursor: pointer;
					transition: background 0.25s;
				}

				.newsletter-form button:hover {
					background: var(--accent2);
				}

				/* ─── FOOTER ───────────────────────────────────── */
				.ee-footer {
					background: var(--charcoal);
					color: rgba(255, 255, 255, 0.55);
					padding: 56px 48px 32px;
					margin-top: 0;
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

				/* ─── RESPONSIVE ────────────────────────────────── */
				@media (max-width: 900px) {
					.ee-navbar {
						padding: 0 20px;
					}

					.hero-section,
					.categories-section,
					.products-section {
						padding-left: 20px;
						padding-right: 20px;
					}

					.categories-grid {
						grid-template-columns: 1fr 1fr;
						grid-template-rows: auto;
					}

					.cat-card:first-child {
						grid-row: auto;
					}

					.hero-title {
						font-size: 36px;
					}

					.newsletter-section {
						flex-direction: column;
						margin: 0 20px 60px;
						padding: 40px 30px;
					}

					.newsletter-form {
						flex-direction: column;
						width: 100%;
					}

					.newsletter-form input {
						width: 100%;
					}

					.ee-footer-grid {
						grid-template-columns: 1fr 1fr;
					}

					.section-header {
						flex-direction: column;
						align-items: flex-start;
						gap: 12px;
					}
				}
			</style>

			<% /* ── Backend logic (unchanged) ────────────────────── */ String userName=(String)
				session.getAttribute("username"); String password=(String) session.getAttribute("password"); String
				userType=(String) session.getAttribute("usertype"); boolean isValidUser=true; if (userType==null ||
				userName==null || password==null || !userType.equals("customer")) { isValidUser=false; }
				ProductServiceImpl prodDao=new ProductServiceImpl(); List<ProductBean> products = new ArrayList
				<ProductBean>();

					String search = request.getParameter("search");
					String type = request.getParameter("type");
					String message = "All Products";

					if (search != null) {
					products = prodDao.searchAllProducts(search);
					message = "Showing results for &ldquo;" + search + "&rdquo;";
					} else if (type != null) {
					products = prodDao.getAllProductsByType(type);
					message = "Showing results for &ldquo;" + type + "&rdquo;";
					} else {
					products = prodDao.getAllProducts();
					}
					if (products.isEmpty()) {
					message = "No items found for &ldquo;" + (search != null ? search : type) + "&rdquo;";
					products = prodDao.getAllProducts();
					}
					%>

		</head>

		<body>

			<!-- ─── NAVBAR ──────────────────────────────────── -->
			<nav class="ee-navbar" id="mainNav">
				<a href="index.jsp" class="ee-brand">Ellison<span>.</span></a>

				<ul class="ee-nav-links">
					<li><a href="index.jsp">Home</a></li>
					<li><a href="index.jsp?type=mobile">Mobiles</a></li>
					<li><a href="index.jsp?type=laptop">Laptops</a></li>
					<li><a href="index.jsp?type=tv">TVs</a></li>
					<li><a href="index.jsp?type=camera">Cameras</a></li>
					<li><a href="index.jsp?type=speaker">Speakers</a></li>
				</ul>

				<div class="ee-nav-right">
					<form method="get" action="index.jsp" style="margin:0;">
						<div class="ee-search-wrap">
							<input type="text" name="search" placeholder="Search products&hellip;"
								value="<%= search != null ? search : "" %>">
							<button type="submit">
								<svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2"
									viewBox="0 0 24 24">
									<circle cx="11" cy="11" r="8" />
									<line x1="21" y1="21" x2="16.65" y2="16.65" />
								</svg>
							</button>
						</div>
					</form>
					<a href="cartDetails.jsp" class="ee-icon-btn" title="Cart">
						<svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2"
							viewBox="0 0 24 24">
							<path d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" />
							<line x1="3" y1="6" x2="21" y2="6" />
							<path d="M16 10a4 4 0 0 1-8 0" />
						</svg>
					</a>
					<a href="userProfile.jsp" class="ee-icon-btn" title="Profile">
						<svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2"
							viewBox="0 0 24 24">
							<path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
							<circle cx="12" cy="7" r="4" />
						</svg>
					</a>
					<% if (isValidUser) { %>
						<a href="./LogoutSrv" class="ee-icon-btn" title="Logout">
							<svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2"
								viewBox="0 0 24 24">
								<path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
								<polyline points="16 17 21 12 16 7" />
								<line x1="21" y1="12" x2="9" y2="12" />
							</svg>
						</a>
						<% } else { %>
							<a href="login.jsp" class="btn-ee-primary" style="padding:9px 20px;">Sign In</a>
							<% } %>
				</div>
			</nav>

			<!-- ─── HERO CAROUSEL ───────────────────────────── -->
			<% if (search==null && type==null) { %>
				<section class="hero-section">
					<div class="hero-carousel-wrap">
						<div id="heroCarousel" class="carousel slide" data-ride="carousel" data-interval="5000">
							<ol class="carousel-indicators">
								<li data-target="#heroCarousel" data-slide-to="0" class="active"></li>
								<li data-target="#heroCarousel" data-slide-to="1"></li>
								<li data-target="#heroCarousel" data-slide-to="2"></li>
							</ol>
							<div class="carousel-inner">
								<div class="item active">
									<img src="https://m-cdn.phonearena.com/images/article/102319-wide-two_1200/The-best-camera-phones-in-2026.jpg"
										class="hero-slide-bg" alt="Mobile Tech">
									<div class="hero-content">
										<div class="hero-tag">New Arrivals 2024</div>
										<h1 class="hero-title">The Future of<br><em>Mobile</em> Tech</h1>
										<p class="hero-desc">Discover the latest smartphones with cutting-edge
											processors, pro-grade cameras, and all-day battery life.</p>
										<a href="index.jsp?type=mobile" class="hero-cta">
											Explore Mobiles
											<svg width="14" height="14" fill="none" stroke="currentColor"
												stroke-width="2.5" viewBox="0 0 24 24">
												<line x1="5" y1="12" x2="19" y2="12" />
												<polyline points="12 5 19 12 12 19" />
											</svg>
										</a>
									</div>
								</div>
								<div class="item">
									<img src="https://cdn.mos.cms.futurecdn.net/v2/t:0,l:240,cw:1440,ch:1080,q:80,w:1440/ypqeZePRviyETdQHYNoMyC.jpg"
										class="hero-slide-bg" alt="Laptops">
									<div class="hero-content">
										<div class="hero-tag">Top Picks</div>
										<h1 class="hero-title">Power Meets<br><em>Elegance</em></h1>
										<p class="hero-desc">Ultra-thin laptops built for creators, engineers, and
											go-getters. Performance without compromise.</p>
										<a href="index.jsp?type=laptop" class="hero-cta">
											Shop Laptops
											<svg width="14" height="14" fill="none" stroke="currentColor"
												stroke-width="2.5" viewBox="0 0 24 24">
												<line x1="5" y1="12" x2="19" y2="12" />
												<polyline points="12 5 19 12 12 19" />
											</svg>
										</a>
									</div>
								</div>
								<div class="item">
									<img src="https://cdn.shopify.com/s/files/1/0605/3956/8364/files/HomeClick2_1024x1024.png?v=1704785253"
										class="hero-slide-bg" alt="Televisions">
									<div class="hero-content">
										<div class="hero-tag">Immersive Experience</div>
										<h1 class="hero-title">Cinema at<br><em>Home</em></h1>
										<p class="hero-desc">4K OLED televisions with Dolby Vision and immersive sound.
											Your living room, transformed.</p>
										<a href="index.jsp?type=tv" class="hero-cta">
											Discover TVs
											<svg width="14" height="14" fill="none" stroke="currentColor"
												stroke-width="2.5" viewBox="0 0 24 24">
												<line x1="5" y1="12" x2="19" y2="12" />
												<polyline points="12 5 19 12 12 19" />
											</svg>
										</a>
									</div>
								</div>
							</div>
							<a class="left carousel-control" href="#heroCarousel" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left"></span>
							</a>
							<a class="right carousel-control" href="#heroCarousel" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right"></span>
							</a>
						</div>
					</div>
				</section>

				<!-- ─── CATEGORIES GRID ─────────────────────────── -->
				<section class="categories-section">
					<div class="section-header">
						<div>
							<p class="section-label">Browse</p>
							<h2 class="section-title">Top Categories</h2>
						</div>
						<a href="index.jsp" class="view-all-link">View All</a>
					</div>
					<div class="categories-grid">
						<div class="cat-card">
							<img src="images/cat-mobile.jpg" alt="Mobiles" class="cat-card-img"
								onerror="this.style.display='none';this.parentNode.style.background='linear-gradient(135deg,#1a1a2e,#16213e)'">
							<div class="cat-card-overlay"></div>
							<span class="cat-card-label">Mobiles</span>
							<a href="index.jsp?type=mobile" class="cat-card-link"></a>
						</div>
						<div class="cat-card">
							<img src="images/cat-laptop.jpg" alt="Laptops" class="cat-card-img"
								onerror="this.style.display='none';this.parentNode.style.background='linear-gradient(135deg,#0d1117,#1c2526)'">
							<div class="cat-card-overlay"></div>
							<span class="cat-card-label">Laptops</span>
							<a href="index.jsp?type=laptop" class="cat-card-link"></a>
						</div>
						<div class="cat-card">
							<img src="images/cat-tv.jpg" alt="Televisions" class="cat-card-img"
								onerror="this.style.display='none';this.parentNode.style.background='linear-gradient(135deg,#0a0f1e,#141928)'">
							<div class="cat-card-overlay"></div>
							<span class="cat-card-label">Televisions</span>
							<a href="index.jsp?type=tv" class="cat-card-link"></a>
						</div>
						<div class="cat-card">
							<img src="images/cat-camera.jpg" alt="Cameras" class="cat-card-img"
								onerror="this.style.display='none';this.parentNode.style.background='linear-gradient(135deg,#1a0e00,#2d1a00)'">
							<div class="cat-card-overlay"></div>
							<span class="cat-card-label">Cameras</span>
							<a href="index.jsp?type=camera" class="cat-card-link"></a>
						</div>
						<div class="cat-card">
							<img src="images/cat-accessories.jpg" alt="Accessories" class="cat-card-img"
								onerror="this.style.display='none';this.parentNode.style.background='linear-gradient(135deg,#0d1b0a,#1a2e15)'">
							<div class="cat-card-overlay"></div>
							<span class="cat-card-label">Accessories</span>
							<a href="index.jsp?type=speaker" class="cat-card-link"></a>
						</div>
					</div>
				</section>
				<% } %>

					<!-- ─── RESULT BAR ───────────────────────────────── -->
					<div class="result-bar">
						<span>
							<%=message%>
						</span>
					</div>
					<div id="message"></div>

					<!-- ─── PRODUCTS GRID ────────────────────────────── -->
					<section class="products-section">
						<% if (search==null && type==null) { %>
							<div class="section-header" style="margin-bottom:28px;">
								<div>
									<p class="section-label">Explore</p>
									<h2 class="section-title">All Products</h2>
								</div>
							</div>
							<% } %>

								<div class="products-grid">
									<% for (ProductBean product : products) { int cartQty=new
										CartServiceImpl().getCartItemCount(userName, product.getProdId()); String
										desc=product.getProdInfo(); desc=desc.substring(0, Math.min(desc.length(), 90));
										%>
										<div class="prod-card">
											<% if (cartQty> 0) { %>
												<span class="in-cart-badge">In Cart</span>
												<% } %>

													<div class="prod-img-wrap">
														<img src="./ShowImage?pid=<%=product.getProdId()%>"
															alt="<%=product.getProdName()%>">

														<!-- Hover overlay with product info + actions (no backend change) -->
														<div class="prod-hover-overlay">
															<div class="prod-hover-title">
																<%=product.getProdName()%>
															</div>
															<div class="prod-hover-price"><span
																	class="currency">&#8377;</span>
																<%=product.getProdPrice()%>
															</div>
															<div class="prod-hover-desc">
																<%=desc%>&hellip;
															</div>
															<div class="prod-hover-btns">
																<form method="post" style="display:inline;">
																	<% if (cartQty==0) { %>
																		<button type="submit"
																			formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
																			class="btn-ee-primary">
																			<svg width="13" height="13" fill="none"
																				stroke="currentColor" stroke-width="2"
																				viewBox="0 0 24 24">
																				<path
																					d="M6 2 3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z" />
																				<line x1="3" y1="6" x2="21" y2="6" />
																				<path d="M16 10a4 4 0 0 1-8 0" />
																			</svg>
																			Add to Cart
																		</button>
																		&nbsp;
																		<button type="submit"
																			formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
																			class="btn-ee-secondary">
																			Buy Now
																		</button>
																		<% } else { %>
																			<button type="submit"
																				formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0"
																				class="btn-ee-danger">
																				Remove
																			</button>
																			&nbsp;
																			<button type="submit"
																				formaction="cartDetails.jsp"
																				class="btn-ee-primary">
																				Checkout
																			</button>
																			<% } %>
																</form>
															</div>
														</div>
													</div>

													<div class="prod-info">
														<div class="prod-name">
															<%=product.getProdName()%>
														</div>
														<div class="prod-price"><span class="currency">&#8377;</span>
															<%=product.getProdPrice()%>
														</div>
													</div>
										</div>
										<% } %>
								</div>
					</section>

					<!-- ─── NEWSLETTER ────────────────────────────────── -->
					<div class="newsletter-section">
						<div class="newsletter-text">
							<h3>Stay in the Loop for Exclusive Offers</h3>
							<p>Subscribe to our newsletter and be the first to receive exclusive deals, latest arrivals,
								and tech news.</p>
						</div>
						<div class="newsletter-form">
							<input type="email" placeholder="Enter your email address">
							<button type="button">Subscribe</button>
						</div>
					</div>

					<!-- ─── FOOTER ────────────────────────────────────── -->
					<footer class="ee-footer">
						<div class="ee-footer-grid">
							<div>
								<div class="ee-footer-brand">Ellison<span>.</span></div>
								<p>Your premium destination for electronics. From mobiles to home theatre, we bring the
									finest technology to your doorstep.</p>
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

					<script>
						/* Initialize carousel */
						$('.carousel').carousel({
							interval: 5000
						});

						/* Navbar scroll effect */
						window.addEventListener('scroll', function () {
							document.getElementById('mainNav').classList.toggle('scrolled', window.scrollY > 40);
						});

						/* Toast message (triggered from server responses) */
						var msgEl = document.getElementById('message');
						if (msgEl && msgEl.textContent.trim() !== '') {
							msgEl.style.display = 'block';
							setTimeout(function () {
								msgEl.style.display = 'none';
							}, 3500);
						}
					</script>
		</body>

		</html>