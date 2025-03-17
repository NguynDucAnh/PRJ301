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
    
    // Constants for action names
    private static final String ACTION_LOGIN = "login";
    private static final String ACTION_LOGOUT = "logout";
    private static final String ACTION_VIEW_PROJECTS = "viewProjects";
    private static final String ACTION_CREATE_PROJECT = "createProject";
    private static final String ACTION_UPDATE_STATUS = "updateStatus";
    private static final String ACTION_SEARCH = "search";

    // Method to handle login
   private String processLogin(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String url = LOGIN_PAGE;  // Default URL (login page)
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Check for empty fields
    if (username == null || username.trim().isEmpty() || 
        password == null || password.trim().isEmpty()) {
        request.setAttribute("error", "Please fill in all required fields");
        return LOGIN_PAGE;
    }
    
    try {
        // Authenticate the user
        UserDTO user = userDAO.authenticate(username, password);
        
        // Check if user exists
        if (user != null) {
            // Set the user in the session
            request.getSession().setAttribute("user", user);
            
            // Redirect to the dashboard
            response.sendRedirect("dashboard.jsp");  // Redirect to the dashboard page
            return null;  // Ensure the rest of the method is not executed
        } else {
            request.setAttribute("error", "Invalid username or password");
        }
    } catch (Exception e) {
        log("Login error: " + e.toString());
        request.setAttribute("error", "Database error occurred");
    }
    
    return url;  // Stay on the login page if login fails
}



    // Method to handle logout
    private String processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().invalidate(); // Invalidate the session on logout
        response.sendRedirect(LOGIN_PAGE); // Redirect to login page
        return null; // No further processing after redirect
    }

    // Method to view projects (Dashboard)
    private String processViewProjects(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<ProjectDTO> projects = projectDAO.getAllProjects();
            request.setAttribute("projects", projects); // Set projects as a request attribute
        } catch (Exception e) {
            log("Project view error: " + e.toString());
            request.setAttribute("error", "Error loading projects");
        }
        return DASHBOARD; // Forward to the dashboard page
    }

    // Method to create a new project
    private String processCreateProject(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtils.isFounder(request.getSession())) {
            return ERROR_PAGE; // Unauthorized access for non-founders
        }

        try {
            String projectName = request.getParameter("projectName");
            String description = request.getParameter("description");
            String status = request.getParameter("status");
            Date estimatedLaunch = Date.valueOf(request.getParameter("estimatedLaunch")); // Ensure the date format is correct

            // Validate project fields
            if (projectName == null || projectName.trim().isEmpty() || description == null || description.trim().isEmpty()) {
                request.setAttribute("error", "Project name and description are required");
                return processViewProjects(request, response);
            }

            ProjectDTO project = new ProjectDTO(
                0, // ID will be auto-generated
                projectName,
                description,
                status,
                estimatedLaunch
            );

            if (projectDAO.createProject(project)) {
                request.setAttribute("success", "Project created successfully");
            } else {
                request.setAttribute("error", "Failed to create project");
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format. Please use yyyy-MM-dd.");
        } catch (Exception e) {
            log("Create project error: " + e.toString());
            request.setAttribute("error", "Error creating project");
        }
        return processViewProjects(request, response); // After creating project, show the list of projects again
    }

    // Method to update project status
    private String processUpdateStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!AuthUtils.isFounder(request.getSession())) {
            return ERROR_PAGE; // Unauthorized access for non-founders
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
        return processViewProjects(request, response); // After updating status, show the list of projects again
    }

    // Method to search for projects
    private String processSearchProjects(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String searchTerm = request.getParameter("searchTerm");
            List<ProjectDTO> projects = projectDAO.searchProjectsByName(searchTerm);
            request.setAttribute("projects", projects); // Set the search results as a request attribute
            request.setAttribute("searchTerm", searchTerm); // Set the search term for display
        } catch (Exception e) {
            log("Search error: " + e.toString());
            request.setAttribute("error", "Search failed");
        }
        return DASHBOARD; // Show the dashboard with search results
    }

    // Main request processing method
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    String url = LOGIN_PAGE;  // Default URL (login page)

    try {
        // Get the action parameter from the request
        String action = request.getParameter("action");
        
        if (action == null) {
            url = LOGIN_PAGE;  // Default to login page if no action is specified
        } else if (action.equals("login")) {
            url = processLogin(request, response);  // Handle login action
        } else if (action.equals("logout")) {
            url = processLogout(request, response);  // Handle logout action
        } else {
            url = LOGIN_PAGE;  // Default action if invalid
        }
    } catch (Exception e) {
        log("Controller error: " + e.toString());
        url = ERROR_PAGE;  // Redirect to error page in case of failure
    } finally {
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }
}


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Handle GET requests
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response); // Handle POST requests
    }

    @Override
    public String getServletInfo() {
        return "Startup Management Controller"; // Servlet description
    }
}
