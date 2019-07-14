<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.UserHistory" %>
<%@ page import="Helper.Helper" %>

<%
    //Check quiz ID
    String quiz_id_str = request.getParameter("id");
    if(quiz_id_str==null){
        response.sendRedirect("quizzes.jsp?error=Quiz does not exist!");
        return;
    }
    int quizId = Integer.parseInt(quiz_id_str);

    //Check quiz ID in Database
    Quiz quiz = DatabaseManager.getQuiz(quizId);
    if(quiz == null){
        response.sendRedirect("quizzes.jsp?error=Quiz does not exist!");
        return;
    }

    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);
    User user = DatabaseManager.getUser(k);
    User quiz_owner = DatabaseManager.getUser(quiz.getQuizOwnerId());

    boolean immediate = quiz.isImmediateCorrection();
    boolean practice = quiz.isPracticeMode();
    boolean onePage = quiz.isOnePage();
%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>QUIZ PAGE</h2>
</div>

<div class="container">
    <div class="row quiz_summary">
        <div class="col-md-4 image" style="background-image:url('<%=quiz.getImageUrl()%>')">
        </div>
        <div class="col-md-5 description">
            <h1><%=quiz.getTitle()%></h1>
            <p><b>Created by:</b> <a href="profile.jsp?id=<%=quiz_owner.getId()%>"><%=quiz_owner.getUsername()%></a></p>
            <p><b>Category:</b> <a href="quizzes.jsp"><%=quiz.getType()%></a></p>
            <p><b>Immediate Correction:</b> <%if (immediate){ %>Yes<% } else { %>No<% } %></p>
            <p><b>Practice Mode:</b> <%if (practice){ %>Yes<% } else { %>No<% } %></p>
            <p><b>Question Display Type:</b> <%if (onePage){ %>One Page<% } else { %>Multitple Page<% } %></p>
            <p><b>Description:</b> <%=quiz.getDescription()%></p>
        </div>
        <div class="col-md-3 buttons">
            <% if(user==null){ %>
                <a href="register.jsp" class="btn btn-danger w-100">Start Quiz</a>
                <a href="register.jsp" class="btn btn-danger w-100">Challenge a friend</a>
            <% } else { %>
            <% if(user.getId()==quiz_owner.getId()){ %>
                <a href="edit_quiz.jsp" class="btn btn-danger w-100">Edit Quiz</a>
            <% } %>
                <a href="quiz_start.jsp?id=<%=quizId%>" class="btn btn-danger w-100">Start Quiz</a>
                <a href="challengeFriend.jsp" class="btn btn-danger w-100">Challenge a friend</a>
            <% } %>
        </div>
    </div>
<%--    <div class="row buttons">--%>
<%--        <% if(user==null){ %>--%>
<%--        <div class="col-sm-4">--%>
<%--            <a href="register.jsp" class="btn btn-danger btn-lg">Start Quiz</a>--%>
<%--        </div>--%>
<%--        <div class="col-sm-4">--%>
<%--            <a href="register.jsp" class="btn btn-danger btn-lg">Challenge a friend</a>--%>
<%--        </div>--%>
<%--        <% } else { %>--%>
<%--        <% if(user.getId()==quiz_owner.getId()){ %>--%>
<%--        <div class="col-sm-4">--%>
<%--            <a href="edit_quiz.jsp" class="btn btn-danger btn-lg">Edit Quiz</a>--%>
<%--        </div>--%>
<%--        <% } %>--%>
<%--        <div class="col-sm-4">--%>
<%--            <a href="quiz_start.jsp?id=<%=quizId%>" class="btn btn-danger btn-lg">Start Quiz</a>--%>
<%--        </div>--%>
<%--        <div class="col-sm-4">--%>
<%--            <a href="challengeFriend.jsp" class="btn btn-danger btn-lg">Challenge a friend</a>--%>
<%--        </div>--%>
<%--        <% } %>--%>
<%--    </div>--%>
    <div class="row">
        <div class="col-md-6 result_table">
            <h4>Your Past Results</h4>
            <table id="myResults" class="table tablesorter">
                <thead class="thead-dark">
                    <tr role="row">
                        <th>#</th>
                        <th>Score</th>
                        <th>Date</th>
                        <th>Duration</th>
                    </tr>
                </thead>
                <tbody>
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
                        <td><%=history.getScore()%></td>
                        <td><%=history.getQuizDate()%></td>
                        <td><%=history.getQuizTime()%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </div>
        <div class="col-md-6 result_table">
            <h4>Best Performers of all time</h4>
            <table class="table">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">#</th>
                        <th scope="col">Score</th>
                        <th scope="col">Date</th>
                        <th scope="col">Time</th>
                    </tr>
                </thead>
                <tbody>
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
    </div>
    <div class="row">
        <div class="col-md-6 result_table">
            <h4>Today's Best Performers</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Score</th>
                    <th scope="col">Date</th>
                    <th scope="col">Time</th>
                </tr>
                </thead>

                <tbody>
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
        <div class="col-md-6 result_table">
            <h4>Recent Performers</h4>
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Score</th>
                    <th scope="col">Date</th>
                    <th scope="col">Time</th>
                </tr>
                </thead>

                <tbody>
                <%
                    int count4 = 0;
                    for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                        count4++;
                %>
                <tr>
                    <th scope="row"><%=count4%></th>
                    <td><%=history.getScore()%></td>
                    <td><%=history.getQuizDate()%></td>
                    <td><%=history.getQuizTime()%></td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
