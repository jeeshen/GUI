package main;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
    private int orderID;
    final private int userID;
    private List<OrderItem> orderItems;
    private double totalAmount;
    final private Date orderDate;
    private String status;

    public Order(int userID) {
        this.userID = userID;
        this.orderItems = new ArrayList<>();
        this.totalAmount = 0.0;
        this.orderDate = new Date();
        this.status = "Pending";
    }

    public int getOrderID() {
        return orderID;
    }

    public int getUserID() {
        return userID;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void addItem(Product product, int quantity) {
        for (OrderItem item : orderItems) {
            if (item.getProduct().getId() == product.getId()) {
                item.setQuantity(item.getQuantity() + quantity);
                updateTotalAmount();
                return;
            }
        }
        orderItems.add(new OrderItem(product, quantity));
        updateTotalAmount();
    }

    public void removeItem(int productId) {
        orderItems.removeIf(item -> item.getProduct().getId() == productId);
        updateTotalAmount();
    }

    public void updateTotalAmount() {
        totalAmount = 0.0;
        for (OrderItem item : orderItems) {
            totalAmount += item.getSubtotal();
        }
        totalAmount += totalAmount * 0.06;
        totalAmount += 7;
    }
}
