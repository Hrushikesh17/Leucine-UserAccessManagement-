<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Pending Requests</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-top: 20px;
        }

        table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
            border: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        button {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            color: white;
            transition: background-color 0.3s;
        }

        button[name="action"][value="approve"] {
            background-color: #28a745;
        }

        button[name="action"][value="approve"]:hover {
            background-color: #218838;
        }

        button[name="action"][value="reject"] {
            background-color: #dc3545;
        }

        button[name="action"][value="reject"]:hover {
            background-color: #c82333;
        }

        form {
            display: inline;
        }
    </style>
</head>
<body>
    <h2>Pending Access Requests</h2>
    <table>
        <tr>
            <th>Employee Name</th>
            <th>Software Name</th>
            <th>Access Type</th>
            <th>Reason</th>
            <th>Action</th>
        </tr>
        <!-- Loop through pending requests and populate rows dynamically -->
        <c:forEach var="request" items="${requestsList}">
            <tr>
                <td>${request.employee_name}</td>
                <td>${request.software_name}</td>
                <td>${request.access_type}</td>
                <td>${request.reason}</td>
                <td>
                    <form action="ApprovalServlet" method="post">
                        <input type="hidden" name="requestId" value="${request.request_id}">
                        <button type="submit" name="action" value="approve">Approve</button>
                    </form>
                    <form action="ApprovalServlet" method="post">
                        <input type="hidden" name="requestId" value="${request.request_id}">
                        <button type="submit" name="action" value="reject">Reject</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
