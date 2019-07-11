<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.UserHistory" %>
<%@ page import="Helper.Helper" %>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>QUIZ PAGE</h2>
</div>

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
                    <h1><%=quiz.getQuizTitle()%></h1>
                    <h4>Quiz Made By <a href="#"><%=user.getUsername()%></a></h4>
                    <p>(Category: <a href="quiz_select.jsp"><%=quiz.getQuizType()%>)</a></p>
                    <p>(Quiz type: <%if (quiz.getQuizIsImmediate()==true){
                        out.println("Not immediate)");
                    }%>
                    <%if (quiz.getQuizIsImmediate()==false){
                        out.println("immediate)");
                    }%>
                    <h5>Description: <%=quiz.getQuizDescription()%></h5>
                    <br>
                </div>
            </div>
    <br>

    <div class="row buttons">
        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">Edit Quiz</a>
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">Start Quiz</a>
        </div>

        <div class="col-sm-4">
            <a href="friends.jsp" class="btn btn-danger btn-lg">Challenge a friend</a>
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
                            Helper help = new Helper();
                            ArrayList<UserHistory> histories = DatabaseManager.getUserHistory(1);
                            help.sortByDate(histories);
                            int count1 = 0;
                            for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                                count1++;
                        %>
                        <tr>
                            <th scope="row"><%=count1%></th>
                            <td><%=history.getScore()%>
                            </td>
                            <td><%=history.getQuizDate()%>
                            </td>
                            <td><%=history.getQuizTime()%>
                            </td>
                        </tr>
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
                        <tr>
                            <th scope="row"><%=count2%></th>
                            <td><%=history.getScore()%>
                            </td>
                            <td><%=history.getQuizDate()%>
                            </td>
                            <td><%=history.getQuizTime()%>
                            </td>
                        </tr>
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
                        <tr>
                            <th scope="row"><%=count3%></th>
                            <td><%=history.getScore()%>
                            </td>
                            <td><%=history.getQuizDate()%>
                            </td>
                            <td><%=history.getQuizTime()%>
                            </td>
                        </tr>
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
                        <tr>
                            <th scope="row"><%=count4%></th>
                            <td><%=history.getScore()%>
                            </td>
                            <td><%=history.getQuizDate()%>
                            </td>
                            <td><%=history.getQuizTime()%>
                            </td>
                        </tr>
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
