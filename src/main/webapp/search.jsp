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
            String query = request.getParameter("query");
            List<Product> productList;

            if (query != null && !query.trim().isEmpty()) {
                productList = ProductDB.searchProducts(query.trim());
            } else {
                productList = ProductDB.getAllProducts();
            }

            DecimalFormat formatter = new DecimalFormat("#,##0.00");
        %>

        <p class="w-1/2 text-black-500 font-inter text-5xl font-bold pl-30">Search Product</p>
        <p class="mt-20 mb-5 w-1/2 text-black-500 font-inter text-2xl font-bold pl-30">Looking for specific item? <span class="text-gray-500"> Find what your need here.</span></p>
        <div class="w-full flex justify-center my-10">
            <form action="search.jsp" method="GET" class="w-full flex justify-center my-10">
                <div class="join">
                    <div>
                        <label class="input pl-0">
                            <svg class="h-[1em] opacity-50" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                <g stroke-linejoin="round" stroke-linecap="round" stroke-width="2.5" fill="none" stroke="currentColor">
                                    <circle cx="11" cy="11" r="8"></circle>
                                    <path d="m21 21-4.3-4.3"></path>
                                </g>
                            </svg>
                            <input type="search" name="query" class="input-3xl" required placeholder="Search"/>
                        </label>
                    </div>
                    <button class="btn btn-neutral ml-4">Search</button>
                </div>
            </form>
        </div>
        <div class="grid grid-cols-4 gap-8 ml-30 mr-20">
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
                <div class="text-center w-full py-10 flex justify-center col-span-4">
                    <p class="text-lg text-gray-500">No products found at the moment.</p>
                </div>
            <% } %>
        </div>
    </body>
</html>