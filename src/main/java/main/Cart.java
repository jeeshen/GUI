package main;

import java.util.HashMap;
import java.util.Map;

public class Cart {
    private Map<Product, Integer> items;

    //Constructors
    public Cart() {
        this.items = new HashMap<>();
    }

    //To add product into cart
    public void addProduct(Product product, int quantity) {
        if (product != null && quantity > 0) {
            items.put(product, items.getOrDefault(product, 0) + quantity);
        }
    }

    //To remove product from cart
    public void removeProduct(Product product) {
        if (product != null && items.containsKey(product)) {
            items.remove(product);
        }
    }

    //Add 1 quantity of a specific product
    public void plusQuantity(Product product, int quantity) {
        if (product != null && quantity > 0) {
            items.put(product, items.getOrDefault(product, 0) + quantity);
        }
    }

    //Minus 1 quantity of a specific product
    public void minusQuantity(Product product, int quantity) {
        if (product != null && items.containsKey(product)) {
            int newQuantity = items.get(product) - quantity;

            if (newQuantity > 0) {
                items.put(product, newQuantity);
            } else {
                items.remove(product);
            }
        }
    }

    //Calculate total of the cart
    public double calculateTotal() {
        double total = 0;
        for (Map.Entry<Product, Integer> entry : items.entrySet()) {
            total += entry.getKey().getPrice() * entry.getValue();
        }
        return total;
    }

    //Get number of products in cart
    public int getTotalQuantity() {
        int totalQuantity = 0;
        for (int quantity : items.values()) {
            totalQuantity += quantity;
        }
        return totalQuantity;
    }

    //Get the list of products and its quantity in cart
    public Map<Product, Integer> getItems() {
        return items;
    }
}
