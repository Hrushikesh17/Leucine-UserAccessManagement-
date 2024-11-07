package leucine.servlet;

import java.util.HashMap;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                int userId = rs.getInt("id");

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("userRole", role);
                session.setAttribute("username", username);

                if ("Employee".equals(role)) {
                    // Fetch software list for Employee role
                    String softwareSql = "SELECT id, name FROM software";
                    PreparedStatement softwareStmt = conn.prepareStatement(softwareSql);
                    ResultSet softwareRs = softwareStmt.executeQuery();

                    List<Map<String, Object>> softwareList = new ArrayList<>();
                    while (softwareRs.next()) {
                        Map<String, Object> software = new HashMap<>();
                        software.put("id", softwareRs.getInt("id"));
                        software.put("name", softwareRs.getString("name"));
                        softwareList.add(software);
                    }

                    // Set software list in request scope and forward to requestAccess.jsp
                    request.setAttribute("softwareList", softwareList);
                    request.getRequestDispatcher("requestAccess.jsp").forward(request, response);

                } else if ("Manager".equals(role)) {
                    // Fetch pending requests for Manager role, including the request ID
                    String requestsSql = "SELECT r.id AS request_id, u.username AS employee_name, s.name AS software_name, "
                            + "r.access_type, r.reason FROM requests r "
                            + "JOIN users u ON r.user_id = u.id "
                            + "JOIN software s ON r.software_id = s.id "
                            + "WHERE r.status = 'Pending'"; // Fetch only pending requests
                    PreparedStatement requestsStmt = conn.prepareStatement(requestsSql);
                    ResultSet requestsRs = requestsStmt.executeQuery();

                    List<Map<String, Object>> requestsList = new ArrayList<>();
                    while (requestsRs.next()) {
                        Map<String, Object> requestData = new HashMap<>();
                        requestData.put("request_id", requestsRs.getInt("request_id"));
                        requestData.put("employee_name", requestsRs.getString("employee_name"));
                        requestData.put("software_name", requestsRs.getString("software_name"));
                        requestData.put("access_type", requestsRs.getString("access_type"));
                        requestData.put("reason", requestsRs.getString("reason"));
                        requestsList.add(requestData);
                    }

                    // Set requests list in request scope and forward to pendingRequests.jsp
                    request.setAttribute("requestsList", requestsList);
                    request.getRequestDispatcher("pendingRequests.jsp").forward(request, response);

                } else if ("Admin".equals(role)) {
                    response.sendRedirect("createSoftware.jsp");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Login failed.");
        }
    }
}
