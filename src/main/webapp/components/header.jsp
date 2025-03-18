<%@ include file="head.jsp"%>
<div class="flex justify-between mb-10">
    <img class="ml-10 object-cover" src="../images/logo.png" style="width: 150px; height: 90px;">
    <div class="w-1/2 my-8 flex justify-evenly">
        <a href="../index.jsp" class="font-inter font-semibold">HOME</a>
        <a href="../aboutus.jsp" class="font-inter font-semibold">ABOUT US</a>
        <a href="product.jsp" class="font-inter font-semibold">PRODUCTS</a>
    </div>
    <div class="flex my-8 justify-evenly w-70">
        <a href="search.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-search"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg></a>
<%--        <div class="indicator">--%>
<%--            <span class="indicator-item status status-error"></span>--%>
<%--            <a href="cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg></a>--%>
<%--        </div>--%>
        <a href="cart.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg></a>
        <a href="../account.jsp"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-user"><path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg></a>
    </div>
</div>
<div class="fixed bottom-0 inset-0 bg-black flex justify-center z-[-1]">
    <img src="../images/logo2.png" class="w-100 h-auto object-contain">
</div>
