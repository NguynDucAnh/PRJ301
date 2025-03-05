package util;

import dto.UserDTO;
import javax.servlet.http.HttpSession;

public class AuthUtils {

    public static boolean isFounder(HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        return user != null && "Founder".equals(user.getRole());
    }

    public static boolean isTeamMember(HttpSession session) {
        UserDTO user = (UserDTO) session.getAttribute("user");
        return user != null && "Team Member".equals(user.getRole());
    }

    public static boolean isLoggedIn(HttpSession session) {
        return session.getAttribute("user") != null;
    }
}