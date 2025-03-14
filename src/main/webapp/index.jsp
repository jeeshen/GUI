<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home Page | Jevore</title>
        <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:ital,opsz,wght@0,14..32,100..900;1,14..32,100..900&family=Special+Elite&display=swap" rel="stylesheet">
        <style type="text/tailwindcss">
            @theme {
                --font-inter: "Inter", sans-serif;
            }
        </style>
    </head>
    <body>
        <div class="w-100% flex justify-center">
            <img class="object-cover" src="images/logo.png" style="width: 160px; height: 90px;">
        </div>
        <div class="flex justify-center">
            <div class="w-1/2 flex justify-evenly">
                <a href="home.jsp" class="font-inter font-bold">HOME</a>
                <a href="product.jsp" class="font-inter font-bold">PRODUCT</a>
                <div>
                    <a href="cart.jsp" class="font-inter font-bold">CART</a>
                    <a href="login.jsp" class="font-inter font-bold">LOGIN</a>
                </div>
            </div>
        </div>
    </body>
</html>