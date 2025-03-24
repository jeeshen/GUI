<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="main.UserInfo, main.Product, java.util.Map, java.text.DecimalFormat" %>
<%@ page import="javax.xml.registry.infomodel.User" %>
<%@ page session="true" %>
<html>
    <%@ include file="components/header.jsp" %>
    <%
        DecimalFormat df = new DecimalFormat("0.00");
        Map<Product, Integer> items = cart.getItems();
        if (items.isEmpty()) {
            response.sendRedirect("products.jsp");
        }
        String paymentMethod = request.getParameter("paymentMethod");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        UserInfo user = new UserInfo(name, phone, address);
    %>
    <body class="bg-base-100 pb-150 font-inter">
        <div class="flex gap-10 mx-30">
            <div class="w-1/2 bg-base-200 p-10 rounded-lg">
                <div class="flex items-center gap-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-shopping-cart"><circle cx="8" cy="21" r="1"/><circle cx="19" cy="21" r="1"/><path d="M2.05 2.05h2l2.66 12.42a2 2 0 0 0 2 1.58h9.78a2 2 0 0 0 1.95-1.57l1.65-7.43H5.12"/></svg>
                    <p class="text-2xl font-bold my-4">Your Checkout List</p>
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price (RM)</th>
                        <th>Line Total (RM)</th>
                        <th>Quantity</th>
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
                        <td><%=product.getPrice()%></td>
                        <td><%=entry.getValue() * product.getPrice()%></td>
                        <td>
                            <div class="flex gap-4">
                                <%=entry.getValue()%>
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

        <form method="get" action="${pageContext.request.contextPath}/paymentMethod.jsp">
            <div class="flex gap-10 mx-30 mt-20">
                <div class="bg-base-200 p-10 rounded-lg w-1/3">
                    <div class="flex items-center gap-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hand-coins"><path d="M11 15h2a2 2 0 1 0 0-4h-3c-.6 0-1.1.2-1.4.6L3 17"/><path d="m7 21 1.6-1.4c.3-.4.8-.6 1.4-.6h4c1.1 0 2.1-.4 2.8-1.2l4.6-4.4a2 2 0 0 0-2.75-2.91l-4.2 3.9"/><path d="m2 16 6 6"/><circle cx="16" cy="9" r="2.9"/><circle cx="6" cy="5" r="3"/></svg>
                        <p class="text-2xl font-bold my-4">Payment Method</p>
                    </div>
                    <%
                        if (paymentMethod.equals("cash")) {
                    %>
                    <div>
                        <p class="text-lg">Please ready the right amount of cash and pass it to courier upon arrival.</p>
                    </div>
                    <% } else if (paymentMethod.equals("bank")) { %>
                    <div>
                        <p class="text-md">Please transfer to following: </p>
                        <table class="table">
                            <tr>
                                <th>Bank</th>
                                <td>Maybank Bank</td>
                            </tr>
                            <tr>
                                <th>Bank Account Name</th>
                                <td>Jevore Sdn Bhd</td>
                            </tr>
                            <tr>
                                <th>Bank Account Number</th>
                                <td>21231312312313212313112313</td>
                            </tr>
                        </table>
                    </div>
                    <% } else if (paymentMethod.equals("credit")) { %>
                    <div>
                        <p class="text-md">Please enter to following: </p>
                        <table class="table">
                            <tr>
                                <th>Card Number</th>
                                <td><input type="text" placeholder="Your card number" name="cardNumber" class="input" /></td>
                            </tr>
                            <tr>
                                <th>CCV</th>
                                <td><input type="text" placeholder="Your card CCV" name="ccv" class="input" /></td>
                            </tr>
                            <tr>
                                <th>Expiry Date</th>
                                <td><input type="text" placeholder="Your card expiry date" name="expiryDate" class="input" /></td>
                            </tr>
                        </table>
                    </div>
                    <% } else { %>
                    <div>
                        <img src="images/tng.jpg" alt="tng">
                    </div>
                    <% }%>
                </div>
                <div class="bg-base-200 p-10 rounded-lg w-full">
                    <div class="flex items-center gap-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-hand-coins"><path d="M11 15h2a2 2 0 1 0 0-4h-3c-.6 0-1.1.2-1.4.6L3 17"/><path d="m7 21 1.6-1.4c.3-.4.8-.6 1.4-.6h4c1.1 0 2.1-.4 2.8-1.2l4.6-4.4a2 2 0 0 0-2.75-2.91l-4.2 3.9"/><path d="m2 16 6 6"/><circle cx="16" cy="9" r="2.9"/><circle cx="6" cy="5" r="3"/></svg>
                        <p class="text-2xl font-bold my-4">Your Information</p>
                    </div>
                    <table class="table">
                        <tr>
                            <td>Name</td>
                            <td><input type="text" placeholder="Your name" name="name" class="input" /></td>
                        </tr>
                        <tr>
                            <td>Email</td>
                            <td><input type="text" placeholder="Your email" name="email" class="input" /></td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td><input type="text" placeholder="Your address" name="address" class="input" /></td>
                        </tr>
                    </table>
                    <div class="w-full flex justify-center mt-15">
                        <button type="submit" class="btn btn-success w-full">Proceed Payment</button>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
