package servlet;

import dao.ProjectDAO;
import dto.Project;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddProjectServlet")
public class AddProjectServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Project project = new Project();
        project.setProjectName(request.getParameter("projectName"));
        project.setDescription(request.getParameter("description"));
        project.setStatus(request.getParameter("status"));
        project.setEstimatedLaunch(request.getParameter("estimatedLaunch"));

        try {
            if (ProjectDAO.addProject(project)) {
                response.sendRedirect("viewProjects.jsp");
            } else {
                response.getWriter().println("Error adding project.");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddProjectServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
