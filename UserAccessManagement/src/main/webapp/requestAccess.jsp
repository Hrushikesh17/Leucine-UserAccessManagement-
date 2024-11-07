<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Request Access</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            color: #333;
             display: flex;
            justify-content: center;
            align-items: center;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
        }

        select, textarea, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            background-color: #3498db;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #2980b9;
        }

        textarea {
            resize: vertical;
        }

        .form-group {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    
    <form action="RequestServlet" method="post">
    <h2>Request Access</h2>
        <div class="form-group">
            <label for="softwareName">Software Name:</label>
            <select id="softwareName" name="softwareName" required>
                <option value="">Select Software</option>
                <!-- Populate software options dynamically from database -->
                <c:forEach var="software" items="${softwareList}">
                    <option value="${software.id}">${software.name}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="accessType">Access Type:</label>
            <select id="accessType" name="accessType" required>
                <option value="Read">Read</option>
                <option value="Write">Write</option>
                <option value="Admin">Admin</option>
            </select>
        </div>

        <div class="form-group">
            <label for="reason">Reason for Request:</label>
            <textarea id="reason" name="reason" rows="4" required></textarea>
        </div>

        <button type="submit">Submit Request</button>
    </form>
</body>
</html>
