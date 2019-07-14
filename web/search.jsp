<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.User" %>
<%@ page import="DataAccess.DatabaseManager" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Search"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>These Are Users From Japan</h2>
</div>

<div class="container">
    <%
        String searchedName = request.getParameter("searchUsr");
        ArrayList<User> allUsers = DatabaseManager.getAllUsers();
        ArrayList<User> neededUsers = new ArrayList<>();

        for (User user: allUsers) {
            String userName = user.getUsername();
            if(userName.startsWith(searchedName))neededUsers.add(user);
        }
    %>
    <div class="row">
        <div class="col-sm-9 quiz_prepare">
            <div class="row Quiz_List">
                <%for (User user : neededUsers) {%>
                <div class="item filter_box">
                    <h5><a href="profile.jsp?id=<%=user.getId()%>"><%=user.getUsername()%></a></h5>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
