/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.DBConnection;

/**
 *
 * @author user
 */
@WebServlet(name = "CreateExamServlet", urlPatterns = {"/CreateExamServlet"})
public class CreateExamServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String title = request.getParameter("exam_title");
            String subject = request.getParameter("subject");
            int categoryId = Integer.parseInt(request.getParameter("category_id"));
            int totalMarks = Integer.parseInt(request.getParameter("total_marks"));
            int duration = Integer.parseInt(request.getParameter("duration"));

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO tblExams (exam_title, subject, category_id, total_marks, duration) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, title);
                ps.setString(2, subject);
                ps.setInt(3, categoryId);
                ps.setInt(4, totalMarks);
                ps.setInt(5, duration);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("manageExams.jsp"); // Redirect back after adding exam
    }
}
