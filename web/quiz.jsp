<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.UserHistory" %>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Add Quiz"/>
</jsp:include>
<div class="container">
    <div class="col-md-12 quiz_summary">
        <form id="quizSummaryForm" method="post">
<%--            <div class="head_info"--%>
                <%
                        int quizId = Integer.parseInt(request.getParameter("id"));
                        Quiz quiz = DatabaseManager.getQuiz(quizId);
                        User user = DatabaseManager.getUser(quiz.getQuizOwnerId());
                %>
            <div class="row">
                <div class="col-sm-4">
                    <img class="img-fluid" src="<%=quiz.getQuizImage()%>;">
                </div>
                <div class="col-sm-8">
                    <h5>Quiz Made By <a href="#"><%=user.getNickName()%></a></h5>
                    <p>(Type: <%=quiz.getQuizType()%>)</p>
                    <p><%=quiz.getQuizDescription()%></p>
                    <a href="#" class="btn btn-danger btn-md">Edit Quiz</a>
                    <a href="#" class="btn btn-danger btn-md">Start Quiz</a>
                </div>
            </div>
            <div class="statistics">
                <div id="user_results" class="row">
                    <div class="form-group">
                        <label for="type">Sort Your Results By</label>
                        <select name="type" id="type" class="form-control">
                            <option value="date">Date</option>
                            <option value="score">Score</option>
                            <option value="time">Time</option>
                        </select>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Score</th>
                            <th scope="col">Date</th>
                            <th scope="col">Time</th>
                        </tr>
                        </thead>

                        <tbody
                        <%
                            int count1 = 0;
                            for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                                count1++;
                        %>
                        <th scope="row"></th>
                        <td><%=count1%>
                        </td>
                        <td><%=history.getScore()%>
                        </td>
                        <td><%=history.getQuizDate()%>
                        </td>
                        <td><%=history.getQuizTime()%>
                        </td>
                        <%}%>
                        </tbody>
                    </table>
                </div>
                <div id="bestPerformers_allTime" class="row">
                    <div class="form-group">
                        <label for="type">Best Performers Of All Time</label>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Score</th>
                            <th scope="col">Date</th>
                            <th scope="col">Time</th>
                        </tr>
                        </thead>

                        <tbody
                        <%
                            int count2 = 0;
                            for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                                count2++;
                        %>
                        <th scope="row"></th>
                        <td><%=count2%>
                        </td>
                        <td><%=history.getScore()%>
                        </td>
                        <td><%=history.getQuizDate()%>
                        </td>
                        <td><%=history.getQuizTime()%>
                        </td>
                        <%}%>
                        </tbody>
                    </table>
                </div>
                <div id="bestPerformers_thisDay" class="row">
                    <div class="form-group">
                        <label for="type">Today's Best Performers</label>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Score</th>
                            <th scope="col">Date</th>
                            <th scope="col">Time</th>
                        </tr>
                        </thead>

                        <tbody
                        <%
                            int count3 = 0;
                            for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                                count3++;
                        %>
                        <th scope="row"></th>
                        <td><%=count3%>
                        </td>
                        <td><%=history.getScore()%>
                        </td>
                        <td><%=history.getQuizDate()%>
                        </td>
                        <td><%=history.getQuizTime()%>
                        </td>
                        <%}%>
                        </tbody>
                    </table>
                </div>
                <div id="recentPerformers" class="row">
                    <div class="form-group">
                        <label for="type">Recent Performers</label>
                    </div>
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Score</th>
                            <th scope="col">Date</th>
                            <th scope="col">Time</th>
                        </tr>
                        </thead>

                        <tbody
                        <%
                            int count4 = 0;
                            for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                                count4++;
                        %>
                        <th scope="row"></th>
                        <td><%=count4%>
                        </td>
                        <td><%=history.getScore()%>
                        </td>
                        <td><%=history.getQuizDate()%>
                        </td>
                        <td><%=history.getQuizTime()%>
                        </td>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
    </div>
    </div>
    </form>
</div>
</div>
<jsp:include page="footer.jsp"/>
