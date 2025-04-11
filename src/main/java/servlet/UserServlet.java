package servlet;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import main.Account;
import database.AccountDB;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //Check which action should run
        if (request.getParameter("action").equals("add")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Account account = new Account(email, name, password, "USER", "ACTIVE");
            boolean success = AccountDB.registerUser(account);

            //If error then show error then return back
            if (!success) {
                request.getSession().setAttribute("errorMessage", "Email already exists!");
                response.sendRedirect("/admin/user.jsp");
            }
            else {
                request.getSession().setAttribute("successMessage", "User added successfully!");
                response.sendRedirect("/admin/user.jsp");
            }
        } else if (request.getParameter("action").equals("delete")) {
            String email = request.getParameter("email");
            AccountDB.deleteUser(email);
            request.getSession().setAttribute("successMessage", "User deleted successfully!");

            response.sendRedirect("/admin/user.jsp");
        } else if (request.getParameter("action").equals("update")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            //Make sure no duplicated email
            Account account = AccountDB.getAccountByEmail(email);
            if (account != null) {
                request.getSession().setAttribute("errorMessage", "Email already exists!");
                response.sendRedirect("/admin/user.jsp");
            }
            else {
                //If no duplicate email found, then update account info
                account = AccountDB.getAccountById(id);
                account.setUsername(name);
                account.setEmail(email);
                account.setPassword(password);
                AccountDB.updateUser(account);
                request.getSession().setAttribute("successMessage", "User updated successfully!");
                response.sendRedirect("/admin/user.jsp");
            }
        } else if (request.getParameter("action").equals("addStaff")) {
            //Allow manager to add staff from manage page
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Account account = new Account(email, name, password, "STAFF", "ACTIVE");
            boolean success = AccountDB.registerUser(account);

            if (!success) {
                request.getSession().setAttribute("errorMessage", "Email already exists!");
                response.sendRedirect("/admin/staff.jsp");
            }
            else {
                request.getSession().setAttribute("successMessage", "Staff added successfully!");
                response.sendRedirect("/admin/staff.jsp");
            }
        } else if (request.getParameter("action").equals("updateStaff")) {
            //Allow manager to update staff info from manage page
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Account account = AccountDB.getAccountByEmail(email);
            if (account != null) {
                request.getSession().setAttribute("errorMessage", "Email already exists!");
                response.sendRedirect("/admin/staff.jsp");
            }
            else {
                account = AccountDB.getAccountById(id);
                account.setUsername(name);
                account.setEmail(email);
                account.setPassword(password);
                AccountDB.updateUser(account);
                request.getSession().setAttribute("successMessage", "Staff updated successfully!");
                response.sendRedirect("/admin/staff.jsp");
            }
        } else if (request.getParameter("action").equals("delete")) {
            //Allow manager to delete staff from manage page
            String email = request.getParameter("email");
            AccountDB.deleteUser(email);
            request.getSession().setAttribute("successMessage", "Staff deleted successfully!");

            response.sendRedirect("/admin/staff.jsp");
        }
    }
}
