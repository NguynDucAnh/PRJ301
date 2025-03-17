package dao;

import dto.UserDTO;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    public UserDTO authenticateUser(String username, String password) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        UserDTO user = null;

        try {
            con = DBConnection.getConnection();
            String sql = "SELECT * FROM tblUsers WHERE username=? AND password=?";
            con = new DBConnection().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);  // ⚠️ Use hashing if storing encrypted passwords.
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new UserDTO(username, rs.getString("name"), rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return user;
    }
}
