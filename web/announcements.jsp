<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Announcement" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.User" %>
<%@ page import="javax.xml.crypto.Data" %><%--
  Created by IntelliJ IDEA.
  User: Oniani
  Date: 7/11/2019
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Announcements"/>
</jsp:include>

<%
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("index.jsp?error=You are not logged in!");
        return;
    }
%>

<div class="container-fluid heading">
    <h2>Announcements</h2>
</div>
<div class="container form">
    <div class="row buttons">
        <%
            ArrayList<Announcement> announcements = DatabaseManager.getAnnouncements();
            if(announcements!=null){
                for(Announcement ann : announcements){
                    User user = DatabaseManager.getUser(ann.getAnnouncerId());
        %>
        <div class="col-sm-4">
            <h2><%=ann.getTitle()%></h2>
            <p> By user: <%=user.getFirstname()%> <%=user.getLastname()%></p>
            <h6><%=ann.getText()%></h6>
        </div>
        <%}}%>
    </div>
</div>
<jsp:include page="footer.jsp"/>