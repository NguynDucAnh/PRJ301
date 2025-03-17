package dto;

import java.io.Serializable;

public class UserDTO implements Serializable {
    private String username;
    private String name;
    private String role;

    // Constructor
    public UserDTO(String username, String name, String role) {
        this.username = username;
        this.name = name;
        this.role = role;
    }

    // Getters and Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    // Role check helper
    public boolean isInstructor() {
        return "Instructor".equalsIgnoreCase(role);
    }
}
