package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import main.Account;
import database.OrderDB;

@WebServlet("/StatusServlet")
public class StatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = request.getParameter("status");
        int orderID = Integer.parseInt(request.getParameter("orderID"));

        try {
            boolean success = OrderDB.updateOrderStatus(orderID,status);
            if (success) {
                request.getSession().setAttribute("successMessage", "Status successfully updated!");
                response.sendRedirect("/admin/order.jsp");
            } else {
                request.getSession().setAttribute("errorMessage", "Failed to update status!");
                response.sendRedirect("/admin/order.jsp");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
