<!DOCTYPE html>
<html>

    <head>

        <!-- PAGE TITLE -->
        <title>Watches | Svelte</title>

        <!-- GOOGLE FONTS -->
        <link rel="preconnect" href="https://fonts.googleapis.com">

        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap"
              rel="stylesheet">

        <!-- NAVBAR CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/navbar.css">

        <!-- PAGE CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/watches.css">

    </head>

    <body>

        <!-- NAVBAR -->
        <jsp:include page="/pages/navbar.jsp" />

        <!-- HERO SECTION -->
        <section class="hero"

                 style="
                 background:
                 linear-gradient(
                 rgba(248,246,242,0.72),
                 rgba(248,246,242,0.72)),
                 url('${pageContext.request.contextPath}/images/about_banner.jpg');

                 background-size:cover;
                 background-position:center;
                 ">

            <!-- HERO LEFT -->
            <div class="hero-left">

                <!-- HERO TAG -->
                <span class="hero-tag">
                    LIMITED EDITION
                </span>

                <!-- HERO TITLE -->
                <h1>
                    The Heritage <br>
                    Chronograph 1954
                </h1>

                <!-- HERO DESCRIPTION -->
                <p>
                    Precision engineering meets timeless aesthetic.
                    Crafted for those who value elegance, luxury,
                    and classic horology.
                </p>

                <!-- HERO BUTTONS -->
                <div class="hero-buttons">

                    <!-- DISCOVER BUTTON -->
                    <a href="${pageContext.request.contextPath}/product?action=view"
                       class="btn-dark">
                        DISCOVER
                    </a>

                    <!-- COLLECTION BUTTON -->
                    <a href="${pageContext.request.contextPath}/product?action=view"
                       class="btn-light">
                        COLLECTION
                    </a>

                </div>

            </div>

            <!-- HERO IMAGE -->
            <div class="hero-right">

                <img src="images/hero_image.png"
                     alt="Luxury Watch">

            </div>

        </section>

        <!-- FEATURED SECTION -->
        <section class="featured-section">

            <!-- SECTION TITLE -->
            <div class="section-title">

                <span>FEATURED TIMEPIECES</span>

            </div>

            <!-- WOMEN CATEGORY -->
            <div class="watch-category">

                <!-- CATEGORY HEADER -->
                <div class="category-header">

                    <h1>GRACEFUL TIMEPIECES FOR HER</h1>

                    <p>
                        Elegant designs crafted for women who appreciate timeless beauty,
                        sophistication, and luxury in every second.
                    </p>

                </div>

                <!-- WOMEN WATCH GRID -->
                <div class="watch-grid">

                    <!-- PRODUCT 9 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=9">

                            <img src="images/w1.png" alt="Royal Oak">

                            <div class="watch-info">

                                <h3>Royal Oak</h3>

                                <p>NPR 6,670</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 10 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=10">

                            <img src="images/w2.png" alt="watch">

                            <div class="watch-info">

                                <h3>Luxury Gold</h3>

                                <p>NPR 7,790</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 11 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=11">

                            <img src="images/w3.png" alt="watch">

                            <div class="watch-info">

                                <h3>Lady President</h3>

                                <p>NPR 8,990</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 14 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=14">

                            <img src="images/w4.png" alt="watch">

                            <div class="watch-info">

                                <h3>LTP-V007D</h3>

                                <p>NPR 10,290</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 16 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=16">

                            <img src="images/w5.png" alt="watch">

                            <div class="watch-info">

                                <h3>Classic Silver</h3>

                                <p>NPR 6,670</p>

                            </div>

                        </a>

                    </div>

                </div>

            </div>

            <!-- MEN CATEGORY -->
            <div class="watch-category">

                <!-- CATEGORY HEADER -->
                <div class="category-header">

                    <h1>CLASSIC WATCHES FOR HIM</h1>

                    <p>
                        Premium designs tailored for men who value elegance,
                        reliability, and timeless appeal.
                    </p>

                </div>

                <!-- MEN WATCH GRID -->
                <div class="watch-grid">

                    <!-- PRODUCT 1 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=1">

                            <img src="images/m1.png" alt="Cosmograph">

                            <div class="watch-info">

                                <h3>Cosmograph</h3>

                                <p>NPR 6,670</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 4 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=4">

                            <img src="images/m2.jpg" alt="Swiss Movement">

                            <div class="watch-info">

                                <h3>Swiss Movement</h3>

                                <p>NPR 7,790</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 6 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=6">

                            <img src="images/m3.png" alt="Nautilus">

                            <div class="watch-info">

                                <h3>Nautilus</h3>

                                <p>NPR 8,990</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 2 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=2">

                            <img src="images/m4.png" alt="MTP-1302PD">

                            <div class="watch-info">

                                <h3>MTP-1302PD</h3>

                                <p>NPR 10,290</p>

                            </div>

                        </a>

                    </div>

                    <!-- PRODUCT 8 -->
                    <div class="watch-card">

                        <a href="${pageContext.request.contextPath}/product?action=details&id=8">

                            <img src="images/m5.png" alt="Platinum Lee Blue">

                            <div class="watch-info">

                                <h3>Platinum Lee Blue</h3>

                                <p>NPR 10,290</p>

                            </div>

                        </a>

                    </div>

                </div>

            </div>

        </section>

        <!-- FOOTER -->
        <jsp:include page="/pages/footer.jsp" />

    </body>

</html>