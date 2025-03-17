<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        .container { width: 300px; margin: auto; padding: 20px; border: 1px solid #ccc; }
        input, select, button { width: 100%; margin: 5px 0; padding: 10px; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Add New Project</h2>
        <form action="AddProjectServlet" method="post">
            <input type="text" name="projectName" placeholder="Project Name" required><br>
            <input type="text" name="description" placeholder="Description" required><br>
            <select name="status">
                <option value="Ideation">Ideation</option>
                <option value="Development">Development</option>
                <option value="Launch">Launch</option>
                <option value="Scaling">Scaling</option>
            </select><br>
            <input type="date" name="estimatedLaunch" required><br>
            <button type="submit">Add Project</button>
        </form>
    </div>
</body>
</html>
