<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.UserHistory" %>

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
                <a href="#" class="btn btn-danger w-100" data-toggle="modal" data-target="#challengeFriend">Challenge a friend</a>
            <% } %>
        </div>
    </div>
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
                        ArrayList<UserHistory> histories = DatabaseManager.getUserHistory(1);
                        int count1 = 0;
                        for (UserHistory history : DatabaseManager.getUserHistory(1)) {
                            count1++;
                    %>
                    <tr>
                        <th scope="row"><%=count1%></th>
                        <td><%=history.getQuizScore()%></td>
                        <td><%=history.getQuizStart()%></td>
                        <td><%=history.getQuizEnd() - history.getQuizStart()%></td>
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
                        <th scope="col">Duration</th>
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
                        <td><%=history.getQuizScore()%>
                        </td>
                        <td><%=history.getQuizStart()%>
                        </td>
                        <td><%=history.getQuizEnd() - history.getQuizStart()%>
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
                    <th scope="col">Duration</th>
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
                    <td><%=history.getQuizScore()%>
                    </td>
                    <td><%=history.getQuizStart()%>
                    </td>
                    <td><%=history.getQuizEnd() - history.getQuizStart()%>
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
                    <th scope="col">Duration</th>
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
                    <td><%=history.getQuizScore()%></td>
                    <td><%=history.getQuizStart()%></td>
                    <td><%=history.getQuizEnd() - history.getQuizStart()%></td>
                </tr>
                <%}%>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="modal login" tabindex="-1" role="dialog" id="challengeFriend">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Challenge a friend</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <%
                    ArrayList<User> friends = DatabaseManager.getFriends(k);
                    if(friends != null && friends.size()>0){
                        for(User usr : friends) { %>
                <div class="row">
                    <div class="col-md-6">
                        <p><%=usr.getFirstname()%> <%=usr.getLastname()%> (<%=usr.getUsername()%>)</p>
                    </div>
                    <div class="col-md-6 text-right">
                        <form method="get" action="ChallengeRequest" id="send_friend_request_form">
                            <input type="hidden" name="senderId" value="<%=k%>">
                            <input type="hidden" name="receiverId" value="<%=usr.getId()%>">
                            <input type="hidden" name="quizId" value="<%=quizId%>">
                            <button type="submit" class="btn btn-danger">Send Challenge</button>
                        </form>
                    </div>
                </div>
                <%
                        }
                    } else {  %>
                <h4>You have no friends :(</h4>
                <%
                    } %>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
