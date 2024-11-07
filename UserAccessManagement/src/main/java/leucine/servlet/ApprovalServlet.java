package leucine.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestIdParam = request.getParameter("requestId");
        String action = request.getParameter("action");
       
        
        if (requestIdParam == null || requestIdParam.isEmpty()) {
            // Handle the case where the requestId is missing or invalid
            response.sendRedirect("pendingRequests.jsp?error=Request ID is missing.");
            return;
        }

        int requestId;
        
        try {
            requestId = Integer.parseInt(requestIdParam);
            
        } catch (NumberFormatException e) {
            // Handle the case where the requestId is not a valid integer
            response.sendRedirect("pendingRequests.jsp?error=Invalid Request ID.");
            return;
        }

       
        if (action == null || (!action.equals("approve") && !action.equals("reject"))) {
            // Handle the case where the action is missing or invalid
            response.sendRedirect("pendingRequests.jsp?error=Invalid action.");
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            String status = action.equals("approve") ? "Approved" : "Rejected";
            String sql = "UPDATE requests SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, requestId);
            stmt.executeUpdate();

            response.sendRedirect("pendingRequests.jsp?success=Request " + status);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("pendingRequests.jsp?error=Failed to update request status.");
        }
        
        System.out.println(requestIdParam);
        System.out.println(requestId);
        System.out.println(action);
    }
}
