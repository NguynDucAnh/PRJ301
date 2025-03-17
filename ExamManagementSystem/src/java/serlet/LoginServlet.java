/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serlet;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.DBConnection;

/**
 *
 * @author user
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("Login attempt for: " + username);

        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.authenticateUser(username, password);

        if (user != null) {
            System.out.println("Login successful for: " + username);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect based on role
            if (user.isInstructor()) {
                response.sendRedirect(request.getContextPath() + "/instructorDashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/viewExams.jsp");
            }
        } else {
            System.out.println("Login failed for: " + username);
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid username or password");
        }
    }
}
