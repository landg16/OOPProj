<%@ page import="DataAccess.DatabaseManager" %><%--
  Created by IntelliJ IDEA.
  User: Oniani
  Date: 7/9/2019
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="History"/>
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
    <h2>HISTORY</h2>
</div>

<div class="container">
    <div class="row">
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Quiz Name</th>
                    <th scope="col">Date</th>
                    <th scope="col">Time</th>
                    <th scope="col">Score</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                    <td>20</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td>Jacob</td>
                    <td>Thornton</td>
                    <td>@fat</td>
                    <td>20</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td>Larry</td>
                    <td>the Bird</td>
                    <td>@twitter</td>
                    <td>20</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

<jsp:include page="footer.jsp"/>