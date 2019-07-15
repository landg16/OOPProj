<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.User" %>
<%@ page import="DataAccess.DatabaseManager" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Search"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>Search Results</h2>
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
    <div class="row justify-content-around">
        <div class="col-lg-9 quiz_prepare">
<%--            <div class="row Quiz_List">--%>
                <table class="table">
                    <thead class="thead-dark">
                    <tr>
                        <th>Firstname</th>
                        <th>Lastname</th>
                        <th>Username</th>
                        <th>See User</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%for (User user : neededUsers) {%>
                    <tr>
<%--                    <div class="item filter_box">--%>
<%--                        <h5><a href="profile.jsp?id=<%=user.getId()%>"><%=user.getUsername()%></a></h5>--%>
<%--                    </div>--%>
                        <td><%=user.getFirstname()%></td>
                        <td><%=user.getLastname()%></td>
                        <td><%=user.getUsername()%></td>
                        <td><a href="profile.jsp?id=<%=user.getId()%>">User Page</a></td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
<%--            </div>--%>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
