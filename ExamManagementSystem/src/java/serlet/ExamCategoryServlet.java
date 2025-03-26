/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serlet;

import util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ExamCategoryServlet")
public class ExamCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            if ("add".equals(action)) {
                String categoryName = request.getParameter("category_name");
                String description = request.getParameter("description");

                String sql = "INSERT INTO tblExamCategories (category_name, description) VALUES (?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, categoryName);
                ps.setString(2, description);
                ps.executeUpdate();
            } else if ("delete".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                String sql = "DELETE FROM tblExamCategories WHERE category_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, categoryId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("manageCategories.jsp");
    }
}
