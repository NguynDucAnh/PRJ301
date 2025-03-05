<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .header {
        background-color: #2c3e50;
        padding: 1rem 0;
        width: 100%;
        top: 0;
        position: sticky;
        z-index: 1000;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1.5rem;
    }

    .nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 2rem;
    }

    .logo {
        color: #fff;
        font-size: 1.4rem;
        font-weight: 600;
        text-decoration: none;
        transition: opacity 0.3s ease;
    }

    .logo:hover {
        opacity: 0.9;
    }

    .menu {
        display: flex;
        list-style: none;
        gap: 2rem;
        margin: 0 1rem;
    }

    .menu-item a {
        color: #ecf0f1;
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 500;
        transition: all 0.3s ease;
        padding: 0.5rem 0;
        position: relative;
    }

    .menu-item a:hover {
        color: #3498db;
    }

    .menu-item a::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 2px;
        background: #3498db;
        transition: width 0.3s ease;
    }

    .menu-item a:hover::after {
        width: 100%;
    }

    .right-section {
        display: flex;
        align-items: center;
        gap: 1.5rem;
        margin-left: auto;
    }

    .search-bar {
        display: flex;
        align-items: center;
        background: #fff;
        border-radius: 25px;
        padding: 0.4rem 1rem;
        transition: box-shadow 0.3s ease;
    }

    .search-bar:focus-within {
        box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.3);
    }

    .search-input {
        border: none;
        outline: none;
        padding: 0.2rem;
        width: 180px;
        font-size: 0.9rem;
        color: #2c3e50;
    }

    .search-input::placeholder {
        color: #95a5a6;
    }

    .search-button {
        background: none;
        border: none;
        cursor: pointer;
        color: #2c3e50;
        padding: 0.2rem;
        transition: transform 0.2s ease;
    }

    .search-button:hover {
        transform: scale(1.1);
    }

    .user-section {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .welcome-text {
        color: #fff;
        font-size: 0.9rem;
        white-space: nowrap;
    }

    .user-name {
        color: #3498db;
        font-weight: 600;
    }

    .logout-btn {
        background-color: #e74c3c;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
        cursor: pointer;
        transition: all 0.3s ease;
        white-space: nowrap;
    }

    .logout-btn:hover {
        background-color: #c0392b;
        transform: translateY(-1px);
    }

        @media (max-width: 1024px) {
            .container {
                padding: 0 1rem;
            }

            .menu {
                gap: 1.5rem;
            }

            .search-input {
                width: 140px;
            }

            .welcome-text {
                display: none;
            }
        }
</style>

<header class="header">
    <div class="container">
        <nav class="nav">
            <a href="MainController?action=viewProjects" class="logo">Startup Manager</a>
            <ul class="menu">
                <li class="menu-item"><a href="MainController?action=viewProjects">Dashboard</a></li>
                <c:if test="${sessionScope.user.role == 'Founder'}">
                    <li class="menu-item"><a href="createProject.jsp">New Project</a></li>
                </c:if>
                <li class="menu-item"><a href="#">About</a></li>
                <li class="menu-item"><a href="#">Contact</a></li>
            </ul>
            <div class="right-section">
                <form action="MainController" method="GET" class="search-bar">
                    <input type="hidden" name="action" value="search">
                    <input type="text" 
                           class="search-input" 
                           placeholder="Search projects..."
                           name="searchTerm"
                           value="${param.searchTerm}">
                    <button type="submit" class="search-button">🔍</button>
                </form>
                <% if (session.getAttribute("user") != null) {
                    UserDTO userHeader = (UserDTO) session.getAttribute("user");
                %>
                <div class="user-section">
                    <span class="welcome-text">
                        Welcome, <span class="user-name"><%= userHeader.getName() %></span>
                    </span>
                    <form action="MainController" method="post" style="margin: 0;">
                        <input type="hidden" name="action" value="logout"/>
                        <input type="submit" value="Logout" class="logout-btn"/>
                    </form>
                </div>
                <% } %>
            </div>
        </nav>
    </div>
</header>