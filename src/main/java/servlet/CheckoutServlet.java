package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import main.*;
import database.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        String email = (String) session.getAttribute("user");
        Account user = AccountDB.getAccountByEmail(email);

        //If cart is empty then return back to the page
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        //If user didnt login then bring user to login page
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        //Add products into cart
        Order order = new Order(user.getId());
        for (Map.Entry<Product, Integer> entry : cart.getItems().entrySet()) {
            Product product = entry.getKey();
            int quantity = entry.getValue();
            ProductDB.updateStock(product.getId(), product.getStockQuantity()-quantity);
            order.addItem(product, quantity);
        }

        //Place order and clear cart
        boolean orderPlaced = false;
        try {
            orderPlaced = OrderDB.placeOrder(order);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (orderPlaced) {
            session.removeAttribute("cart");
            response.sendRedirect("orderSuccess.jsp");
        } else {
            response.sendRedirect("orderFail.jsp");
        }
    }
}
