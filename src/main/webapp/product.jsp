<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.Product" %>
<%@ page import="database.ProductDB" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-base-100 pb-150">
        <%
            List<Product> productList = ProductDB.getAllProducts();
            DecimalFormat formatter = new DecimalFormat("#,##0.00");
        %>

        <p class="w-1/2 text-black-500 font-inter text-5xl font-bold pl-30">Shop Jevore</p>
        <p class="mt-20 mb-5 w-1/2 text-black-500 font-inter text-2xl font-bold pl-30">All Models.<span class="text-gray-500">Take your pick.</span></p>

        <div class="grid grid-cols-6 gap-4 mx-30">
            <% if (productList != null && !productList.isEmpty()) { %>
            <% for (Product product : productList) { %>
            <div class="transition duration-300 ease-in-out hover:scale-103">
                <div class="card bg-base-100 w-80 h-110 shadow-2xl">
                    <figure class="h-200">
                        <img class="object-contain w-full h-full"
                             src="<%= !product.getImageUrl().isEmpty() ? request.getContextPath() + "/" + product.getImageUrl() : "images/empty product.png" %>"
                             alt="<%= product.getName() %>" />
                    </figure>
                    <div class="card-body">
                        <div class="ml-2">
                            <h2 class="card-title text-2xl font-semibold"><%= product.getName() %></h2>
                            <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                            <% } %>
                            <div class="card-actions mt-3 justify-evenly">
                                <p class="text-lg my-auto">RM <%= formatter.format(product.getPrice()) %></p>
                                <button class="btn btn-neutral">ADD TO CART</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <div class="text-center w-full py-10">
                <p class="text-lg text-gray-500">No products available at the moment.</p>
            </div>
            <% } %>
        </div>
    </body>
</html>