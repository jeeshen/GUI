<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home Page | Jevore</title>
        <script src="https://unpkg.com/@tailwindcss/browser@4"></script>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@5" rel="stylesheet" type="text/css" />
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
            <img class="object-cover" src="images/logo.png" style="width: 150px; height: 90px;">
        </div>
        <div class="flex justify-center mb-10">
            <div class="w-1/2 flex justify-evenly">
                <a href="home.jsp" class="font-inter font-semibold">HOME</a>
                <a href="aboutus.jsp" class="font-inter font-semibold">ABOUT US</a>
                <a href="product.jsp" class="font-inter font-semibold">PRODUCT</a>
                <div class="flex justify-evenly w-70">
                    <a href="search.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg></a>
                    <a href="cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg></a>
                    <a href="login.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg></a>
                </div>
            </div>
        </div>
        <div class="flex justify-evenly">
            <div class="card bg-base-100 w-96 shadow-sm">
                <figure>
                    <img
                            src="https://img.daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.webp"
                            alt="Shoes" />
                </figure>
                <div class="card-body">
                    <h2 class="card-title">Card Title</h2>
                    <p>A card component has a figure, a body part, and inside body there are title and actions parts</p>
                    <div class="card-actions justify-end">
                        <button class="btn btn-primary">Buy Now</button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>