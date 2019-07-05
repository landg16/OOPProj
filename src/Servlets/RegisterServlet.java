package Servlets;

import DataAccess.DatabaseManager;
import Objects.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String nickName = request.getParameter("nickName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");


        DatabaseManager dataManager = new DatabaseManager();
        if(dataManager.nickNameExists(nickName))return;

        if(dataManager.emailExists(email))return;
        //todo: return success page or email is used or nickname is used
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
