package Servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LogOut")
public class LogOut extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("user_id", -1);
        request.getSession().setAttribute("username", "");
        request.getSession().setAttribute("password", "");
        response.sendRedirect("index.jsp?success=Logged Out Successfuly");
    }
}
