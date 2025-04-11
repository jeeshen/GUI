<%@ include file="head.jsp"%>
<%@ page import="main.Cart" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
%>
<%--Header for every page and show user status dynamically--%>
<div class="flex justify-between mb-10 font-inter">
    <img class="ml-10 object-cover" src="../images/logo.png" style="width: 150px; height: 90px;">
    <div class="w-1/2 my-8 flex justify-evenly">
        <a href="index.jsp" class="font-inter font-semibold">HOME</a>
        <a href="aboutus.jsp" class="font-inter font-semibold">ABOUT US</a>
        <a href="product.jsp" class="font-inter font-semibold">PRODUCTS</a>
        <% if (sessionRole.equals("STAFF") || sessionRole.equals("MANAGER")) { %>
            <a href="admin/home.jsp" class="font-inter font-semibold">MANAGE</a>
        <% } %>
    </div>
    <div class="flex my-8 justify-evenly w-70">
        <a href="search.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg></a>
        <div class="flex gap-2">
            <a href="../cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg></a>
            <span class="badge badge-soft badge-secondary"><%=cart.getTotalQuantity()%></span>
        </div>
        <% if (sessionName.isEmpty()) { %>
            <a href="../account.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg></a>
        <% } else {%>
        <div class="dropdown dropdown-center flex items-center">
            <div tabindex="0" role="button">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user-cog"><circle cx="18" cy="15" r="3"/><circle cx="9" cy="7" r="4"/><path d="M10 15H6a4 4 0 0 0-4 4v2"/><path d="m21.7 16.4-.9-.3"/><path d="m15.2 13.9-.9-.3"/><path d="m16.6 18.7.3-.9"/><path d="m19.1 12.2.3-.9"/><path d="m19.6 18.7-.4-1"/><path d="m16.8 12.3-.4-1"/><path d="m14.3 16.6 1-.4"/><path d="m20.7 13.8 1-.4"/></svg>
            </div>
            <ul tabindex="0" class="menu dropdown-content bg-base-200 rounded-box z-10 mt-4 w-52 p-20 shadow-sm">
                <li class="w-full"><a href="order.jsp" class="font-semibold">ORDERS</a></li>
                <li class="w-full"><a href="${pageContext.request.contextPath}/LogoutServlet" class="font-semibold">LOGOUT</a></li>
            </ul>
        </div>
        <% } %>
    </div>
</div>
<div class="fixed bottom-0 inset-0 bg-black flex justify-center z-[-1]">
    <img src="../images/logo2.png" class="w-100 h-auto object-contain">
</div>
