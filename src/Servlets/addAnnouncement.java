package Servlets;

import DataAccess.DatabaseManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/addAnnouncement")
public class addAnnouncement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String errors = "";
        int user_id = (int) request.getSession().getAttribute("user_id");
        String title = request.getParameter("title");
        if(title == null || title.length()<1) errors += "<p class='error'>Title is Required</p>";

        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd 'at' HH:mm:ss z");
        Date date = new Date(System.currentTimeMillis());


        String description = request.getParameter("description");
        if(description == null || description.length()<1) errors += "<p class='error'>Description is Required</p>";
        else if(description.length()>250) errors += "<p class='error'>Description's maximum length is 250 character.";

        DatabaseManager.InsertAnnouncement(user_id, title, description);
        response.sendRedirect("profile.jsp?success=You have successfuly added announcement!");
    }
}