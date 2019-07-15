<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mysql.cj.Session" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="HomePage"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>HomePage</h2>
</div>
<div class="container">
    <div class="row">
        <div class="col-md-6 result_table">
            <h4>Most Popular Quizes</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr role="row">
                    <th>#</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>See Quiz</th>
                </tr>
                </thead>
                <tbody>
                <%
                    ArrayList<Quiz> popularQuizes = DatabaseManager.getPopularQuizzes();
                    int count1 = 0;
                    for (Quiz quiz : popularQuizes) {
                        if (count1 == 5) break;
                        count1++;
                %>
                <tr>
                    <th scope="row"><%=count1%>
                    </th>
                    <td><%=quiz.getTitle()%>
                    </td>
                    <td><%=quiz.getType()%>
                    </td>
                    <td><a href="quiz.jsp?id=<%=quiz.getId()%>">Quiz Page</a></td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <div class="col-md-6 result_table">
            <h4>Recently Added Quizes</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>See Quiz</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int count2 = 0;
                    for (Quiz quiz : DatabaseManager.getRecentlyCreatedQuizzes()) {
                        if (count2 == 5) return;
                        count2++;
                %>
                <tr>
                    <th scope="row"><%=count2%>
                    </th>
                    <td><%=quiz.getTitle()%>
                    </td>
                    <td><%=quiz.getType()%>
                    </td>
                    <td><a href="quiz.jsp?id=<%=quiz.getId()%>">Quiz Page</a></td>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 result_table">
            <h4>Recently Taken Quizes</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>See Quiz</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int id = (int)(session.getAttribute("user_id"));

                    int count3 = 0;
                    for (Quiz quiz : DatabaseManager.getUsersRecentTakenQuizzes(id)) {
                        if (count3 == 5) return;
                        count3++;
                %>
                <tr>
                    <th scope="row"><%=count3%>
                    </th>
                    <td><%=quiz.getTitle()%>
                    </td>
                    <td><%=quiz.getType()%>
                    </td>
                    <td><a href="quiz.jsp?id=<%=quiz.getId()%>">Quiz Page</a></td>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <div class="col-md-6 result_table">
            <h4>Your Made Quizes</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>See Quiz</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int count4 = 0;
                    for (Quiz quiz : DatabaseManager.usersRecentlyAddedQuizzes(id)) {
                        if (count4 == 5) return;
                        count4++;
                %>
                <tr>
                    <th scope="row"><%=count4%>
                    </th>
                    <td><%=quiz.getTitle()%>
                    </td>
                    <td><%=quiz.getType()%>
                    </td>
                    <td><a href="quiz.jsp?id=<%=quiz.getId()%>">Quiz Page</a></td>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>