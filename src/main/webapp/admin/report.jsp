<%@ page import="java.util.List" %>
<%@ page import="main.*" %>
<%@ page import="database.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DecimalFormat formatter = new DecimalFormat("#,##0.00");
    List<ProductSales> salesList = new ArrayList<>();
    try {
        salesList = OrderDB.calculateSalesByProduct();
    } catch (SQLException e) {
        throw new RuntimeException(e);
    }
    Order editingOrder = new Order();
%>
<html>
    <%--    View sales and quantity sold of each products here--%>
    <%@ include file="../components/head.jsp" %>
    <body style="margin: 0">
        <%@ include file="../components/sidebar.jsp"%>
        <div class="ml-70 font-inter">
            <div class="overflow-x-auto mt-4">
                <table class="table">
                    <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Total Quantity Sold</th>
                        <th>Total Sales (RM)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (ProductSales sale : salesList) {
                    %>
                    <tr>
                        <td>
                            <%=sale.getProduct().getId()%>
                        </td>
                        <td>
                            <div class="flex items-center gap-3">
                                <div class="avatar">
                                    <div class="mask mask-squircle h-12 w-12">
                                        <img
                                                src="<%= !sale.getProduct().getImageUrl().isEmpty() ? request.getContextPath() + "/" + sale.getProduct().getImageUrl() : "../images/empty product.png" %>"
                                                alt="Product Image" />
                                    </div>
                                </div>
                                <div>
                                    <div class="font-bold"><%=sale.getProduct().getName()%></div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <%=sale.getTotalQuantity()%>
                        </td>
                        <td>
                            <%=formatter.format(sale.getTotalSales())%>
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
