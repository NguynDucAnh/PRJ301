package servlet;

import dao.ProjectDAO;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateProjectServlet")
public class UpdateProjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int projectId = Integer.parseInt(request.getParameter("projectId"));
        String status = request.getParameter("status");

        try {
            if (ProjectDAO.updateProjectStatus(projectId, status)) {
                response.sendRedirect("updateProjectStatus.jsp");
            } else {
                response.getWriter().println("Error updating project status.");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateProjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
