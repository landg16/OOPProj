<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.Quiz" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Home"/>
</jsp:include>
<div class="cover">
    <div class="hero-text">
        <h1>Challenge your knowledge!</h1>
        <%
        String username = (String)session.getAttribute("username");
        String password = (String)session.getAttribute("password");
        int k = DatabaseManager.checkLogin(username, password);
        if(k==-1){ %>
        <h4>Register or Sign Up, Create and Take Quizzes.</h4>
        <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#logIn">LOG IN</button>
        <a href="register.jsp" class="btn btn-danger btn-lg">SIGN UP</a>
        <% } else {%>
        <h4>Go to quiz page and test your knowledge.</h4>
        <a href="profile.jsp" class="btn btn-danger btn-lg">PROFILE</a>
        <a href="LogOut" class="btn btn-danger btn-lg">LOG OUT</a>
        <% } %>
    </div>
</div>
<% int userId = (int)session.getAttribute("user_id");
    if(userId != -1){
        ArrayList<User> leaderUsers = DatabaseManager.getLeaderUsers();
//        User user1 = leaderUsers.get(0);
//        User user2 = leaderUsers.get(1);
//        User user3 = leaderUsers.get(2);
//
//        ArrayList<String> achievement1 = DatabaseManager.getAchievement(user1.getId());
//        ArrayList<String> achievement2 = DatabaseManager.getAchievement(user2.getId());
//        ArrayList<String> achievement3 = DatabaseManager.getAchievement(user3.getId());
        ArrayList<Quiz> popularQuizes = DatabaseManager.getPopularQuizzes();
%>
<div class="container featured">
    <div class="row">
        <h2>Featured Learning Quizzes!</h2>
    </div>
    <div class="row justify-content-around">
        <%
            int count = 0;
            for(Quiz quiz : popularQuizes) {
                count++;
                if(count == 3)break;
        %>
        <div class="col-sm-3 item">
            <div class="img" style="background-image:url(<%=quiz.getImageUrl()%>);"></div>
            <div class="description">
                <span class="left"><%=quiz.getTitle()%></span>
                <span class="right"><%=quiz.getType()%></span>
                <div class="clear"></div>
                <hr>
                <a href="#">Take Quiz</a>
                <%=quiz.getTitle()%>
                <hr>
                <span class="left"><a href="quiz.jsp?id=<%=quiz.getId()%>">Take Quiz</a></span>
                <span class="right"><%=quiz.getType()%></span>
                <div class="clear"></div>
            </div>
        </div>
        <%}%>
<%--        <div class="col-sm-3 item">--%>
<%--            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>--%>
<%--            <div class="description">--%>
<%--                <span class="left">Football Quiz</span>--%>
<%--                <span class="right">Sports</span>--%>
<%--                <div class="clear"></div>--%>
<%--                <hr>--%>
<%--                <a href="#">Take Quiz</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-sm-3 item">--%>
<%--            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>--%>
<%--            <div class="description">--%>
<%--                <span class="left">Football Quiz</span>--%>
<%--                <span class="right">Sports</span>--%>
<%--                <div class="clear"></div>--%>
<%--                <hr>--%>
<%--                <a href="#">Take Quiz</a>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>
</div>
<div class="container-fluid counters">
    <div class="jumbotron paral paralsec">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count"><%=DatabaseManager.getAllUsers().size()%></h1>
                    <h4>USER</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count"><%=DatabaseManager.getAllQuizes().size()%></h1>
                    <h4>QUIZ</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count"><%=DatabaseManager.numberOfQuizCreators()%></h1>
                    <h4>CREATOR</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count"><%=DatabaseManager.averageAllQuizDuration()%></h1>
                    <h4>AVG. QUIZ TIME</h4>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container leaderboard">
    <div class="row">
        <h2>LEADERBOARD</h2>
    </div>
    <div class="row justify-content-around">

        <%
            int count1 = 0;
            for(User user : leaderUsers) {
                count1++;
        %>
        <div class="col-sm-3 each">
            <h4>1. <a href="profile.jsp?id=<%=user.getId()%>"></a>USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span><%=DatabaseManager.getScore(user.getId())%></span></p>
<%--                <p><span>TITLE:</span> <span><%=achievement1.get(achievement1.size() - 1)%></span></p>--%>
                <p><span>TITLE:</span> <span></span></p>
                <p><span>QUIZ TAKEN:</span> <span><%="yleoo"%></span></p>
            </div>
        </div>
        <%}%>
<%--        <div class="col-sm-3 each">--%>
<%--            <h4>2. <a href="profile.jsp?id=<%=user2.getId()%>"></a>USER</h4>--%>
<%--            <hr>--%>
<%--            <div class="description">--%>
<%--                <p><span>SCORE:</span> <span><%=DatabaseManager.getScore(user2.getId())%></span></p>--%>
<%--&lt;%&ndash;                <p><span>TITLE:</span> <span><%=achievement2.get(achievement1.size() - 1)%></span></p>&ndash;%&gt;--%>
<%--                <p><span>TITLE:</span> <span>shobeldzagli</span></p>--%>
<%--                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-sm-3 each">--%>
<%--            <h4>3. <a href="profile.jsp?id=<%=user3.getId()%>"></a>USER</h4>--%>
<%--            <hr>--%>
<%--            <div class="description">--%>
<%--                <p><span>SCORE:</span> <span><%=DatabaseManager.getScore(user3.getId())%></span></p>--%>
<%--&lt;%&ndash;                <p><span>TITLE:</span> <span><%=achievement3.get(achievement1.size() - 1)%></span></p>&ndash;%&gt;--%>
<%--                <p><span>TITLE:</span> <span>shobeldzagli</span></p>--%>
<%--                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>--%>
<%--            </div>--%>
<%--        </div>--%>
    </div>

<%--    <div class="row justify-content-around second-row">--%>
<%--        <div class="col-sm-3 each">--%>
<%--            <h4>4. USER</h4>--%>
<%--            <hr>--%>
<%--            <div class="description">--%>
<%--                <p><span>SCORE:</span> <span>1251251</span></p>--%>
<%--                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>--%>
<%--                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-sm-3 each">--%>
<%--            <h4>5. USER</h4>--%>
<%--            <hr>--%>
<%--            <div class="description">--%>
<%--                <p><span>SCORE:</span> <span>1251251</span></p>--%>
<%--                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>--%>
<%--                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="col-sm-3 each">--%>
<%--            <h4>6. USER</h4>--%>
<%--            <hr>--%>
<%--            <div class="description">--%>
<%--                <p><span>SCORE:</span> <span>1251251</span></p>--%>
<%--                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>--%>
<%--                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
    <div class="row last-row">
        <div class="col-12">
            <a href="leaderboard.jsp" class="btn btn-warning btn-lg">SEE ALL</a>
        </div>
    </div>
</div>
        <%}%>
<jsp:include page="footer.jsp"/>