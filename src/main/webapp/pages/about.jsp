<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <!-- PAGE TITLE -->
        <title>About Us | Svelte</title>

        <!-- NAVBAR CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/navbar.css">

        <!-- ABOUT PAGE CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/about.css">

    </head>

    <body>

        <!-- NAVBAR -->
        <jsp:include page="/pages/navbar.jsp" />



        <!-- HERO SECTION -->

        <section class="about-hero">

            <!-- HERO OVERLAY CONTENT -->
            <div class="about-overlay">

                <span>ABOUT SVELTE</span>

                <h1>
                    Timeless Luxury Crafted With Precision
                </h1>

                <p>
                    SVELTE creates premium timepieces that combine
                    elegance, craftsmanship, and innovation for
                    individuals who value sophistication in every second.
                </p>

            </div>

        </section>



        <!-- STORY SECTION -->

        <section class="about-section">

            <!-- STORY IMAGE -->
            <div class="about-image">

                <img src="${pageContext.request.contextPath}/images/about_watch.jpg"
                     alt="Luxury Watch">

            </div>

            <!-- STORY CONTENT -->
            <div class="about-content">

                <span>OUR STORY</span>

                <h2>
                    Inspired By Modern Elegance
                </h2>

                <p>
                    Since our beginning, SVELTE has focused on creating
                    watches that represent timeless beauty and exceptional
                    craftsmanship. Every collection is designed to reflect
                    luxury, confidence, and precision.
                </p>

                <p>
                    Our watches are more than accessories —
                    they are statements of personality, ambition,
                    and refined taste.
                </p>

            </div>

        </section>



        <!-- VALUES SECTION -->

        <section class="values-section">

            <!-- SECTION TITLE -->
            <div class="section-title">

                <span>WHY CHOOSE US</span>

                <h2>
                    The SVELTE Experience
                </h2>

            </div>


            <!-- VALUES GRID -->
            <div class="values-grid">

                <!-- VALUE CARD 1 -->
                <div class="value-card">

                    <span class="material-symbols-outlined">
                        diamond
                    </span>

                    <h3>Luxury Design</h3>

                    <p>
                        Premium aesthetics inspired by timeless
                        elegance and modern fashion.
                    </p>

                </div>


                <!-- VALUE CARD 2 -->
                <div class="value-card">

                    <span class="material-symbols-outlined">
                        watch
                    </span>

                    <h3>Precision Craftsmanship</h3>

                    <p>
                        Designed with accuracy and attention
                        to every detail.
                    </p>

                </div>


                <!-- VALUE CARD 3 -->
                <div class="value-card">

                    <span class="material-symbols-outlined">
                        verified
                    </span>

                    <h3>Trusted Quality</h3>

                    <p>
                        Crafted using durable materials for
                        long-lasting luxury.
                    </p>

                </div>

            </div>

        </section>



        <!-- FOOTER -->
        <jsp:include page="/pages/footer.jsp" />

    </body>

</html>