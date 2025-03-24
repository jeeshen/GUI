<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.Cart, main.Product, java.util.Map, java.text.DecimalFormat" %>
<%@ page session="true" %>
<html>
    <%@ include file="components/header.jsp" %>
    <body class="bg-base-100 pb-150 font-inter">
        <div class="flex gap-10 mx-30">
            <%
                DecimalFormat df = new DecimalFormat("0.00");
                Map<Product, Integer> items = cart.getItems();
                if (!items.isEmpty()) {
            %>
            <div class="w-1/2 bg-base-200 p-10 rounded-lg">
                <div class="flex items-center gap-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>
                    <p class="text-2xl font-bold my-4">Your Cart</p>
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price (RM)</th>
                        <th>Line Total (RM)</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
                            Product product = entry.getKey();
                            int quantity = entry.getValue();
                    %>
                    <tr>
                        <td>
                            <div class="flex items-center gap-3">
                                <div class="avatar">
                                    <div class="mask mask-squircle h-12 w-12">
                                        <img
                                                src="<%= !product.getImageUrl().isEmpty() ? request.getContextPath() + "/" + product.getImageUrl() : "../images/empty product.png" %>"
                                                alt="Product Image" />
                                    </div>
                                </div>
                                <div>
                                    <div class="font-bold"><%=product.getName()%></div>
                                </div>
                            </div>
                        </td>
                        <td><%=df.format(product.getPrice())%></td>
                        <td><%=df.format(entry.getValue() * product.getPrice())%></td>
                        <td>
                            <div class="flex gap-4">
                                <form method="post" action="${pageContext.request.contextPath}/CartServlet">
                                    <input type="hidden" name="productID" value="<%=product.getId()%>"/>
                                    <input type="hidden" name="action" value="minus"/>
                                    <button type="submit">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-minus"><path d="M5 12h14"/></svg>
                                    </button>
                                </form>
                                <%=entry.getValue()%>
                                <form method="post" action="${pageContext.request.contextPath}/CartServlet">
                                    <input type="hidden" name="productID" value="<%=product.getId()%>"/>
                                    <input type="hidden" name="action" value="plus"/>
                                    <button type="submit">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-plus"><path d="M5 12h14"/><path d="M12 5v14"/></svg>
                                    </button>
                                </form>
                            </div>
                        </td>
                        <td>
                            <div class="flex gap-4">
                                <form method="post" action="${pageContext.request.contextPath}/CartServlet">
                                    <input type="hidden" name="productID" value="<%= product.getId() %>"/>
                                    <input type="hidden" name="action" value="delete"/>
                                    <button type="submit">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-trash-2"><path d="M3 6h18"/><path d="M19 6v14c0 1-1 2-2 2H7c-1 0-2-1-2-2V6"/><path d="M8 6V4c0-1 1-2 2-2h4c1 0 2 1 2 2v2"/><line x1="10" x2="10" y1="11" y2="17"/><line x1="14" x2="14" y1="11" y2="17"/></svg>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <div class="w-1/2 bg-base-200 p-10 rounded-lg">
                <div class="flex items-center gap-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-badge-percent"><path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/><path d="m15 9-6 6"/><path d="M9 9h.01"/><path d="M15 15h.01"/></svg>
                    <p class="text-2xl font-bold my-4">Price Breakdown</p>
                </div>
                <table class="table">
                    <tr>
                        <th>Item Count</th>
                        <td><%=cart.getTotalQuantity()%></td>
                    </tr>
                    <tr>
                        <th>Subtotal (RM)</th>
                        <td><%=df.format(cart.calculateTotal())%></td>
                    </tr>
                    <tr>
                        <th>Shipping Fee (RM)</th>
                        <td>7.00</td>
                    </tr>
                    <tr>
                        <th>6% SST (RM)</th>
                        <td><%=df.format(cart.calculateTotal() * 0.06)%></td>
                    </tr>
                    <tr>
                        <th class="text-lg">Total Price (RM)</th>
                        <td><%=df.format(cart.calculateTotal() + 7 + cart.calculateTotal() * 0.06)%></td>
                    </tr>
                </table>
            </div>
        </div>
        <form method="get" action="${pageContext.request.contextPath}/paymentMethod.jsp" onsubmit="return validateUserInfo()">
            <div class="flex gap-10 mx-30 mt-20">
                <div class="bg-base-200 p-10 rounded-lg w-1/3">
                    <div class="flex items-center gap-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hand-coins"><path d="M11 15h2a2 2 0 1 0 0-4h-3c-.6 0-1.1.2-1.4.6L3 17"/><path d="m7 21 1.6-1.4c.3-.4.8-.6 1.4-.6h4c1.1 0 2.1-.4 2.8-1.2l4.6-4.4a2 2 0 0 0-2.75-2.91l-4.2 3.9"/><path d="m2 16 6 6"/><circle cx="16" cy="9" r="2.9"/><circle cx="6" cy="5" r="3"/></svg>
                        <p class="text-2xl font-bold my-4">Payment Method</p>
                    </div>
                    <table class="table">
                        <tr>
                            <td><input type="radio" name="paymentMethod" value="cash" class="radio" checked="checked" /></td>
                            <td>Cash Payment</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="paymentMethod" value="bank" class="radio"/></td>
                            <td>Bank Transfer</td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="paymentMethod" value="credit" class="radio"/></td>
                            <td><img src="https://galado.com.my/gld-files/uploads/2015/06/major-Credit-Card-Logos-1024x211.png" width="200"></td>
                        </tr>
                        <tr>
                            <td><input type="radio" name="paymentMethod" value="tng" class="radio"/></td>
                            <td><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Touch_%27n_Go_eWallet_logo.svg/2024px-Touch_%27n_Go_eWallet_logo.svg.png" width="40"></td>
                        </tr>
                    </table>
                </div>
                <div class="bg-base-200 p-10 rounded-lg w-full">
                    <div class="flex items-center gap-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-badge-info"><path d="M3.85 8.62a4 4 0 0 1 4.78-4.77 4 4 0 0 1 6.74 0 4 4 0 0 1 4.78 4.78 4 4 0 0 1 0 6.74 4 4 0 0 1-4.77 4.78 4 4 0 0 1-6.75 0 4 4 0 0 1-4.78-4.77 4 4 0 0 1 0-6.76Z"/><line x1="12" x2="12" y1="16" y2="12"/><line x1="12" x2="12.01" y1="8" y2="8"/></svg>
                        <p class="text-2xl font-bold my-4">Your Information</p>
                    </div>
                    <table class="table">
                        <tr>
                            <td>Name</td>
                            <td class="flex flex-col">
                                <input type="text" placeholder="Your name" name="name" id="inputName" class="input" />
                                <span class="text-red-500 mt-2" id="inputNameError"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone Number</td>
                            <td class="flex flex-col">
                                <input type="text" placeholder="Your phone" name="phone" id="inputPhone" class="input" />
                                <span class="text-red-500 mt-2" id="inputPhoneError"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td class="flex flex-col">
                                <input type="text" placeholder="Your address" name="address" id="inputAddress" class="input" />
                                <span class="text-red-500 mt-2" id="inputAddressError"></span>
                            </td>
                        </tr>
                    </table>
                    <div class="w-full flex justify-center mt-15">
                        <button type="submit" class="btn btn-neutral w-full">Proceed Payment</button>
                    </div>
                </div>
            </div>
        </form>
        <% } else { %>
        <div class="w-full bg-base-200 p-10 rounded-lg">
            <div class="flex items-center gap-4">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>
                <p class="text-2xl font-bold my-4">Your Cart</p>
            </div>
            <p class="text-xl">Cart is empty. Add some products to proceed checkout.</p>
            <button onclick="window.location.href='product.jsp'" class="btn btn-neutral my-5">Add Products</button>
        </div>
        <% } %>
        <script>
            function validateUserInfo() {
                let isValid = true;

                let name = document.getElementById("inputName").value.trim();
                let phone = document.getElementById("inputPhone").value.trim();
                let address = document.getElementById("inputAddress").value.trim();

                document.getElementById("inputNameError").textContent = "";
                document.getElementById("inputPhoneError").textContent = "";
                document.getElementById("inputAddressError").textContent = "";

                if (name === "") {
                    document.getElementById("inputNameError").textContent = "Your name is required.";
                    isValid = false;
                }

                if (phone === "") {
                    document.getElementById("inputPhoneError").textContent = "Your phone number is required.";
                    isValid = false;
                }

                if (address === "") {
                    document.getElementById("inputAddressError").textContent = "Your address is required.";
                    isValid = false;
                }
                return isValid;
            }
        </script>
    </body>
</html>
