<%@ page import="DataAccess.DatabaseManager" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Make Announcement"/>
</jsp:include>

<%
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1 || !DatabaseManager.isAdmin(k)){
        response.sendRedirect("index.jsp?error=You are not Admin!");
        return;
    }
%>

<div class="container-fluid heading">
    <h2>MAKE AN ANNOUNCEMENT</h2>
</div>

<div class="container">
    <form method="post" action="addAnnouncement" id="add_announcement_form">
        <div class="form-group">
            <label for="Title">Announcement title</label>
            <input type="text" class="form-control" name="title" id="Title">
        </div>
        <div class="form-group">
            <label for="Description">Announcement text</label>
            <textarea class="form-control" name="description" id="Description"></textarea>
        </div>

        <br>

        <button href="google.com" class="btn btn-danger"> Make an announcement</button>

        <br>
        <br>
        <br>
    </form>
</div>

<jsp:include page="footer.jsp"/>