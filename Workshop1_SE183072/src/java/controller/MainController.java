package controller;

import dao.ProjectDAO;
import dao.UserDAO;
import dto.ProjectDTO;
import dto.UserDTO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.AuthUtils;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private ProjectDAO projectDAO = new ProjectDAO();
    private UserDAO userDAO = new UserDAO();

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String DASHBOARD = "dashboard.jsp";
    private static final String ERROR_PAGE = "error.jsp";

   private String processLogin(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String url = LOGIN_PAGE;
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Check for empty fields
    if(username == null || username.trim().isEmpty() || 
       password == null || password.trim().isEmpty()) {
        request.setAttribute("error", "Please fill in all required fields");
        return LOGIN_PAGE;
    }
    
    try {
        UserDTO user = userDAO.authenticate(username, password);
        if (user != null) {
            request.getSession().setAttribute("user", user);
            url = DASHBOARD;
            processViewProjects(request, response);
        } else {
            request.setAttribute("error", "Invalid username or password");
        }
    } catch (Exception e) {
        log("Login error: " + e.toString());
        request.setAttribute("error", "Database error occurred");
    }
    return url;
}

    private String processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().invalidate();
        return LOGIN_PAGE;
    }

    private String processViewProjects(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ProjectDTO> projects = projectDAO.getAllProjects();
            request.setAttribute("projects", projects);
        } catch (Exception e) {
            log("Project view error: " + e.toString());
            request.setAttribute("error", "Error loading projects");
        }
        return DASHBOARD;
    }

    private String processCreateProject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtils.isFounder(request.getSession())) {
            return ERROR_PAGE;
        }
        
        try {
            ProjectDTO project = new ProjectDTO(
                0, // ID will be auto-generated
                request.getParameter("projectName"),
                request.getParameter("description"),
                request.getParameter("status"),
                Date.valueOf(request.getParameter("estimatedLaunch"))
            );
            
            if (projectDAO.createProject(project)) {
                request.setAttribute("success", "Project created successfully");
            } else {
                request.setAttribute("error", "Failed to create project");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format");
        } catch (Exception e) {
            log("Create project error: " + e.toString());
            request.setAttribute("error", "Error creating project");
        }
        return processViewProjects(request, response);
    }

    private String processUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtils.isFounder(request.getSession())) {
            return ERROR_PAGE;
        }
        
        try {
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            String newStatus = request.getParameter("newStatus");
            
            if (projectDAO.updateProjectStatus(projectId, newStatus)) {
                request.setAttribute("success", "Status updated successfully");
            } else {
                request.setAttribute("error", "Failed to update status");
            }
        } catch (Exception e) {
            log("Status update error: " + e.toString());
            request.setAttribute("error", "Error updating status");
        }
        return processViewProjects(request, response);
    }

    private String processSearchProjects(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("searchTerm");
            List<ProjectDTO> projects = projectDAO.searchProjectsByName(searchTerm);
            request.setAttribute("projects", projects);
            request.setAttribute("searchTerm", searchTerm);
        } catch (Exception e) {
            log("Search error: " + e.toString());
            request.setAttribute("error", "Search failed");
        }
        return DASHBOARD;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        
        try {
            String action = request.getParameter("action");
            
            if (action == null) {
                url = LOGIN_PAGE;
            } else switch (action) {
                case "login":
                    url = processLogin(request, response);
                    break;
                case "logout":
                    url = processLogout(request, response);
                    break;
                case "viewProjects":
                    url = processViewProjects(request, response);
                    break;
                case "createProject":
                    url = processCreateProject(request, response);
                    break;
                case "updateStatus":
                    url = processUpdateStatus(request, response);
                    break;
                case "search":
                    url = processSearchProjects(request, response);
                    break;
                default:
                    url = LOGIN_PAGE;
                    break;
            }
        } catch (Exception e) {
            log("Controller error: " + e.toString());
            url = ERROR_PAGE;
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Startup Management Controller";
    }
}