<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Friends"/>
</jsp:include>

<%
    String id = request.getParameter("id");
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("index.jsp?error=You are not logged in!");
        return;
    }
%>

<div class="container-fluid heading">
    <h2>Friends</h2>
</div>

<%
    int userId;
    userId = DatabaseManager.checkLogin(username, password);
    User user = DatabaseManager.getUser(userId);
%>

<form class="row">
    <div class="col-sm-10">
        <input class="form-control" type="text" placeholder="Type here">
    </div>
    <div class="col-sm-2">
        <button type="submit"><p>Search</p></button>
    </div>
</form>

<div class="container user-margin">
    <div class="row justify-content-around">
        <%ArrayList <User> us = DatabaseManager.getFriends(userId);
        if(us!=null){
            for(User usr : us){
        %>
        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('<%=usr.getImageurl()%>')"></div>
                <h2><%=usr.getFirstname()%> <%=usr.getLastname()%></h2>
                <h6><%=usr.getEmail()%></h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <a href="profile.jsp?id=<%=usr.getId()%>" class="btn btn-dark w-100 button-class">View</a>
            </div>
        </div>
        <%}}%>
    </div>
</div>

<jsp:include page="footer.jsp"/>
