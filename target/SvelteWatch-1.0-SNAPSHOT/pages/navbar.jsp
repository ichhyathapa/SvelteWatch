<!-- GOOGLE ICONS -->
<link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
    />

<header class="navbar">

    <div class="nav-container">

        <!-- LOGO -->
        <a href="dashboard" class="logo-container">

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

            <a href="dashboard" class="active">HOME</a>

            <a href="watches">WATCHES</a>

            <a href="about.jsp">ABOUT US</a>

            <a href="contact.jsp">CONTACT</a>

        </nav>

        <!-- RIGHT SECTION -->
        <div class="nav-right">

            <!-- SEARCH -->
            <form action="watches" method="get" class="search-form">

                <span class="material-symbols-outlined search-icon">
                    search
                </span>

                <input
                    type="text"
                    name="search"
                    placeholder="Search watches..."
                    class="search"
                    >

            </form>

            <!-- LOGIN -->
            <div class="auth">

                <a href="login">LOGIN</a>

            </div>

            <!-- USER ICON -->
            <a href="profile.jsp" class="user-icon">

                <span class="material-symbols-outlined">
                    person
                </span>

            </a>

        </div>

    </div>

</header>