# Leucine-UserAccessManagement-
maven project (Servlet, Jsp, html, css, javascript, postgerlsl)

The User Access Management System is a web-based application that streamlines managing access to software applications within an organization. This tool enhances security by enabling employees to request access, while managers and admins handle approvals.

Features
User Registration and Authentication
Users can sign up and log in with different roles: Employee, Manager, and Admin.

Role-Based Access Control
Employee: Requests access to applications.
Manager: Reviews and approves/rejects access requests.
Admin: Adds applications and manages settings.

Software Management
Admins can add software with specified access levels (Read, Write, Admin).
Access Request and Approval Workflow
Employees request access; managers approve or reject.

Technologies
Backend: Java, Servlets, html, css, javascript and JSP
Database: PostgreSQL
Build Tool: Maven

Setup Instructions
Clone the Repository: Clone this project to your local machine.
Database Setup:
Ensure PostgreSQL is installed.
Run the provided SQL script to create the necessary tables (users, software, requests).
(add admin data and manager data manualy in data base)

Configure the Application:
Update database configurations in the code (if required). 

Run the Server:
Deploy the project using a Java Servlet container (e.g., Apache Tomcat).

Access the Application:
Open a web browser and navigate to the server URL.

User Roles
Employee: Registers, logs in, and requests software access.
Manager: Logs in, reviews, and approves/rejects access requests.
Admin: Logs in, creates software applications, and has full access rights.

File Structure
Java Servlets:
SignUpServlet.java
LoginServlet.java
SoftwareServlet.java
RequestServlet.java
ApprovalServlet.java

JSP Pages:
signup.jsp
login.jsp
createSoftware.jsp
requestAccess.jsp
pendingRequests.jsp

Database Scripts:
SQL script for creating and initializing tables.

Evaluation Criteria
Functional completion: User sign-up, login, software creation, and access requests.
Code organization and modularity.
Database interactions for managing requests and approvals.
