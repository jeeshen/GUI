<%@ page import="java.util.List" %>
<%@ page import="main.*" %>
<%@ page import="database.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <%--    Dashboard of manage page, to get sales and top sold products and display them in charts--%>
    <%@ include file="../components/head.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <%
        DecimalFormat formatter = new DecimalFormat("#,##0.00");
        double dailySales = OrderDB.calculateDailySales();
        double monthlySales = OrderDB.calculateMonthlySales();
        double totalSales = OrderDB.calculateTotalSales();

        List<Product> top10ProductList = new ArrayList<>();
        try {
            top10ProductList = OrderDB.getTopSoldProducts(10, false);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        List<ProductSales> salesList = OrderDB.calculateSalesByProduct();
    %>
    <body>
        <%@ include file="../components/sidebar.jsp"%>
        <div class="ml-70 font-inter">
            <div class="overflow-x-auto mt-4 flex justify-center">
                <div>
                    <div class="stats shadow-lg my-5">
                        <div class="stat place-items-center">
                            <div class="stat-title">Daily Sales</div>
                            <div class="stat-value"><%=formatter.format(dailySales)%></div>
                            <div class="stat-desc">Total earning from this day</div>
                        </div>
                        <div class="stat place-items-center">
                            <div class="stat-title">Monthly Sales</div>
                            <div class="stat-value text-secondary"><%=formatter.format(monthlySales)%></div>
                            <div class="stat-desc text-secondary">Total earning from this month</div>
                        </div>
                        <div class="stat place-items-center">
                            <div class="stat-title">Total Sales</div>
                            <div class="stat-value"><%=formatter.format(totalSales)%></div>
                            <div class="stat-desc">Total earning from all time</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="flex justify-center gap-8 my-8">
                <div class="w-1/5 h-auto p-8 shadow-lg flex justify-center items-center rounded-lg">
                    <canvas id="salesPieChart"></canvas>
                </div>
                <div class="w-1/5 h-auto p-8 shadow-lg flex justify-center items-center rounded-lg">
                    <canvas id="statusPieChart"></canvas>
                </div>
            </div>
            <div class="flex justify-evenly my-8">
                <div class="w-1/2">
                    <canvas id="salesBarChart"></canvas>
                </div>
            </div>
        </div>
        <script>
            const ctx = document.getElementById('salesBarChart');

            let delayed;
            const colors = [
                '#FAD2E1', '#FFDAC1', '#FCF6BD', '#D0F4DE', '#A9DEF9',
                '#E4C1F9', '#FFB3E6', '#B5EAD7', '#FFC3A0', '#D4A5A5'
            ];

            const datasets = [
                <% int colorIndex = 0; %>
                <% for (Product product : top10ProductList) { %>
                {
                    label: '<%= product.getName() %>',
                    data: [<%= OrderDB.getProductSalesAmount(product.getId()) %>],
                    backgroundColor: colors[<%= colorIndex % 10 %>],
                    borderColor: colors[<%= colorIndex % 10 %>],
                    borderWidth: 1
                },
                <% colorIndex++; %>
                <% } %>
            ];

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Products'],
                    datasets: datasets
                },
                options: {
                    animation: {
                        onComplete: () => {
                            delayed = true;
                        },
                        delay: (context) => {
                            let delay = 0;
                            if (context.type === 'data' && context.mode === 'default' && !delayed) {
                                delay = context.dataIndex * 300 + context.datasetIndex * 100;
                            }
                            return delay;
                        },
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    },
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        title: {
                            display: true,
                            text: 'Top 10 Sold Products'
                        }
                    }
                }
            });

            const ctx3 = document.getElementById('statusPieChart');

            const statusData = {
                labels: [
                    "Pending",
                    "Packaging",
                    "Shipping",
                    "Delivered"
                ],
                datasets: [{
                    data: [
                        <%= OrderDB.getStatusSummary("Pending") %>,
                        <%= OrderDB.getStatusSummary("Packaging") %>,
                        <%= OrderDB.getStatusSummary("Shipping") %>,
                        <%= OrderDB.getStatusSummary("Delivered") %>,
                    ],
                    backgroundColor: colors,
                    borderWidth: 1
                }]
            };

            new Chart(ctx3, {
                type: 'pie',
                data: statusData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Product Sales (RM)'
                        }
                    }
                }
            });

            const ctx2 = document.getElementById('salesPieChart');

            const salesData = {
                labels: [
                    <% for (ProductSales ps : salesList) { %>
                    '<%= ps.getProduct().getName() %>',
                    <% } %>
                ],
                datasets: [{
                    data: [
                        <% for (ProductSales ps : salesList) { %>
                        <%= ps.getTotalSales() %>,
                        <% } %>
                    ],
                    backgroundColor: colors,
                    borderWidth: 1
                }]
            };

            new Chart(ctx2, {
                type: 'pie',
                data: salesData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        title: {
                            display: true,
                            text: 'Product Sales (RM)'
                        }
                    }
                }
            });
        </script>
    </body>
</html>
