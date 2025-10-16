<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main-styles.css">
    <style>
        :root {
            --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --gradient-hot: linear-gradient(135deg, #ff6b6b 0%, #ffa726 100%);
        }
        
        /* Hero Banner Styles */
        .hero-section {
            margin-bottom: 2rem;
            width: 100vw;
            margin-left: calc(-50vw + 50%);
            position: relative;
        }
        
        .carousel {
            width: 100%;
            height: 100vh;
            max-height: 600px;
            min-height: 400px;
        }
        
        .carousel-inner {
            border-radius: 0;
            overflow: hidden;
            height: 100%;
        }
        
        .carousel-item {
            height: 100%;
        }
        
        .hero-banner {
            position: relative;
            height: 100%;
            width: 100%;
            background: var(--gradient-primary);
            overflow: hidden;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
        
        /* Background logo for all slides */
        .hero-banner::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 400px;
            height: 400px;
            background-image: url('${pageContext.request.contextPath}/img/Logo_HCMUTE.png');
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0.1;
            z-index: 2;
            pointer-events: none;
        }
        
        /* Overlay để đảm bảo text luôn đọc được */
        .hero-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.1));
            z-index: 1;
        }
        
        /* Responsive banner height */
        @media (max-width: 768px) {
            .carousel {
                height: 70vh;
                max-height: 400px;
                min-height: 300px;
            }
            
            .hero-title {
                font-size: 2rem !important;
            }
            
            .hero-subtitle {
                font-size: 1rem !important;
            }
            
            .hero-content {
                left: 20px !important;
                right: 20px !important;
                text-align: center;
            }
        }
        
        @media (min-width: 1200px) {
            .carousel {
                height: 80vh;
                max-height: 700px;
            }
        }
        
        @media (max-width: 576px) {
            .carousel {
                height: 60vh;
                max-height: 350px;
                min-height: 250px;
            }
            
            .hero-title {
                font-size: 1.5rem !important;
            }
            
            .hero-subtitle {
                font-size: 0.9rem !important;
            }
        }
        
        .hero-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            z-index: 3;
            max-width: 800px;
            width: 90%;
            text-align: center;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: bold;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.5);
            line-height: 1.2;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.95;
            text-shadow: 1px 1px 4px rgba(0,0,0,0.5);
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .btn-hero {
            background: var(--gradient-hot);
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            color: white;
            font-weight: bold;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .btn-hero:hover {
            transform: scale(1.05);
            color: white;
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }
        
        /* Carousel controls styling */
        .carousel-control-prev,
        .carousel-control-next {
            width: 60px;
            height: 60px;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(0,0,0,0.5);
            border-radius: 50%;
            margin: 0 20px;
        }
        
        .carousel-control-prev {
            left: 20px;
        }
        
        .carousel-control-next {
            right: 20px;
        }
        
        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            width: 30px;
            height: 30px;
        }
        
        /* Carousel indicators styling */
        .carousel-indicators {
            bottom: 30px;
            margin-bottom: 0;
        }
        
        .carousel-indicators [data-bs-target] {
            width: 15px;
            height: 15px;
            border-radius: 50%;
            margin: 0 5px;
            background-color: rgba(255,255,255,0.5);
            border: 2px solid white;
        }
        
        .carousel-indicators .active {
            background-color: white;
        }
        
        /* Discount badge styling */
        .discount-badge {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.3);
        }
        
        /* Discount percent styling */
        .discount-percent {
            font-size: 2.5rem;
            font-weight: 900;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 5px;
            line-height: 1;
        }
        
        /* Shipping icon animation */
        .shipping-icon i {
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {
                transform: translateY(0);
            }
            40% {
                transform: translateY(-10px);
            }
            60% {
                transform: translateY(-5px);
            }
        }
        
        /* Image preload styling */
        .hero-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0;
            transition: opacity 0.5s ease;
        }
        
        .hero-image.loaded {
            opacity: 0.3;
        }
        
        /* Discount Banner */
        .discount-banner {
            background: var(--gradient-hot);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .discount-banner::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            50% { transform: translateX(100%) translateY(100%) rotate(45deg); }
            100% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
        }
        
        /* Filter Section */
        .filter-section {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 3rem;
            border: 1px solid rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }
        
        .filter-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            border-radius: 20px 20px 0 0;
        }
        
        .filter-title {
            font-weight: 700;
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
        }
        
        .filter-title i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-right: 8px;
            font-size: 1.1rem;
        }
        
        .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }
        
        .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            transform: translateY(-2px);
        }
        
        .form-select:hover {
            border-color: #667eea;
            transform: translateY(-1px);
        }
        
        .filter-apply-btn {
            background: var(--gradient-primary);
            border: none;
            color: white;
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }
        
        .filter-apply-btn:hover {
            background: var(--gradient-hot);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        /* Responsive filter section */
        @media (max-width: 768px) {
            .filter-section {
                padding: 20px;
            }
            
            .filter-title {
                font-size: 0.9rem;
                margin-bottom: 15px;
            }
            
            .form-select {
                padding: 10px 14px;
                font-size: 0.9rem;
            }
            
            .filter-apply-btn {
                padding: 10px 20px;
                font-size: 0.9rem;
            }
        }
        
        /* Product Grid */
        .product-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            transition: all 0.3s ease;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            height: 100%;
        }
        
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }
        
        .product-image-container {
            height: 200px;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px;
        }
        
        .product-image {
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain;
            transition: transform 0.3s ease;
            display: block;
            opacity: 1;
            visibility: visible;
            border-radius: 8px;
        }
        
        /* Đảm bảo hình ảnh luôn hiển thị đúng tỷ lệ */
        .product-image:not([src]), 
        .product-image[src=""], 
        .product-image[src*="undefined"] {
            opacity: 0;
        }
        
        .product-image.loaded {
            opacity: 1;
            visibility: visible;
        }
        
        /* Loading placeholder */
        .product-image-container::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 40px;
            height: 40px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #007bff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            z-index: 1;
        }
        
        .product-image-container.loaded::before {
            display: none;
        }
        
        /* Placeholder khi không có ảnh */
        .product-image-placeholder {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f8f9fa;
            color: #6c757d;
            font-size: 0.9rem;
            text-align: center;
            border-radius: 8px;
        }
        
        @keyframes spin {
            0% { transform: translate(-50%, -50%) rotate(0deg); }
            100% { transform: translate(-50%, -50%) rotate(360deg); }
        }
        
        /* Load More Button */
        .load-more-btn {
            background: var(--gradient-primary);
            border: none;
            color: white;
            padding: 15px 40px;
            border-radius: 50px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .load-more-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        /* Animation */
        .fade-in-up {
            opacity: 0;
            transform: translateY(50px);
            animation: fadeInUp 0.8s forwards;
        }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Search Enhancement */
        .search-container {
            flex: 1;
            max-width: 600px;
            margin: 0 2rem;
        }
        
        .search-group {
            position: relative;
            display: flex;
        }
        
        .search-input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-radius: 50px 0 0 50px;
            background: rgba(255,255,255,0.1);
            color: white;
            font-size: 1rem;
        }
        
        .search-input::placeholder {
            color: rgba(255,255,255,0.7);
        }
        
        .search-btn {
            background: var(--gradient-hot);
            border: none;
            color: white;
            padding: 12px 25px;
            border-radius: 0 50px 50px 0;
            transition: all 0.3s;
        }
        
        .search-btn:hover {
            background: #ff5722;
            transform: scale(1.05);
        }
        
        .product-card:hover .product-image {
            transform: scale(1.1);
        }
        
        .product-overlay {
            position: absolute;
            inset: 0;
            background: rgba(0,0,0,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 2;
        }
        
        .product-card:hover .product-overlay {
            opacity: 1;
        }
        
        .badge-hot {
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--gradient-hot);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: bold;
            z-index: 3;
        }
        
        /* Flash Sale Badge */
        .flash-sale-badge {
            background: rgba(255,255,255,0.2);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 20px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.3);
        }
        
        /* Flash animation */
        @keyframes flash {
            0%, 50%, 100% { opacity: 1; }
            25%, 75% { opacity: 0.5; }
        }
        
        /* Countdown timer styling */
        .countdown-timer {
            background: rgba(255,255,255,0.9) !important;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,193,7,0.3);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        /* New styles for hero icons */
        .hero-icon {
            display: inline-block;
            font-size: 1.3rem;
            line-height: 1;
            margin: 0 0.3rem;
            animation: iconFloat 3s ease-in-out infinite;
            opacity: 0.8;
            filter: drop-shadow(0 0 8px rgba(255,255,255,0.3));
            transition: all 0.3s ease;
        }
        
        .hero-icon:hover {
            opacity: 1;
            transform: scale(1.1);
            filter: drop-shadow(0 0 12px rgba(255,255,255,0.5));
        }
        
        @keyframes iconFloat {
            0%, 100% {
                transform: translateY(0px);
                opacity: 0.8;
            }
            50% {
                transform: translateY(-5px);
                opacity: 0.9;
            }
        }
        
        /* SECTION HEADER STYLING - ENHANCED */
        .section-header-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 2rem 3rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(102, 126, 234, 0.4);
        }
        
        .section-header-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shine 3s infinite;
        }
        
        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }
        
        .section-title-main {
            font-size: 2.5rem;
            font-weight: 900;
            color: white;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 1rem;
            position: relative;
            z-index: 2;
        }
        
        .fire-icon {
            font-size: 3rem;
            animation: fireFlicker 1.5s infinite;
            filter: drop-shadow(0 0 10px rgba(255,165,0,0.8));
        }
        
        @keyframes fireFlicker {
            0%, 100% { 
                transform: scale(1) rotate(-5deg);
                color: #ff6b6b;
            }
            25% { 
                transform: scale(1.1) rotate(5deg);
                color: #ffa726;
            }
            50% { 
                transform: scale(1.05) rotate(-3deg);
                color: #ff9800;
            }
            75% { 
                transform: scale(1.08) rotate(3deg);
                color: #ff5722;
            }
        }
        
        .star-icon {
            animation: starPulse 2s infinite;
            filter: drop-shadow(0 0 10px rgba(255,215,0,0.8));
        }
        
        @keyframes starPulse {
            0%, 100% { 
                transform: scale(1) rotate(0deg);
                color: #ffd700;
            }
            50% { 
                transform: scale(1.2) rotate(180deg);
                color: #ffed4e;
            }
        }
        
        .badge-top10 {
            background: linear-gradient(135deg, #ff6b6b 0%, #ffa726 100%);
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-size: 1.2rem;
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 2px;
            box-shadow: 0 5px 20px rgba(255,107,107,0.4);
            position: relative;
            z-index: 2;
            animation: badgeBounce 2s infinite;
            border: 3px solid rgba(255,255,255,0.5);
        }
        
        @keyframes badgeBounce {
            0%, 100% { 
                transform: translateY(0) scale(1);
                box-shadow: 0 5px 20px rgba(255,107,107,0.4);
            }
            50% { 
                transform: translateY(-5px) scale(1.05);
                box-shadow: 0 10px 30px rgba(255,107,107,0.6);
            }
        }
        
        .lightning-icon {
            animation: lightning 1s infinite;
            margin: 0 0.5rem;
        }
        
        @keyframes lightning {
            0%, 100% { 
                opacity: 1;
                transform: scale(1);
                color: #ffeb3b;
            }
            50% { 
                opacity: 0.5;
                transform: scale(1.3);
                color: #ffc107;
            }
        }
        
        .sparkle-effect {
            position: absolute;
            top: 50%;
            right: 5%;
            font-size: 2rem;
            opacity: 0;
            animation: sparkle 3s infinite;
        }
        
        @keyframes sparkle {
            0%, 100% { 
                opacity: 0;
                transform: translateY(0) scale(0.5) rotate(0deg);
            }
            50% { 
                opacity: 1;
                transform: translateY(-10px) scale(1) rotate(180deg);
            }
        }
        
        .sparkle-effect:nth-child(2) {
            right: 10%;
            animation-delay: 1s;
        }
        
        .sparkle-effect:nth-child(3) {
            right: 15%;
            animation-delay: 2s;
        }
        
        /* Enhanced icon styling for each slide */
        #banner1 .hero-icon {
            filter: drop-shadow(0 0 10px rgba(102, 126, 234, 0.4));
        }
        
        #banner2 .hero-icon {
            filter: drop-shadow(0 0 10px rgba(79, 172, 254, 0.4));
        }
        
        #banner3 .hero-icon {
            filter: drop-shadow(0 0 10px rgba(250, 112, 154, 0.4));
            animation: iconPulse 2s ease-in-out infinite;
        }
        
        #banner4 .hero-icon {
            filter: drop-shadow(0 0 10px rgba(168, 237, 234, 0.4));
        }
        
        @keyframes iconPulse {
            0%, 100% {
                transform: scale(1);
                opacity: 0.8;
            }
            50% {
                transform: scale(1.05);
                opacity: 0.95;
            }
        }
        
        /* Custom notification styles */
        .custom-notification {
            border-radius: 12px;
            overflow: hidden;
            max-width: 400px;
            width: 100%;
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            animation: slideIn 0.4s ease-out;
        }
        
        .notification-header {
            padding: 12px 16px;
            display: flex;
            align-items: center;
            background: var(--gradient-primary);
            color: white;
            font-weight: 600;
        }
        
        .notification-header i {
            margin-right: 10px;
        }
        
        .notification-body {
            padding: 16px;
            background: white;
            color: #333;
            font-size: 14px;
            line-height: 1.5;
        }
        
        .notification-close {
            background: none;
            border: none;
            color: white;
            opacity: 0.8;
            font-size: 18px;
            cursor: pointer;
            padding: 4px;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        @keyframes slideOut {
            from {
                transform: translateY(0);
                opacity: 1;
            }
            to {
                transform: translateY(-20px);
                opacity: 0;
            }
        }
    </style>
</head>
<body>

<!-- Include Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<main class="container-fluid px-4">
    <!-- Hero Banner Section với carousel -->
    <section class="hero-section mb-4">
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="3"></button>
            </div>
            
            <div class="carousel-inner">
                <!-- Slide 1 - Main Banner -->
                <div class="carousel-item active">
                    <div class="hero-banner" id="banner1" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                        <!-- Preload background images -->
                        <img src="${pageContext.request.contextPath}/img/banner1.jpg" class="hero-image" alt="Banner 1" 
                             onerror="this.style.display='none';">
                        
                        <div class="hero-content">
                            <h1 class="hero-title">
                                UTESHOP
                            </h1>
                            <p class="hero-subtitle">Nền tảng mua sắm trực tuyến hàng đầu dành cho sinh viên HCMUTE</p>
                            <a href="#products" class="btn-hero">
                                Khám phá ngay
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Slide 2 - Student Discount -->
                <div class="carousel-item">
                    <div class="hero-banner" id="banner2" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                        <!-- Preload background images -->
                        <img src="${pageContext.request.contextPath}/img/banner2.jpg" class="hero-image" alt="Banner 2" 
                             onerror="this.style.display='none';">
                        
                        <div class="hero-content">
                            <h1 class="hero-title">
                                ƯU ĐÃI SINH VIÊN
                            </h1>
                            <p class="hero-subtitle">Giảm giá đặc biệt lên đến 30% cho tất cả sinh viên HCMUTE</p>
                            <a href="#products" class="btn-hero">
                                Nhận ưu đãi ngay
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Slide 3 - Hot Deals -->
                <div class="carousel-item">
                    <div class="hero-banner" id="banner3" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                        <!-- Preload background images -->
                        <img src="${pageContext.request.contextPath}/img/banner3.jpg" class="hero-image" alt="Banner 3" 
                             onerror="this.style.display='none';">
                        
                        <div class="hero-content">
                            <h1 class="hero-title">
                                DEAL HOT HÔM NAY
                            </h1>
                            <p class="hero-subtitle">Săn ngay những sản phẩm hot với giá cực ưu đãi, số lượng có hạn!</p>
                            <a href="#products" class="btn-hero">
                                Săn deal ngay
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Slide 4 - Free Shipping -->
                <div class="carousel-item">
                    <div class="hero-banner" id="banner4" style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);">
                        <!-- Preload background images -->
                        <img src="${pageContext.request.contextPath}/img/banner4.jpg" class="hero-image" alt="Banner 4" 
                             onerror="this.style.display='none';">
                        
                        <div class="hero-content">
                            <h1 class="hero-title">
                                MIỄN PHÍ VẬN CHUYỂN
                            </h1>
                            <p class="hero-subtitle">Miễn phí ship toàn quốc cho đơn hàng từ 299,000₫, giao hàng nhanh 24h</p>
                            <a href="#products" class="btn-hero">
                                Mua sắm ngay
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </section>

    <!-- Filter Section -->
    <section class="filter-section">
        <div class="row">
            <div class="col-md-3">
                <h6 class="filter-title">
                    <i class="fas fa-filter me-2"></i>Lọc theo danh mục
                </h6>
                <select class="form-select" id="categoryFilter">
                    <option value="">Tất cả danh mục</option>
                    <c:if test="${not empty categories}">
                        <c:forEach var="cat" items="${categories}">
                            <option value="${cat.maDM}">${cat.tenDM}</option>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty categories}">
                        <option value="" disabled>Chưa có danh mục nào</option>
                    </c:if>
                </select>
            </div>
            <div class="col-md-3">
                <h6 class="filter-title">
                    <i class="fas fa-dollar-sign me-2"></i>Khoảng giá
                </h6>
                <select class="form-select" id="priceFilter">
                    <option value="">Tất cả mức giá</option>
                    <option value="0-100000">Dưới 100,000₫</option>
                    <option value="100000-500000">100,000₫ - 500,000₫</option>
                    <option value="500000-1000000">500,000₫ - 1,000,000₫</option>
                    <option value="1000000-5000000">1,000,000₫ - 5,000,000₫</option>
                    <option value="5000000-">Trên 5,000,000₫</option>
                </select>
            </div>
            <div class="col-md-3">
                <h6 class="filter-title">
                    <i class="fas fa-store me-2"></i>Sắp xếp theo
                </h6>
                <select class="form-select" id="sortFilter">
                    <option value="bestseller">Bán chạy nhất</option>
                    <option value="price-asc">Giá thấp đến cao</option>
                    <option value="price-desc">Giá cao đến thấp</option>
                    <option value="newest">Mới nhất</option>
                    <option value="rating">Đánh giá cao</option>
                </select>
            </div>
            <div class="col-md-3 d-flex align-items-end">
                <button class="btn btn-primary w-100 filter-apply-btn" onclick="applyFilters()">
                    <i class="fas fa-search me-2"></i>Áp dụng
                </button>
            </div>
        </div>
    </section>

    <!-- Products Section -->
    <section id="products" class="mb-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="section-title">
                <i class="fas fa-star text-warning me-2"></i>Sản phẩm nổi bật
            </h2>
            <c:choose>
                <c:when test="${showAll}">
                    <span class="badge bg-success fs-6">Hiển thị tất cả ${fn:length(products)} sản phẩm</span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-primary fs-6">Top 10 bán chạy</span>
                </c:otherwise>
            </c:choose>
        </div>

        <c:choose>
            <c:when test="${not empty errorMessage}">
                <div class="alert alert-danger text-center py-5">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                    <h4>Đã xảy ra lỗi</h4>
                    <p>${errorMessage}</p>
                </div>
            </c:when>
            <c:when test="${empty products}">
                <div class="alert alert-warning text-center py-5">
                    <i class="fas fa-box-open fa-3x mb-3"></i>
                    <h4>Chưa có sản phẩm</h4>
                    <p>Hiện tại chưa có sản phẩm nào trong hệ thống.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row" id="productsContainer">
                    <c:forEach var="sp" items="${products}" varStatus="status">
                        <div class="col-lg-3 col-md-4 col-sm-6 mb-4 fade-in-up" style="animation-delay: ${status.index * 0.1}s;">
                            <div class="product-card">
                                <!-- Hot Badge for top 3 products (chỉ hiển thị khi chưa showAll) -->
                                <c:if test="${!showAll && status.index < 3}">
                                    <div class="badge-hot">
                                        <i class="fas fa-fire"></i> HOT
                                    </div>
                                </c:if>
                                
                                <!-- Product Image -->
                                <div class="product-image-container">
                                    <img src="${pageContext.request.contextPath}/img/${sp.hinhAnh}"
                                         alt="${sp.tenSP}"
                                         class="product-image"
                                         onerror="this.src='${pageContext.request.contextPath}/img/Logo_HCMUTE.png';">
                                    
                                    <!-- Overlay -->
                                    <div class="product-overlay">
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" 
                                               class="btn btn-warning btn-sm">
                                                <i class="fas fa-eye"></i> Xem chi tiết
                                            </a>
                                            <button class="btn btn-success btn-sm" onclick="quickAddToCart(${sp.maSP})">
                                                <i class="fas fa-cart-plus"></i> Mua
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Product Info -->
                                <div class="card-body p-3">
                                    <h6 class="card-title fw-bold mb-2" style="height: 48px; overflow: hidden;">
                                        <a href="${pageContext.request.contextPath}/guest/product?id=${sp.maSP}" 
                                           class="text-decoration-none text-dark">${sp.tenSP}</a>
                                    </h6>
                                    
                                    <!-- Price -->
                                    <div class="price mb-2">
                                        <span class="h5 text-danger fw-bold">
                                            <fmt:formatNumber value="${sp.donGia}" type="number" groupingUsed="true"/>₫
                                        </span>
                                    </div>
                                    
                                    <!-- Rating and Sales -->
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div class="rating">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <span class="ms-1 small text-muted">(4.8)</span>
                                        </div>
                                        <small class="text-muted">
                                            <i class="fas fa-chart-line"></i> ${sp.soLuongBan}
                                        </small>
                                    </div>
                                    
                                    <!-- Action Buttons -->
                                    <div class="d-grid">
                                        <button class="btn btn-primary" onclick="addToCart(${sp.maSP})">
                                            <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- Load More Section - CHỈ hiển thị khi chưa showAll -->
                <c:if test="${!showAll && fn:length(products) < totalProducts}">
                    <div class="text-center mt-5">
                        <a href="${pageContext.request.contextPath}/guest/home?showAll=true" class="load-more-btn text-decoration-none">
                            <i class="fas fa-plus me-2"></i>Xem thêm sản phẩm
                        </a>
                        <p class="text-muted mt-3">
                            <small>Đang hiển thị <span id="currentCount">${fn:length(products)}</span> / ${totalProducts} sản phẩm</small>
                        </p>
                    </div>
                </c:if>
                
                <!-- Message khi đã hiển thị tất cả -->
                <c:if test="${showAll}">
                    <div class="text-center mt-5">
                        <p class="text-success fw-bold">
                            <i class="fas fa-check-circle me-2"></i>
                            🎉 Đã hiển thị tất cả ${totalProducts} sản phẩm!
                        </p>
                        <a href="${pageContext.request.contextPath}/guest/home" class="btn btn-outline-primary">
                            <i class="fas fa-arrow-left me-2"></i>Quay lại Top 10
                        </a>
                    </div>
                </c:if>
            </c:otherwise>
        </c:choose>
    </section>
</main>

<!-- Include Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Animation on scroll
document.addEventListener('DOMContentLoaded', function() {
    // Preload banner images
    preloadBannerImages();
    
    // Initialize carousel after images are loaded
    initializeCarousel();
    
    // Initialize product images
    initializeProductImages();
    
    // Observer for animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.fade-in-up').forEach(el => {
        observer.observe(el);
    });
});

// Preload banner images function
function preloadBannerImages() {
    const imageUrls = [
        '${pageContext.request.contextPath}/img/banner1.jpg',
        '${pageContext.request.contextPath}/img/banner2.jpg', 
        '${pageContext.request.contextPath}/img/banner3.jpg',
        '${pageContext.request.contextPath}/img/Logo_HCMUTE.png'
    ];
    
    imageUrls.forEach((url, index) => {
        const img = new Image();
        img.onload = function() {
            console.log('Banner image ' + (index + 1) + ' loaded successfully');
            // Show the image when it loads
            const heroImage = document.querySelector('#banner' + (index + 1) + ' .hero-image');
            if (heroImage && heroImage.src === url) {
                heroImage.classList.add('loaded');
            }
        };
        img.onerror = function() {
            console.log('Failed to load banner image ' + (index + 1) + ': ' + url);
        };
        img.src = url;
    });
}

// Initialize carousel with proper sizing
function initializeCarousel() {
    const carousel = document.getElementById('heroCarousel');
    if (carousel) {
        // Ensure carousel takes full width
        carousel.style.width = '100vw';
        carousel.style.marginLeft = 'calc(-50vw + 50%)';
        
        // Force recalculation of carousel height
        const resizeCarousel = () => {
            const vh = window.innerHeight;
            const carouselHeight = Math.min(Math.max(vh * 0.6, 400), 700);
            carousel.style.height = carouselHeight + 'px';
        };
        
        // Initial sizing
        resizeCarousel();
        
        // Resize on window resize
        window.addEventListener('resize', resizeCarousel);
        
        // Initialize Bootstrap carousel
        const bsCarousel = new bootstrap.Carousel(carousel, {
            interval: 4000,
            ride: 'carousel',
            wrap: true,
            touch: true
        });
    }
}

// Initialize product images function
function initializeProductImages() {
    const productImages = document.querySelectorAll('.product-image');
    
    productImages.forEach((img, index) => {
        const container = img.closest('.product-image-container');
        
        // Set loading state
        if (container) {
            container.classList.remove('loaded');
        }
        
        // Handle successful image load
        img.onload = function() {
            console.log('Product image ' + (index + 1) + ' loaded: ' + this.src);
            this.style.opacity = '1';
            this.style.visibility = 'visible';
            if (container) {
                container.classList.add('loaded');
            }
        };
        
        // Handle image load error
        img.onerror = function() {
            console.log('Failed to load product image ' + (index + 1) + ': ' + this.src);
            // Try fallback image
            if (this.src.indexOf('Logo_HCMUTE.png') === -1) {
                this.src = '${pageContext.request.contextPath}/img/Logo_HCMUTE.png';
            } else {
                // If even fallback fails, hide the image and show placeholder
                this.style.display = 'none';
                if (container) {
                    container.innerHTML = 
                        '<div class="d-flex align-items-center justify-content-center h-100 bg-light">' +
                            '<div class="text-center text-muted">' +
                                '<i class="fas fa-image fa-3x mb-2"></i>' +
                                '<div>Không có hình ảnh</div>' +
                            '</div>' +
                        '</div>';
                    container.classList.add('loaded');
                }
            }
        };
        
        // Force reload if image src is empty or undefined
        if (!img.src || img.src.includes('undefined') || img.src.includes('null')) {
            img.src = '${pageContext.request.contextPath}/img/Logo_HCMUTE.png';
        }
        
        // If image is already loaded
        if (img.complete && img.naturalHeight !== 0) {
            img.onload();
        }
    });
}

// Filter functionality - cập nhật để redirect đến trang danh mục khi chọn
function applyFilters() {
    const category = document.getElementById('categoryFilter').value;
    const price = document.getElementById('priceFilter').value;
    const sort = document.getElementById('sortFilter').value;
    
    console.log('Applying filters:', { category, price, sort });
    
    // Nếu có chọn danh mục, redirect đến trang danh mục
    if (category) {
        window.location.href = '${pageContext.request.contextPath}/guest/category?id=' + category;
        return;
    }
    
    // Show loading state for other filters
    showNotification('Đang lọc sản phẩm...', 'info');
    
    // TODO: Implement actual filter logic for price and sort
    setTimeout(() => {
        showNotification('Chức năng lọc giá và sắp xếp sẽ được cập nhật sớm!', 'info');
    }, 1000);
}

// Auto redirect when category changes
document.addEventListener('DOMContentLoaded', function() {
    const categoryFilter = document.getElementById('categoryFilter');
    if (categoryFilter) {
        categoryFilter.addEventListener('change', function() {
            const selectedCategory = this.value;
            if (selectedCategory) {
                // Show loading notification
                showNotification('Đang chuyển đến danh mục...', 'info');
                // Redirect to category page
                setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/guest/category?id=' + selectedCategory;
                }, 500);
            }
        });
    }
});

// Enhanced notification system with better styling
function showNotification(message, type = 'info') {
    // Remove existing notifications
    const existingNotifications = document.querySelectorAll('.custom-notification');
    existingNotifications.forEach(notif => notif.remove());

    const notification = document.createElement('div');
    notification.className = 'custom-notification position-fixed shadow-lg';
    notification.style.cssText = 
        'top: 20px;' +
        'right: 20px;' +
        'z-index: 99999;' +
        'min-width: 350px;' +
        'max-width: 400px;' +
        'border: none;' +
        'border-radius: 12px;' +
        'transform: translateX(100%);' +
        'opacity: 0;' +
        'transition: all 0.4s ease;' +
        'background: white;' +
        'color: #333;' +
        'box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);' +
        'overflow: hidden;';
    
    let iconClass = 'info-circle';
    let bgColor = '#17a2b8';
    let borderColor = '#17a2b8';
    let titleText = 'Thông báo';
    
    if (type === 'success') {
        iconClass = 'check-circle';
        bgColor = '#28a745';
        borderColor = '#20c997';
        titleText = 'Thành công';
    } else if (type === 'error' || type === 'danger') {
        iconClass = 'exclamation-triangle';
        bgColor = '#dc3545';
        borderColor = '#e83e8c';
        titleText = 'Lỗi';
    } else if (type === 'warning') {
        iconClass = 'exclamation-triangle';
        bgColor = '#ffc107';
        borderColor = '#fd7e14';
        titleText = 'Yêu cầu đăng nhập';
        notification.style.color = '#333';
    }
    
    const headerStyle = 
        'background: linear-gradient(135deg, ' + bgColor + ' 0%, ' + borderColor + ' 100%);' +
        'padding: 12px 16px;' +
        'color: white;' +
        'font-weight: 600;' +
        'display: flex;' +
        'align-items: center;';
    
    const iconStyle = 
        'background: rgba(255,255,255,0.2);' +
        'width: 32px;' +
        'height: 32px;' +
        'border-radius: 50%;' +
        'display: flex;' +
        'align-items: center;' +
        'justify-content: center;' +
        'margin-right: 12px;';
    
    const closeButtonStyle = 
        'background: none;' +
        'border: none;' +
        'color: white;' +
        'opacity: 0.8;' +
        'font-size: 18px;' +
        'cursor: pointer;' +
        'padding: 4px;' +
        'border-radius: 50%;' +
        'width: 28px;' +
        'height: 28px;' +
        'display: flex;' +
        'align-items: center;' +
        'justify-content: center;';
    
    const bodyStyle = 
        'padding: 16px;' +
        'font-size: 14px;' +
        'line-height: 1.5;';
    
    notification.innerHTML = 
        '<div style="' + headerStyle + '">' +
            '<div style="' + iconStyle + '">' +
                '<i class="fas fa-' + iconClass + '"></i>' +
            '</div>' +
            '<div style="flex-grow: 1;">' + titleText + '</div>' +
            '<button type="button" onclick="this.parentElement.parentElement.remove()" style="' + closeButtonStyle + '">×</button>' +
        '</div>' +
        '<div style="' + bodyStyle + '">' +
            message +
        '</div>';
    
    document.body.appendChild(notification);
    
    // Show notification with animation
    setTimeout(() => {
        notification.style.transform = 'translateX(0)';
        notification.style.opacity = '1';
    }, 100);
    
    // Auto remove after 4 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.style.transform = 'translateX(100%)';
            notification.style.opacity = '0';
            setTimeout(() => {
                if (notification.parentElement) {
                    notification.remove();
                }
            }, 400);
        }
    }, 4000);
}

// Add CSS animations for notifications
const notificationStyles = document.createElement('style');
notificationStyles.textContent = `
    @keyframes slideInRight {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOutRight {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(notificationStyles);

// Load more products - REAL IMPLEMENTATION
let currentPage = 1;
const PRODUCTS_PER_PAGE = 4; // Thay đổi từ 8 thành 4 sản phẩm mỗi lần load

function loadMoreProducts() {
    const loadMoreBtn = document.getElementById('loadMoreBtn');
    const loadingSpinner = document.getElementById('loadingSpinner');
    const currentCount = document.getElementById('currentCount');
    
    // Show loading state
    loadMoreBtn.disabled = true;
    loadingSpinner.classList.remove('d-none');
    
    // GỬI currentPage trước khi tăng (KHÔNG tăng trước!)
    console.log('Loading more products - Page:', currentPage, 'Size:', PRODUCTS_PER_PAGE);
    
    // Make AJAX request to load more products
    fetch('${pageContext.request.contextPath}/guest/home/loadmore?page=' + currentPage + '&size=' + PRODUCTS_PER_PAGE)
        .then(response => response.json())
        .then(data => {
            console.log('Load more response:', data);
            
            if (data.success && data.products && data.products.length > 0) {
                // Add new products to container
                const productsContainer = document.getElementById('productsContainer');
                
                data.products.forEach((product, index) => {
                    const productCard = createProductCard(product, (currentPage - 1) * PRODUCTS_PER_PAGE + index);
                    productsContainer.appendChild(productCard);
                });
                
                // Tăng currentPage SAU khi load thành công
                currentPage++;
                
                // Update current count
                const newCount = parseInt(currentCount.textContent) + data.products.length;
                currentCount.textContent = newCount;
                
                // Show success notification
                showNotification(data.message || 'Đã tải thêm ' + data.products.length + ' sản phẩm!', 'success');
                
                // Hide load more button if no more products
                if (!data.hasMore || newCount >= data.totalProducts) {
                    loadMoreBtn.style.display = 'none';
                    
                    // Show completion message
                    const completionMsg = document.createElement('p');
                    completionMsg.className = 'text-muted text-center mt-3';
                    completionMsg.innerHTML = '<small><i class="fas fa-check-circle me-2 text-success"></i>🎉 Đã hiển thị tất cả ' + data.totalProducts + ' sản phẩm!</small>';
                    loadMoreBtn.parentElement.appendChild(completionMsg);
                    
                    // Show final notification
                    setTimeout(() => {
                        showNotification('🎉 Đã hiển thị hết tất cả sản phẩm trong cửa hàng!', 'info');
                    }, 500);
                }
                
                // Initialize images for new products
                initializeProductImages();
                
            } else {
                // No more products
                loadMoreBtn.style.display = 'none';
                showNotification('🎉 Đã hiển thị hết tất cả sản phẩm!', 'info');
                
                // Show completion message
                const completionMsg = document.createElement('p');
                completionMsg.className = 'text-muted text-center mt-3';
                completionMsg.innerHTML = '<small><i class="fas fa-check-circle me-2 text-success"></i>Đã hiển thị tất cả sản phẩm có sẵn</small>';
                loadMoreBtn.parentElement.appendChild(completionMsg);
            }
        })
        .catch(error => {
            console.error('Error loading more products:', error);
            showNotification('Có lỗi xảy ra khi tải sản phẩm. Vui lòng thử lại!', 'error');
            // KHÔNG cần revert currentPage vì chưa tăng
        })
        .finally(() => {
            // Hide loading state
            loadMoreBtn.disabled = false;
            loadingSpinner.classList.add('d-none');
        });
}

// Create product card HTML
function createProductCard(product, index) {
    const colDiv = document.createElement('div');
    colDiv.className = 'col-lg-3 col-md-4 col-sm-6 mb-4 fade-in-up';
    colDiv.style.animationDelay = (index * 0.1) + 's';
    
    const contextPath = '${pageContext.request.contextPath}';
    const formattedPrice = new Intl.NumberFormat('vi-VN').format(product.donGia);
    
    colDiv.innerHTML = `
        <div class="product-card">
            ${index < 3 ? '<div class="badge-hot"><i class="fas fa-fire"></i> HOT</div>' : ''}
            
            <div class="product-image-container">
                <img src="${contextPath}/img/${product.hinhAnh}"
                     alt="${product.tenSP}"
                     class="product-image"
                     onerror="this.src='${contextPath}/img/Logo_HCMUTE.png';">
                
                <div class="product-overlay">
                    <div class="d-flex gap-2">
                        <a href="${contextPath}/guest/product?id=${product.maSP}" 
                           class="btn btn-warning btn-sm">
                            <i class="fas fa-eye"></i> Xem chi tiết
                        </a>
                        <button class="btn btn-success btn-sm" onclick="quickAddToCart(${product.maSP})">
                            <i class="fas fa-cart-plus"></i> Mua
                        </button>
                    </div>
                </div>
            </div>
            
            <div class="card-body p-3">
                <h6 class="card-title fw-bold mb-2" style="height: 48px; overflow: hidden;">
                    <a href="${contextPath}/guest/product?id=${product.maSP}" 
                       class="text-decoration-none text-dark">${product.tenSP}</a>
                </h6>
                
                <div class="price mb-2">
                    <span class="h5 text-danger fw-bold">
                        ${formattedPrice}₫
                    </span>
                </div>
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="rating">
                        <i class="fas fa-star text-warning"></i>
                        <i class="fas fa-star text-warning"></i>
                        <i class="fas fa-star text-warning"></i>
                        <i class="fas fa-star text-warning"></i>
                        <i class="fas fa-star text-warning"></i>
                        <span class="ms-1 small text-muted">(4.8)</span>
                    </div>
                    <small class="text-muted">
                        <i class="fas fa-chart-line"></i> ${product.soLuongBan}
                    </small>
                </div>
                
                <div class="d-grid">
                    <button class="btn btn-primary" onclick="addToCart(${product.maSP})">
                        <i class="fas fa-shopping-cart me-2"></i>Thêm vào giỏ
                    </button>
                </div>
            </div>
        </div>
    `;
    
    return colDiv;
}

// Add to cart functionality
function addToCart(productId) {
    // Check if user is logged in
    const isLoggedIn = '${sessionScope.user}' !== '';
    
    if (!isLoggedIn) {
        showNotification('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!', 'warning');
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/auth/login';
        }, 2000);
        return;
    }
    
    // Show loading
    showNotification('Đang thêm vào giỏ hàng...', 'info');
    
    // Make AJAX request to add to cart
    fetch('${pageContext.request.contextPath}/user/cart/add', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'productId=' + productId + '&quantity=1'
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('Đã thêm sản phẩm vào giỏ hàng!', 'success');
            // Update cart count in header if exists
            updateCartCount();
        } else {
            showNotification(data.message || 'Có lỗi xảy ra khi thêm vào giỏ hàng!', 'error');
        }
    })
    .catch(error => {
        console.error('Error adding to cart:', error);
        showNotification('Có lỗi xảy ra khi thêm vào giỏ hàng!', 'error');
    });
}

// Quick add to cart (same as addToCart but with different notification)
function quickAddToCart(productId) {
    addToCart(productId);
}

// Update cart count in header
function updateCartCount() {
    const cartCountElement = document.querySelector('.cart-count, .badge');
    if (cartCountElement) {
        fetch('${pageContext.request.contextPath}/user/cart/count')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    cartCountElement.textContent = data.count;
                    // Add animation to cart icon
                    cartCountElement.classList.add('animate__animated', 'animate__bounceIn');
                    setTimeout(() => {
                        cartCountElement.classList.remove('animate__animated', 'animate__bounceIn');
                    }, 1000);
                }
            })
            .catch(error => console.error('Error updating cart count:', error));
    }
}
</script>
</body>
</html>
