package dao;

import dto.Project;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class ProjectDAO {
    
    // Get all projects
    public static List<Project> getAllProjects() throws ClassNotFoundException {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM tblStartupProjects";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Project project = new Project();
                project.setProjectId(rs.getInt("project_id"));
                project.setProjectName(rs.getString("project_name"));
                project.setDescription(rs.getString("Description"));
                project.setStatus(rs.getString("Status"));
                project.setEstimatedLaunch(rs.getString("estimated_launch"));
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    // Add a new project
    public static boolean addProject(Project project) throws ClassNotFoundException {
        String sql = "INSERT INTO tblStartupProjects (project_name, Description, Status, estimated_launch) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, project.getProjectName());
            stmt.setString(2, project.getDescription());
            stmt.setString(3, project.getStatus());
            stmt.setString(4, project.getEstimatedLaunch());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update project status
    public static boolean updateProjectStatus(int projectId, String status) throws ClassNotFoundException {
        String sql = "UPDATE tblStartupProjects SET Status=? WHERE project_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, projectId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public static List<Project> searchProjects(String keyword) throws ClassNotFoundException {
    List<Project> projects = new ArrayList<>();
    String sql = "SELECT * FROM tblStartupProjects WHERE project_name LIKE ?";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, "%" + keyword + "%"); // Search for projects that contain the keyword
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Project project = new Project();
            project.setProjectId(rs.getInt("project_id"));
            project.setProjectName(rs.getString("project_name"));
            project.setDescription(rs.getString("Description"));
            project.setStatus(rs.getString("Status"));
            project.setEstimatedLaunch(rs.getString("estimated_launch"));
            projects.add(project);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return projects;
}
    public static List<Project> getProjectsByPage(int start, int total) throws ClassNotFoundException {
    List<Project> projects = new ArrayList<>();
    String sql = "SELECT * FROM tblStartupProjects ORDER BY project_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, start);
        stmt.setInt(2, total);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Project project = new Project();
            project.setProjectId(rs.getInt("project_id"));
            project.setProjectName(rs.getString("project_name"));
            project.setDescription(rs.getString("Description"));
            project.setStatus(rs.getString("Status"));
            project.setEstimatedLaunch(rs.getString("estimated_launch"));
            projects.add(project);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return projects;
}

// Get total number of projects (for pagination)
public static int getProjectCount() throws ClassNotFoundException {
    String sql = "SELECT COUNT(*) FROM tblStartupProjects";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}


}
