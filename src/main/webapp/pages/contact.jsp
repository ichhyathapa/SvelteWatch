<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>

    <head>

        <!-- PAGE TITLE -->
        <title>Contact Us | SVELTE</title>

        <!-- NAVBAR CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/navbar.css">

        <!-- CONTACT PAGE CSS -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/contact.css">

        <!-- GOOGLE FONT -->
        <link rel="preconnect"
              href="https://fonts.googleapis.com">

        <link rel="preconnect"
              href="https://fonts.gstatic.com"
              crossorigin>

        <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;500;600;700&family=Montserrat:wght@300;400;500;600&display=swap"
              rel="stylesheet">

        <!-- GOOGLE ICONS -->
        <link rel="stylesheet"
              href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined">

    </head>

    <body>

        <!-- FORM SUBMISSION REDIRECT -->
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {

                response.sendRedirect(
                        "contact.jsp?success=true"
                );

                return;
            }
        %>

        <!-- NAVBAR -->
        <jsp:include page="/pages/navbar.jsp" />


        <!-- HERO SECTION -->

        <section class="contact-hero">

            <!-- HERO CONTENT -->
            <div class="contact-overlay">

                <span>CONTACT SVELTE</span>

                <h1>
                    Let’s Connect With Elegance
                </h1>

                <p>
                    Reach out to SVELTE for luxury timepieces,
                    customer assistance, and premium online support.
                </p>

            </div>

        </section>


        <!-- CONTACT SECTION -->

        <section class="contact-section">

            <!-- LEFT SIDE -->
            <div class="contact-info">

                <span>GET IN TOUCH</span>

                <h2>
                    We’re Always Ready To Assist You
                </h2>

                <p>
                    SVELTE is an online luxury watch destination
                    dedicated to premium craftsmanship and timeless style.
                    Our support team is available for inquiries,
                    collections, and personalized assistance.
                </p>


                <!-- ONLINE STORE -->
                <div class="info-box">

                    <span class="material-symbols-outlined">
                        language
                    </span>

                    <div>
                        <h3>Online Store</h3>
                        <p>www.sveltewatches.com</p>
                    </div>

                </div>


                <!-- EMAIL SUPPORT -->
                <div class="info-box">

                    <span class="material-symbols-outlined">
                        mail
                    </span>

                    <div>
                        <h3>Email Support</h3>
                        <p>support@svelte.com</p>
                    </div>

                </div>


                <!-- AVAILABILITY -->
                <div class="info-box">

                    <span class="material-symbols-outlined">
                        schedule
                    </span>

                    <div>
                        <h3>Availability</h3>
                        <p>24/7 Online Customer Assistance</p>
                    </div>

                </div>

            </div>


            <!-- RIGHT SIDE -->
            <div class="contact-form-box">

                <!-- SUCCESS MESSAGE -->
                <%
                    String success
                            = request.getParameter("success");

                    if (success != null) {
                %>

                <p class="success-message"
                   id="successMessage">
                    Message sent successfully!
                </p>

                <!-- AUTO HIDE SUCCESS MESSAGE -->
                <script>

                    setTimeout(function () {

                        const msg =
                                document.getElementById(
                                        "successMessage"
                                        );

                        if (msg) {
                            msg.style.display = "none";
                        }

                    }, 6000);

                </script>

                <%
                    }
                %>

                <!-- CONTACT FORM -->
                <form action="contact.jsp"
                      method="post">

                    <!-- FULL NAME -->
                    <input type="text"
                           name="fullName"
                           placeholder="Full Name"
                           required>

                    <!-- EMAIL -->
                    <input type="email"
                           name="email"
                           placeholder="Email Address"
                           required>

                    <!-- SUBJECT -->
                    <input type="text"
                           name="subject"
                           placeholder="Subject">

                    <!-- MESSAGE -->
                    <textarea rows="6"
                              name="message"
                              placeholder="Your Message"
                              required></textarea>

                    <!-- SUBMIT BUTTON -->
                    <button type="submit">
                        SEND MESSAGE
                    </button>

                </form>

            </div>

        </section>


        <!-- ONLINE SUPPORT SECTION -->

        <section class="online-support">

            <!-- LEFT CONTENT -->
            <div class="support-left">

                <span>ONLINE EXPERIENCE</span>

                <h2>
                    Premium Digital
                    Customer Care
                </h2>

                <p>
                    Enjoy seamless luxury shopping with trusted support,
                    secure orders, and worldwide online assistance from SVELTE.
                </p>

            </div>


            <!-- RIGHT CONTENT -->
            <div class="support-right">

                <!-- SUPPORT ITEM 1 -->
                <div class="support-item">

                    <span class="material-symbols-outlined">
                        verified_user
                    </span>

                    <div>
                        <h3>Secure Payments</h3>

                        <p>
                            Protected checkout and trusted
                            online transactions.
                        </p>
                    </div>

                </div>


                <!-- SUPPORT ITEM 2 -->
                <div class="support-item">

                    <span class="material-symbols-outlined">
                        local_shipping
                    </span>

                    <div>
                        <h3>Fast Delivery</h3>

                        <p>
                            Luxury timepieces delivered
                            safely to your doorstep.
                        </p>
                    </div>

                </div>


                <!-- SUPPORT ITEM 3 -->
                <div class="support-item">

                    <span class="material-symbols-outlined">
                        support_agent
                    </span>

                    <div>
                        <h3>24/7 Assistance</h3>

                        <p>
                            Dedicated online support whenever
                            you need assistance.
                        </p>
                    </div>

                </div>

            </div>

        </section>


        <!-- FOOTER -->
        <jsp:include page="/pages/footer.jsp" />

    </body>

</html>