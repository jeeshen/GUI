<%@ page import="database.OrderDB" %>
<%@ page import="main.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-base-100 pb-20">
        <p class="w-1/2 text-black-500 font-inter text-5xl font-bold pl-30">Jevore. <span class="text-gray-500">Best place to buy the <br/>products you love.</span></p>
        <p class="w-1/2 text-black-500 font-inter text-2xl font-bold pl-30 mt-30 mb-5">Promotions. <span class="text-gray-500">Get goods for better prices.</span></p>
        <div class="flex justify-left gap-8 mx-30">
            <% for (int i = 0; i < 4; i++) { %>
                <div class="relative shadow-2xl w-100 h-130 rounded-[1rem] transition duration-300 ease-in-out hover:scale-103">
                    <div class="text-white absolute top-10 left-10">
                        <p class="text-3xl font-semibold">jPhone 16 Pro</p>
                        <p class="text-xl">From RM 3,000</p>
                    </div>
                    <img class="object-fill w-full h-full rounded-[1rem]" src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/store-card-40-iphone-16-pro-202409?wid=800&hei=1000&fmt=jpeg&qlt=95&.v=1726165763242" alt="promotion">
                </div>
            <% } %>
        </div>
        <p class="w-1/2 text-black-500 font-inter text-2xl font-bold pl-30 mt-30 mb-5">Top Product. <span class="text-gray-500">Product loved by majority.</span></p>
        <div class="grid grid-cols-4 gap-8 ml-30 mr-20">
            <%
                DecimalFormat formatter = new DecimalFormat("#,##0.00");
                List<Product> productList = OrderDB.getTopSoldProducts(4);
                if (productList != null && !productList.isEmpty()) {
                    for (Product product : productList) {
            %>
                <form method="post" action="${pageContext.request.contextPath}/CartServlet">
                    <div class="transition duration-300 ease-in-out hover:scale-103">
                        <div class="card bg-base-100 w-80 h-110 shadow-2xl">
                            <figure class="h-200">
                                <a href="${pageContext.request.contextPath}/productDetail.jsp?productID=<%=product.getId()%>">
                                    <img class="object-contain w-full h-full"
                                         src="<%= !product.getImageUrl().isEmpty() ? request.getContextPath() + "/" + product.getImageUrl() : "images/empty product.png" %>"
                                         alt="<%= product.getName() %>" />
                                </a>
                            </figure>
                            <div class="card-body">
                                <div class="ml-2">
                                    <h2 class="card-title text-2xl font-semibold"><%= product.getName() %></h2>
                                    <% if (product.getDescription() != null && !product.getDescription().isEmpty()) { %>
                                    <% } %>
                                    <div class="card-actions mt-3 justify-evenly">
                                        <p class="text-lg my-auto">RM <%= formatter.format(product.getPrice()) %></p>
                                        <% if (product.getStockQuantity() > 0) { %>
                                        <button type="submit" class="btn btn-neutral">ADD TO CART</button>
                                        <% } else { %>
                                        <span class="btn btn-disabled text-red-500 font-bold">OUT OF STOCK</span>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productID" value="<%=product.getId()%>"/>
                    <input type="hidden" name="quantity" value="1"/>
                </form>
            <% } %>
        <% } else { %>
            <% for (int i = 0; i < 4; i++) { %>
                <div class="transition duration-300 ease-in-out hover:scale-103">
                    <div class="card bg-base-100 w-80 h-110 shadow-2xl">
                        <figure class="h-200">
                            <img class="object-contain w-full h-full"
                                 src="https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-card-40-iphone16prohero-202409?wid=680&hei=528&fmt=p-jpg&qlt=95&.v=1725567335931"
                                 alt="topsold" />
                        </figure>
                        <div class="card-body">
                            <div class="ml-2">
                                <h2 class="card-title text-xl">JPhone <%= i + 1 %></h2>
                                <div class="card-actions mt-3 justify-evenly">
                                    <p class="text-md my-auto">RM <%= String.format("%,d", new java.util.Random().nextInt(3001) + 1000) %>.00</p>
                                    <button class="btn btn-neutral">ADD TO CART</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            <% } %>
        <% } %>
        </div>
        <p class="w-1/2 text-black-500 font-inter text-2xl font-bold pl-30 mt-30 mb-5">Why choose us. <span class="text-gray-500">Even more reasons to shop with us.</span></p>
        <div class="flex justify-left gap-8 mx-30">
            <div class="relative shadow-2xl w-80 h-60 rounded-[1rem] transition duration-300 ease-in-out hover:scale-103 p-5 px-7">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-credit-card size-12 text-green-500"><rect width="20" height="14" x="2" y="5" rx="2"/><line x1="2" x2="22" y1="10" y2="10"/></svg>
                <p class="text-2xl font-semibold mt-3">Pay 0% interest for up <br/>to 25 months.</p>
            </div>
            <div class="relative shadow-2xl w-80 h-60 rounded-[1rem] transition duration-300 ease-in-out hover:scale-103 p-5 px-7">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-truck size-12 text-blue-500"><path d="M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2"/><path d="M15 18H9"/><path d="M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.624l-3.48-4.35A1 1 0 0 0 17.52 8H14"/><circle cx="17" cy="18" r="2"/><circle cx="7" cy="18" r="2"/></svg>
                <p class="text-2xl font-semibold mt-3">Get <span class="text-blue-500">free delivery</span> or <br/><span class="text-blue-500">pick up </span>available item <br/>at nearby store.</p>
            </div>
            <div class="relative shadow-2xl w-80 h-60 rounded-[1rem] transition duration-300 ease-in-out hover:scale-103 p-5 px-7">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-gem size-12 text-purple-500"><path d="M6 3h12l4 6-10 13L2 9Z"/><path d="M11 3 8 9l4 13 4-13-3-6"/><path d="M2 9h20"/></svg>
                <p class="text-2xl font-semibold mt-3">Great <span class="text-purple-500">quality</span> and <br/>super long <span class="text-purple-500">life span</span>.</p>
            </div>
            <div class="relative shadow-2xl w-80 h-60 rounded-[1rem] transition duration-300 ease-in-out hover:scale-103 p-5 px-7">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-thumbs-up size-12 text-blue-500"><path d="M7 10v12"/><path d="M15 5.88 14 10h5.83a2 2 0 0 1 1.92 2.56l-2.33 8A2 2 0 0 1 17.5 22H4a2 2 0 0 1-2-2v-8a2 2 0 0 1 2-2h2.76a2 2 0 0 0 1.79-1.11L12 2a3.13 3.13 0 0 1 3 3.88Z"/></svg>
                <p class="text-2xl font-semibold mt-3">Quick <span class="text-blue-500">customer service</span> and easy <span class="text-blue-500">warranty process</span>.</p>
            </div>
        </div>
    </body>
</html>