package dao;

import dto.ProjectDTO;
import util.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    public List<ProjectDTO> getAllProjects() throws SQLException {
        List<ProjectDTO> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement("SELECT * FROM tblStartupProjects");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                projects.add(new ProjectDTO(
                    rs.getInt("project_id"),
                    rs.getString("project_name"),
                    rs.getString("Description"),
                    rs.getString("Status"),
                    rs.getDate("estimated_launch")
                ));
            }
        } finally {
            DBUtils.closeQuietly(rs);
            DBUtils.closeQuietly(ps);
            DBUtils.closeQuietly(conn);
        }
        return projects;
    }

    public boolean createProject(ProjectDTO project) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;
        
        try {
            conn = DBUtils.getConnection();
            int newId = getMaxProjectId(conn) + 1;
            
            ps = conn.prepareStatement(
                "INSERT INTO tblStartupProjects (project_id, project_name, Description, Status, estimated_launch) " +
                "VALUES (?, ?, ?, ?, ?)");
            
            ps.setInt(1, newId);
            ps.setString(2, project.getProjectName());
            ps.setString(3, project.getDescription());
            ps.setString(4, project.getStatus());
            ps.setDate(5, project.getEstimatedLaunch());
            
            success = ps.executeUpdate() > 0;
        } finally {
            DBUtils.closeQuietly(ps);
            DBUtils.closeQuietly(conn);
        }
        return success;
    }

    private int getMaxProjectId(Connection conn) throws SQLException {
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement("SELECT MAX(project_id) FROM tblStartupProjects");
            rs = ps.executeQuery();
            return rs.next() ? rs.getInt(1) : 0;
        } finally {
            DBUtils.closeQuietly(rs);
            DBUtils.closeQuietly(ps);
        }
    }

    public boolean updateProjectStatus(int projectId, String newStatus) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        boolean success = false;
        
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(
                "UPDATE tblStartupProjects SET Status = ? WHERE project_id = ?");
            
            ps.setString(1, newStatus);
            ps.setInt(2, projectId);
            
            success = ps.executeUpdate() > 0;
        } finally {
            DBUtils.closeQuietly(ps);
            DBUtils.closeQuietly(conn);
        }
        return success;
    }

    public List<ProjectDTO> searchProjectsByName(String searchTerm) throws SQLException {
        List<ProjectDTO> projects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(
                "SELECT * FROM tblStartupProjects WHERE project_name LIKE ?");
            
            ps.setString(1, "%" + searchTerm + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                projects.add(new ProjectDTO(
                    rs.getInt("project_id"),
                    rs.getString("project_name"),
                    rs.getString("Description"),
                    rs.getString("Status"),
                    rs.getDate("estimated_launch")
                ));
            }
        } finally {
            DBUtils.closeQuietly(rs);
            DBUtils.closeQuietly(ps);
            DBUtils.closeQuietly(conn);
        }
        return projects;
    }
}