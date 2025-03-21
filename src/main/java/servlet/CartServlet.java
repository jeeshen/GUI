package servlet;

import database.ProductDB;
import jakarta.servlet.annotation.WebServlet;
import main.Cart;
import main.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        if (request.getParameter("action").equals("add")) {
            int productId = Integer.parseInt(request.getParameter("productID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            Product product = ProductDB.getProductById(productId);
            cart.addProduct(product, quantity);

            response.sendRedirect("product.jsp");
        } else if (request.getParameter("action").equals("plus")) {
            int productId = Integer.parseInt(request.getParameter("productID"));

            Product product = ProductDB.getProductById(productId);
            cart.plusQuantity(product, 1);

            response.sendRedirect("cart.jsp");
        } else if (request.getParameter("action").equals("minus")) {
            int productId = Integer.parseInt(request.getParameter("productID"));

            Product product = ProductDB.getProductById(productId);
            cart.minusQuantity(product, 1);

            response.sendRedirect("cart.jsp");
        } else if (request.getParameter("action").equals("delete")) {
            int productId = Integer.parseInt(request.getParameter("productID"));

            Product product = ProductDB.getProductById(productId);
            cart.removeProduct(product);

            response.sendRedirect("cart.jsp");
        }
    }
}
