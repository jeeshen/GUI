<%@ page import="java.util.List" %>
<%@ page import="main.Order" %>
<%@ page import="database.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Order> orderList = OrderDB.getAllOrders();
    Order editingOrder = new Order();
%>
<html>
    <%@ include file="../components/head.jsp" %>
    <body style="margin: 0">
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
                session.removeAttribute("successMessage");
        %>
        <div role="alert" class="alert alert-success w-auto px-4 absolute bottom-10 right-5">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <span class="text-semibold text-md"><%= successMessage%></span>
        </div>
        <%
            }
        %>
        <%
            String orderIDStr = request.getParameter("orderID");
            int statusNumber = 0;
            if (orderIDStr != null && !orderIDStr.isEmpty()) {
                int productID = Integer.parseInt(orderIDStr);
                editingOrder = OrderDB.getOrderById(productID);
                switch (editingOrder.getStatus()) {
                    case "Pending":
                        statusNumber = 0;
                        break;
                    case "Packaging":
                        statusNumber = 1;
                        break;
                    case "Shipping":
                        statusNumber = 2;
                        break;
                    case "Delivered":
                        statusNumber = 3;
                        break;
                }
            }
        %>
        <%@ include file="../components/sidebar.jsp"%>
        <dialog id="edit_status" class="modal">
            <div class="modal-box" style="width: 300px">
                <h3 class="text-lg font-bold flex justify-center">Updating Order Status</h3>
                <div class="flex justify-center py-4">
                    <% if (statusNumber < 3) { %>
                        <form method="post" action="${pageContext.request.contextPath}/StatusServlet">
                            <table class="table">
                                <%
                                    if (statusNumber < 1) {
                                %>
                                <tr>
                                    <td>
                                        <input type="radio" name="status" value="Packaging" class="radio radio-sm" <%= statusNumber == 0 ? "checked='checked'" : "" %> />
                                    </td>
                                    <td>
                                        <div class="flex gap-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-package-open"><path d="M12 22v-9"/><path d="M15.17 2.21a1.67 1.67 0 0 1 1.63 0L21 4.57a1.93 1.93 0 0 1 0 3.36L8.82 14.79a1.655 1.655 0 0 1-1.64 0L3 12.43a1.93 1.93 0 0 1 0-3.36z"/><path d="M20 13v3.87a2.06 2.06 0 0 1-1.11 1.83l-6 3.08a1.93 1.93 0 0 1-1.78 0l-6-3.08A2.06 2.06 0 0 1 4 16.87V13"/><path d="M21 12.43a1.93 1.93 0 0 0 0-3.36L8.83 2.2a1.64 1.64 0 0 0-1.63 0L3 4.57a1.93 1.93 0 0 0 0 3.36l12.18 6.86a1.636 1.636 0 0 0 1.63 0z"/></svg>
                                            <p class="text-md font-semibold">Packaging</p>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                    if (statusNumber < 2) {
                                %>
                                <tr>
                                    <td>
                                        <input type="radio" name="status" value="Shipping" class="radio radio-sm" <%= statusNumber == 1 ? "checked='checked'" : "" %> />
                                    </td>
                                    <td>
                                        <div class="flex gap-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-truck"><path d="M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2"/><path d="M15 18H9"/><path d="M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.624l-3.48-4.35A1 1 0 0 0 17.52 8H14"/><circle cx="17" cy="18" r="2"/><circle cx="7" cy="18" r="2"/></svg>
                                            <p class="text-md font-semibold">Shipping</p>
                                        </div>
                                    </td>
                                </tr>
                                <%
                                    }
                                    if (statusNumber < 3) {
                                %>
                                <tr>
                                    <td>
                                        <input type="radio" name="status" value="Delivered" class="radio radio-sm" <%= statusNumber == 2 ? "checked='checked'" : "" %> />
                                    </td>
                                    <td>
                                        <div class="flex gap-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-package-check"><path d="m16 16 2 2 4-4"/><path d="M21 10V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l2-1.14"/><path d="m7.5 4.27 9 5.15"/><polyline points="3.29 7 12 12 20.71 7"/><line x1="12" x2="12" y1="22" y2="12"/></svg>
                                            <p class="text-md font-semibold">Delivered</p>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            </table>

                            <input type="hidden" name="orderID" value="<%=editingOrder.getOrderID()%>"/>
                            <button type="submit" class="btn btn-neutral w-full mt-4">Update Status</button>
                        </form>
                    <% } else { %>
                        <div class="flex flex-col">
                            <div>
                                <p class="text-md font-semibold">There is nothing to update!</p>
                            </div>
                            <form method="dialog">
                                <button class="btn btn-neutral w-full mt-4">Close</button>
                            </form>
                        </div>
                    <% } %>
                </div>
            </div>
            <form method="dialog" class="modal-backdrop">
                <button>close</button>
            </form>
        </dialog>
        <div class="ml-70 font-inter">
            <div class="overflow-x-auto mt-4">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Email</th>
                        <th>Total Payment (RM)</th>
                        <th>Placed On</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Order order : orderList) {
                    %>
                    <tr>
                        <td>
                            <%=order.getOrderID()%>
                        </td>
                        <td>
                            <%=AccountDB.getAccountById(order.getUserID()).getEmail()%>
                        </td>
                        <td>
                            <%=order.getTotalAmount()%>
                        </td>
                        <td>
                            <%
                                Date placedOn = order.getOrderDate();
                                SimpleDateFormat newFormat = new SimpleDateFormat("EEEE, MMMM dd, yyyy hh:mm a");

                                String formattedDate = newFormat.format(placedOn);
                            %>
                            <%= formattedDate %>
                        </td>
                        <td>
                            <%
                                String status = order.getStatus();
                                String badge = "";
                                String badgeIcon = "";
                                switch (status) {
                                    case "Pending":
                                        badge = "badge-info";
                                        badgeIcon = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"lucide lucide-circle-dashed\"><path d=\"M10.1 2.182a10 10 0 0 1 3.8 0\"/><path d=\"M13.9 21.818a10 10 0 0 1-3.8 0\"/><path d=\"M17.609 3.721a10 10 0 0 1 2.69 2.7\"/><path d=\"M2.182 13.9a10 10 0 0 1 0-3.8\"/><path d=\"M20.279 17.609a10 10 0 0 1-2.7 2.69\"/><path d=\"M21.818 10.1a10 10 0 0 1 0 3.8\"/><path d=\"M3.721 6.391a10 10 0 0 1 2.7-2.69\"/><path d=\"M6.391 20.279a10 10 0 0 1-2.69-2.7\"/></svg>";
                                        break;
                                    case "Packaging":
                                        badge = "badge-warning";
                                        badgeIcon = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"lucide lucide-package-open\"><path d=\"M12 22v-9\"/><path d=\"M15.17 2.21a1.67 1.67 0 0 1 1.63 0L21 4.57a1.93 1.93 0 0 1 0 3.36L8.82 14.79a1.655 1.655 0 0 1-1.64 0L3 12.43a1.93 1.93 0 0 1 0-3.36z\"/><path d=\"M20 13v3.87a2.06 2.06 0 0 1-1.11 1.83l-6 3.08a1.93 1.93 0 0 1-1.78 0l-6-3.08A2.06 2.06 0 0 1 4 16.87V13\"/><path d=\"M21 12.43a1.93 1.93 0 0 0 0-3.36L8.83 2.2a1.64 1.64 0 0 0-1.63 0L3 4.57a1.93 1.93 0 0 0 0 3.36l12.18 6.86a1.636 1.636 0 0 0 1.63 0z\"/></svg>";
                                        break;
                                    case "Shipping":
                                        badge = "badge-warning";
                                        badgeIcon = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"lucide lucide-truck\"><path d=\"M14 18V6a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2v11a1 1 0 0 0 1 1h2\"/><path d=\"M15 18H9\"/><path d=\"M19 18h2a1 1 0 0 0 1-1v-3.65a1 1 0 0 0-.22-.624l-3.48-4.35A1 1 0 0 0 17.52 8H14\"/><circle cx=\"17\" cy=\"18\" r=\"2\"/><circle cx=\"7\" cy=\"18\" r=\"2\"/></svg>";
                                        break;
                                    case "Delivered":
                                        badge = "badge-success";
                                        badgeIcon = "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"lucide lucide-package-check\"><path d=\"m16 16 2 2 4-4\"/><path d=\"M21 10V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l2-1.14\"/><path d=\"m7.5 4.27 9 5.15\"/><polyline points=\"3.29 7 12 12 20.71 7\"/><line x1=\"12\" x2=\"12\" y1=\"22\" y2=\"12\"/></svg>";
                                        break;
                                }
                            %>
                            <div class="badge badge-soft <%=badge%>">
                                <%=badgeIcon%>
                                <%=status%>
                            </div>
                        </td>
                        <td>
                            <div class="flex gap-4">
                                <div>
                                    <a href="<%= request.getRequestURL().toString() %>?orderID=<%= order.getOrderID() %>" type="button">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-pencil"><path d="M21.174 6.812a1 1 0 0 0-3.986-3.987L3.842 16.174a2 2 0 0 0-.5.83l-1.321 4.352a.5.5 0 0 0 .623.622l4.353-1.32a2 2 0 0 0 .83-.497z"/><path d="m15 5 4 4"/></svg>
                                    </a>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                <% if (editingOrder != null && editingOrder.getOrderID() != 0) { %>
                    edit_status.showModal();
                <% } %>
            });
        </script>
    </body>
</html>
