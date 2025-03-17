package dto;

public class Project {
    private int projectId;
    private String projectName;
    private String description;
    private String status;
    private String estimatedLaunch;

    public Project() {
    }

    public Project(int projectId, String projectName, String description, String status, String estimatedLaunch) {
        this.projectId = projectId;
        this.projectName = projectName;
        this.description = description;
        this.status = status;
        this.estimatedLaunch = estimatedLaunch;
    }
    

    // Getters and Setters
    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public String getProjectName() { return projectName; }
    public void setProjectName(String projectName) { this.projectName = projectName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getEstimatedLaunch() { return estimatedLaunch; }
    public void setEstimatedLaunch(String estimatedLaunch) { this.estimatedLaunch = estimatedLaunch; }
}
