<head>
    <%
        String path = request.getRequestURI();
        String pageTitle = "Jevore"; // Default title

        if (path.contains("index.jsp")) {
            pageTitle = "Home | Jevore";
        } else if (path.contains("aboutus.jsp")) {
            pageTitle = "About Us | Jevore";
        } else if (path.contains("account.jsp")) {
            pageTitle = "Account | Jevore";
        } else if (path.contains("admin.jsp")) {
            pageTitle = "Admin | Jevore";
        }
        else {
            pageTitle = "Home | Jevore";
        }
    %>
    <title><%= pageTitle%></title>
    <link rel="icon" type="image/x-icon" href="/images/favicon.png">
    <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Special+Elite&display=swap" rel="stylesheet"><%
    <%
        if (path.contains("sidebar.jsp")) {
    %>
        <link href="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/flowbite@3.1.2/dist/flowbite.min.js"></script>
    <% } %>

    <style type="text/tailwindcss">
        @theme {
            --font-inter: "Inter", sans-serif;
        }
        body {
            margin-bottom: 50%;
        }
    </style>
</head>