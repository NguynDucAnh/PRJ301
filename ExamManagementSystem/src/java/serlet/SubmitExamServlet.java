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
@WebServlet(name = "SubmitExamServlet", urlPatterns = {"/SubmitExamServlet"})
public class SubmitExamServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int examId = Integer.parseInt(request.getParameter("exam_id"));
            int score = 0, totalQuestions = 0;

            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT question_id, correct_option FROM tblQuestions WHERE exam_id = ?");
            ps.setInt(1, examId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                totalQuestions++;
                int questionId = rs.getInt("question_id");
                String correctOption = rs.getString("correct_option");
                String userAnswer = request.getParameter("q_" + questionId);

                if (correctOption.equals(userAnswer)) {
                    score++;
                }
            }

            int finalScore = (score * 100) / totalQuestions;

            // Store result in the database
            PreparedStatement psInsert = con.prepareStatement("INSERT INTO tblResults (username, exam_id, score) VALUES (?, ?, ?)");
            psInsert.setString(1, username);
            psInsert.setInt(2, examId);
            psInsert.setInt(3, finalScore);
            psInsert.executeUpdate();

            con.close();
            response.sendRedirect("viewResults.jsp?exam_id=" + examId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
