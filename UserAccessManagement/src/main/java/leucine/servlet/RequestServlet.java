
package leucine.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/RequestServlet")
public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp?error=Please log in to submit a request.");
            return; // Exit if userId is not present in session
        }

        String softwareName = request.getParameter("softwareName");
        int softwareId = -1;

        try {
            softwareId = Integer.parseInt(softwareName);
        } catch (NumberFormatException e) {
            response.sendRedirect("requestAccess.jsp?error=Invalid software ID.");
            return;
        }

        String accessType = request.getParameter("accessType");
        String reason = request.getParameter("reason");
        String status = "Pending";

        try (Connection conn = DatabaseConnection.getConnection()) {
            String checkSoftwareSql = "SELECT id FROM software WHERE id = ?";
            PreparedStatement checkSoftwareStmt = conn.prepareStatement(checkSoftwareSql);
            checkSoftwareStmt.setInt(1, softwareId);
            ResultSet softwareRs = checkSoftwareStmt.executeQuery();
            
            if (!softwareRs.next()) {
                response.sendRedirect("requestAccess.jsp?error=Software ID does not exist.");
                return;
            }

            String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, softwareId);
            stmt.setString(3, accessType);
            stmt.setString(4, reason);
            stmt.setString(5, status);
            stmt.executeUpdate();
            
            response.sendRedirect("requestAccess.jsp?success=Request submitted.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("requestAccess.jsp?error=Request submission failed.");
        }

    }
}
