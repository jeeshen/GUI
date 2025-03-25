package database;

import main.Order;
import main.OrderItem;
import main.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderDB {
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
}
