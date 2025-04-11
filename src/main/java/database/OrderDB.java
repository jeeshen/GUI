package database;

import main.Order;
import main.OrderItem;
import main.Product;
import main.ProductSales;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDB {

    //Handle placing order
    public static boolean placeOrder(Order order) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        conn.setAutoCommit(false);
        try {
            String insertOrderSQL = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, order.getUserID());
            stmt.setDouble(2, order.getTotalAmount());
            stmt.setString(3, "Pending");
            stmt.executeUpdate();

            int orderID = 0;
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                orderID = rs.getInt(1);
            }

            String insertOrderItemSQL = "INSERT INTO order_items (order_id, product_id, quantity, subtotal) VALUES (?, ?, ?, ?)";
            PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSQL);
            for (OrderItem item : order.getOrderItems()) {
                itemStmt.setInt(1, orderID);
                itemStmt.setInt(2, item.getProduct().getId());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getSubtotal());
                itemStmt.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    //Get order list from database
    public static List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        Connection conn = DatabaseConnection.getConnection();
        try {
            String query = "SELECT * FROM orders";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderID = rs.getInt("order_id");
                int userID = rs.getInt("user_id");
                double totalAmount = rs.getDouble("total_amount");
                Date orderDate = rs.getDate("order_date");
                String status = rs.getString("status");

                Order order = new Order(orderID, userID, totalAmount,orderDate, status);
                order.setOrderItems(getOrderItems(orderID));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    //Get order list by user ID
    public static List<Order> getAllOrdersByCustomer(int userID) throws SQLException {
        List<Order> orders = new ArrayList<>();
        Connection conn = DatabaseConnection.getConnection();
        try {
            String query = "SELECT * FROM orders WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderID = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                Date orderDate = rs.getDate("order_date");
                String status = rs.getString("status");

                Order order = new Order(orderID, userID, totalAmount,orderDate, status);
                order.setOrderItems(getOrderItems(orderID));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    //Get order by order ID
    public static Order getOrderById(int orderID) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        try {
            String query = "SELECT * FROM orders WHERE order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("user_id");
                double totalAmount = rs.getDouble("total_amount");
                Date orderDate = rs.getDate("order_date");
                String status = rs.getString("status");

                Order order = new Order(orderID, userID, totalAmount,orderDate, status);
                order.setOrderItems(getOrderItems(orderID));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Get ordered items of a specific order using order ID
    public static List<OrderItem> getOrderItems(int orderID) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT * FROM order_items WHERE order_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, orderID);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int productID = rs.getInt("product_id");
            int quantity = rs.getInt("quantity");

            Product product = ProductDB.getProductById(productID);
            OrderItem item = new OrderItem(product, quantity);
            items.add(item);
        }
        return items;
    }

    //To change order status from manage page
    public static boolean updateOrderStatus(int orderID, String newStatus) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        try {
            String query = "UPDATE orders SET status = ? WHERE order_id = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, newStatus);
            stmt.setInt(2, orderID);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //To get the list of top sold products from database, with parameter to get how many products
    public static List<Product> getTopSoldProducts(int top) throws SQLException {
        List<Product> topProducts = new ArrayList<>();
        Connection conn = DatabaseConnection.getConnection();
        try {
            String query = "SELECT product_id, SUM(quantity) AS total_sold FROM order_items GROUP BY product_id ORDER BY total_sold DESC LIMIT ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, top);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("product_id");
                Product product = ProductDB.getProductById(productID);
                topProducts.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return topProducts;
    }

    //Get the sales list of each product
    public static List<ProductSales> calculateSalesByProduct() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        List<ProductSales> salesList = new ArrayList<>();

        try {
            String query = "SELECT product_id, SUM(quantity) AS total_quantity, SUM(subtotal) AS total_sales " +
                    "FROM order_items " +
                    "WHERE order_id IN (SELECT order_id FROM orders WHERE status = 'Delivered') " +
                    "GROUP BY product_id";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int productID = rs.getInt("product_id");
                int totalQuantity = rs.getInt("total_quantity");
                double totalSales = rs.getDouble("total_sales");

                Product product = ProductDB.getProductById(productID);
                salesList.add(new ProductSales(product, totalQuantity, totalSales));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesList;
    }

    //Calculate the total sales of all products
    public static double calculateTotalSales() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        double totalSales = 0.0;
        try {
            String query = "SELECT SUM(total_amount) AS total_sales FROM orders WHERE status = 'Delivered'";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalSales = rs.getDouble("total_sales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSales;
    }

    //To calculate monthly sales of all products
    public static double calculateMonthlySales() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        double monthlySales = 0.0;

        try {
            String query = "SELECT SUM(total_amount) AS total_sales FROM orders " +
                    "WHERE status = 'Delivered' AND MONTH(order_date) = MONTH(CURRENT_DATE) " +
                    "AND YEAR(order_date) = YEAR(CURRENT_DATE)";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                monthlySales += rs.getDouble("total_sales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return monthlySales;
    }

    //Tp calculate daily sales of all products
    public static double calculateDailySales() throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        double dailySales = 0.0;

        try {
            String query = "SELECT SUM(total_amount) AS total_sales FROM orders " +
                    "WHERE status = 'Delivered' AND DATE(order_date) = CURRENT_DATE";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                dailySales += rs.getDouble("total_sales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailySales;
    }

    //To get sales amount of specific product
    public static double getProductSalesAmount(int productID) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        double totalSales = 0.0;
        try {
            String query = "SELECT COUNT(subtotal) AS total_sales FROM order_items " +
                    "WHERE product_id = ? AND order_id IN (SELECT order_id FROM orders WHERE status = 'Delivered')";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, productID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalSales = rs.getDouble("total_sales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalSales;
    }

    //To get the number of order of a specific status
    public static int getStatusSummary(String status) throws SQLException {
        Connection conn = DatabaseConnection.getConnection();
        int count = 0;
        try {
            String query = "SELECT COUNT(order_id) as count FROM orders WHERE status = '" + status + "'";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
