<%@ page import="java.util.List" %>
<%@ page import="main.Order" %>
<%@ page import="database.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="main.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <%--Show order info of that specific user--%>
  <%@ include file="components/header.jsp" %>
  <%
      List<Order> orderList = null;
      try {
          orderList = OrderDB.getAllOrdersByCustomer(AccountDB.getAccountByEmail(sessionName).getId());
      } catch (SQLException e) {
          throw new RuntimeException(e);
      }
  %>
  <body class="bg-base-100 pb-170">
    <div class="ml-30 font-inter">
      <div class="flex justify-left mb-10">
        <p class="w-[70%] flex justify-left text-black-500 text-5xl font-bold">Your orders.<span class="text-gray-500">&nbsp;Track your goods here.</span></p>
      </div>
      <div class="overflow-x-auto mt-4">
        <table class="table">
          <thead>
          <tr>
            <th>Order ID</th>
            <th>Order Items</th>
            <th>Total Payment (RM)</th>
            <th>Placed On</th>
            <th>Status</th>
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
            <td class="w-200">
              <%
                  List<OrderItem> orderItemList = OrderDB.getOrderItems(order.getOrderID());
                  if (orderItemList != null) {
                    for (OrderItem orderItem : orderItemList) {
              %>
                <div class="badge badge-soft badge-secondary m-2"><%= orderItem.getProduct().getName() %> X <%=orderItem.getQuantity()%></div>
              <%
                    }
                }
              %>
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
          </tr>
          <%
            }

            if (orderList.isEmpty()) {
          %>
          <tr>
            <td colspan="5">
              No orders found!
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
    </div>
  </body>
</html>
