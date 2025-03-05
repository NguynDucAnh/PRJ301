package dao;

import dto.UserDTO;
import util.DBUtils;
import java.sql.*;

public class UserDAO {

    public UserDTO authenticate(String username, String password) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(
                "SELECT Name, Role FROM tblUsers WHERE Username = ? AND Password = ?");
            
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new UserDTO(
                    username,
                    rs.getString("Name"),
                    rs.getString("Role")
                );
            }
            return null;
        } finally {
            DBUtils.closeQuietly(rs);
            DBUtils.closeQuietly(ps);
            DBUtils.closeQuietly(conn);
        }
    }
}