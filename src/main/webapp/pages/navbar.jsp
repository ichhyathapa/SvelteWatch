<%@page import="com.svelte.model.User"%>

<%User user = (User) session.getAttribute("user");%>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/navbar.css" />
<!-- GOOGLE ICONS -->
<link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
    />

<header class="navbar">

    <div class="nav-container">

        <!-- LOGO -->
        <a href="${pageContext.request.contextPath}/watches.jsp"
           class="logo-container">

            <img
                src="${pageContext.request.contextPath}/images/logo.jpg"
                alt="Svelte Logo"
                class="logo-img"
                >

            <span class="logo-text">
                SVELTE
            </span>

        </a>

        <!-- NAVIGATION -->
        <nav class="nav-links">

            <a href="${pageContext.request.contextPath}/watches.jsp">
                HOME
            </a>

            <a href="${pageContext.request.contextPath}/product">
                WATCHES
            </a>

            <a href="${pageContext.request.contextPath}/pages/about.jsp">
                ABOUT US
            </a>

            <a href="${pageContext.request.contextPath}/pages/contact.jsp">
                CONTACT
            </a>

        </nav>

        <!-- RIGHT SECTION -->
        <div class="nav-right">

            <!-- SEARCH -->
            <form action="${pageContext.request.contextPath}/product"
                  method="get"
                  class="search-form">

                <input type="hidden" name="action" value="search">

                <span class="material-symbols-outlined search-icon">
                    search
                </span>

                <input type="text"
                       name="search"
                       placeholder="Search watches..."
                       class="search">

            </form>

            <!-- AUTH SECTION -->
            <div class="auth">

                <% if (user == null) { %>

                <!-- GUEST  -->
                <a href="${pageContext.request.contextPath}/login.jsp">
                    LOGIN
                </a>

                <% } else { %>

                <!-- LOGGED IN USER -->

                <!-- USER ICON -->
                <a href="${pageContext.request.contextPath}/pages/profile.jsp"
                   class="user-icon">

                    <span class="material-symbols-outlined">
                        person
                    </span>

                </a>

                <!-- LOGOUT -->
                <a href="${pageContext.request.contextPath}/logout">
                    LOGOUT
                </a>

                <% }%>

            </div>

        </div>

    </div>

</header>