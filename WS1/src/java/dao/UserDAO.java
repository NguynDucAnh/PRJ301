package dao;

import dto.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBConnection;

public class UserDAO {
    public static User validateUser(String username, String password) throws ClassNotFoundException {
        User user = null;
        String sql = "SELECT * FROM tblUsers WHERE Username=? AND Password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("Username"));
                user.setName(rs.getString("Name"));
                user.setRole(rs.getString("Role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
