<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Project</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #f4f4f4; 
            text-align: center; 
        }
        .container { 
            width: 350px; 
            margin: 50px auto; 
            padding: 20px; 
            background: white; 
            border-radius: 10px; 
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1); 
        }
        h2 { color: #333; }
        input, select, button { 
            width: 100%; 
            margin: 10px 0; 
            padding: 10px; 
            border-radius: 5px; 
            border: 1px solid #ccc; 
        }
        button { 
            background: #007BFF; 
            color: white; 
            border: none; 
            cursor: pointer; 
            font-size: 16px;
        }
        button:hover { background: #0056b3; }
        .back {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back:hover { background: #218838; }
    </style>
</head>
<body>
    <div class="container">
        <h2>➕ Add New Project</h2>
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
            <button type="submit">✔ Add Project</button>
        </form>
        <a href="dashboard.jsp" class="back">🔙 Back to Dashboard</a>
    </div>
</body>
</html>
