<%@ page import="Objects.User" %>
<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="Objects.UserHistory" %>
<%--
  Created by IntelliJ IDEA.
  User: Oniani
  Date: 7/9/2019
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Profile"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>USER'S PROFILE</h2>
</div>

<div class="container profile">

    <%
        String id = request.getParameter("id");
        String username = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("password");
        int userId;
        if (id == null) {
            userId = DatabaseManager.checkLogin(username, password);
        } else {
            userId = Integer.parseInt(id);
        }
        User user = DatabaseManager.getUser(userId);
        if (user == null) {
            response.sendRedirect("index.jsp?error=Wrong URL!");
            return;
        }
    %>

    <div class="row">
        <div class="col-sm-4">
            <img class='img-fluid' src="<%=user.getImageurl()%>">
        </div>

        <div class="col-sm-8">
            <h1><%=user.getFirstname()%> <%=user.getLastname()%></h1>
            <h4><%=user.getEmail()%></h4>

            <br>
            <br>

            <div class="md-form">
                <form id="searchUsr" action="search.jsp" method="get">
                    <input type="text" name="searchUsr" id="searchForm" class="form-control" property="searchUsr">
                    <button class="btn btn-primary" type="submit" value="Search" id="mySearch">Search</button>
                </form>
            </div>
        </div>

    </div>

    <br>
    <br>

    <!-- When you are visiting your own profile-->

    <% if (id == null || Integer.parseInt(id) == DatabaseManager.checkLogin(username, password)) { %>
    <div class="row buttons">
        <div class="col-sm-4">
            <p class="headline_text">CHALLENGE REQUESTS</p>
            <% HashMap<Integer, Integer> requestss = DatabaseManager.getChallenges(userId);
                if(requestss != null && requestss.size()!=0){
                    for (HashMap.Entry<Integer, Integer> tmp : requestss.entrySet()){
                        User usrr = DatabaseManager.getUser(tmp.getKey());
                        Quiz quiz = DatabaseManager.getQuiz(tmp.getValue());
            %>
            <p> <%=usrr.getFirstname()%> <%=usrr.getLastname()%> has challenged you for <%=quiz.getTitle()%> </p>
            <a href="Challenged?senderId=<%=usrr.getId()%>&receiverId=<%=userId%>&quizId=<%=quiz.getId()%>&whatToDo=accept" class="btn btn-danger btn-sm">Accept</a>
            <a href="Challenged?senderId=<%=usrr.getId()%>&receiverId=<%=userId%>&quizId=<%=quiz.getId()%>&whatToDo=decline" class="btn btn-danger btn-sm">Decline</a>
            <%}} else { %>
                <h5>You have no challenge requests</h5>
            <% } %>
        </div>

        <div class="col-sm-4">
            <p class="headline_text">CHAT WITH FRIENDS</p>
            <p style="margin-top: 10px"><a href="register.jsp">Nikolai nikolaevich </a></p>
            <p><a href="register.jsp">guja gujaevich</a></p>
        </div>

        <div class="col-sm-4">
            <p class="headline_text">FRIEND REQUESTS</p>
           <% ArrayList<User> requests = DatabaseManager.getFriendRequest(userId);
              if(requests != null && requests.size() != 0){
               for (User us : requests){%>
            <p> <%=us.getFirstname()%> <%=us.getLastname()%> </p>
            <a href="Friended?senderId=<%=userId%>&receiverId=<%=us.getId()%>&whatToDo=accept" class="btn btn-danger btn-sm">Accept</a>
            <a href="Friended?senderId=<%=userId%>&receiverId=<%=us.getId()%>&whatToDo=decline" class="btn btn-danger btn-sm">Decline</a>
            <%}} else { %>
                <h5>You have no friend requests</h5>
            <% } %>
        </div>
    </div>

    <br>
    <br>



    <%if(DatabaseManager.isAdmin(userId)){%>
    <div class="row buttons">
        <div class="col-sm-4">
            <a href="announcements.jsp" class="btn btn-danger btn-lg">ANNOUNCEMENTS</a>
        </div>

        <div class="col-sm-4">
            <a href="add_quiz.jsp" class="btn btn-danger btn-lg">CREATE YOUR OWN QUIZ</a>
        </div>

        <div class="col-sm-4">
            <a href="add_announcement.jsp" class="btn btn-danger btn-lg">MAKE AN ANNOUNCEMENT</a>
        </div>
    </div>
    <% } else { %>
    <div class="row buttons">
        <div class="col-sm-4">
            <a href="announcements.jsp" class="btn btn-danger btn-lg">ANNOUNCEMENTS</a>
        </div>

        <div class="col-sm-4">
            <a href="add_quiz.jsp" class="btn btn-danger btn-lg">CREATE YOUR OWN QUIZ</a>
        </div>

        <div class="col-sm-4">
            <a href="friends.jsp" class="btn btn-danger btn-lg">FRIENDS</a>
        </div>
    </div>

    <%}%>

    <br>
    <br>

    <div class="row">
        <div class="col-sm-8">
            <table class="table">
                <thead class="thead-dark">
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Quiz Id</th>
                    <th scope="col">Time</th>
                    <th scope="col">Score</th>
                </tr>
                </thead>
                <tbody>
                <%  int usr = (int) session.getAttribute("user_id");
                    int count = 0;
                    ArrayList<UserHistory> userHistory = DatabaseManager.getUserHistory(usr);
                    for(UserHistory history : userHistory){
                        count++;
                    %>
                <tr>
                    <th scope="row"><%=count%></th>
                    <td><%=history.getQuizId()%></td>
                    <td><%=(history.getQuizEnd()-history.getQuizStart())/1000%> Seconds</td>
                    <td><%=history.getScore()%></td>
                </tr>
                    <%}%>
                </tbody>
            </table>
        </div>

        <div class="col-sm-4">
            <div class="row achievements justify-content-around">
                <div class="col-sm-10">
                    <h2>ACHIEVEMENTS</h2>
                    <br>
                    <%
                        int userScore=0;
                        int userAch = (int) session.getAttribute("user_id");
                        ArrayList<UserHistory> userHistoryAch= DatabaseManager.getUserHistory(userAch);
                        for(UserHistory history : userHistoryAch){
                            userScore += history.getScore();
                        }
                        if(userScore<20){
                    %>
                    <h4>Level 1 - Rookie</h4>
                    <p>Knowledge equal to our front-end developer</p>
                    <%}%>

                    <%if(userScore>=20 && userScore<100){
                    %>
                    <h4>Level 2 - Beginner</h4>
                    <p>Knowledge equal to our Back-end developer</p>
                    <%}%>

                    <%if(userScore>=100 && userScore<200){
                    %>
                    <h4>Level 3 - Intermidiate</h4>
                    <p>Knowledge equal to our Elon Musk</p>
                    <%}%>

                    <%if(userScore>=200 && userScore<500){
                    %>
                    <h4>Level 4 - Expert</h4>
                    <p>Knowledge equal to our whole team</p>
                    <%}%>

                    <%if(userScore>=500){
                    %>
                    <h4>Level 5 - GOD</h4>
                    <p>Knowledge equal to our LITERALLY GOD</p>
                    <%}%>
                </div>
            </div>
        </div>
    </div>


    <!-- End of when you are visiting your profile-->

    <%}%>

    <br>
    <br>

    <!-- when you are visiting someone else's profile-->

    <%if (id!= null && DatabaseManager.checkLogin(username, password)!= Integer.parseInt(id) && DatabaseManager.checkLogin(username, password) != -1) {%>



    <div class="row buttons">
        <%ArrayList<User> us = DatabaseManager.getFriends(DatabaseManager.checkLogin(username, password));
        boolean st=false;
        for(User uss : us){
                if(uss.getId()==Integer.parseInt(id)){
                    st=true;
                }
            }
            if((us!=null && !st) || us==null){
        %>
        <div class="col-sm-6">
            <form method="post" action="FriendRequest" id="send_friend_request_form">
                <input type="hidden" name="id" value=<%=userId%>>
                <button class="btn btn-danger btn-lg">SEND FRIEND REQUEST</button>
            </form>
        </div>

        <%}%>

        <!--- when he isn't friend, then remove

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">SEND FRIEND REQUEST</a>
        </div>

        -->

        <div class="col-sm-6">
            <a href="chat.jsp" class="btn btn-danger btn-lg">CHAT WITH HIM/HER</a>
        </div>

    </div>

    <!-- END OF when you are visiting someone else's profile-->

    <%}%>

    <!-- THIS IS WHEN USER IS VIEWING A PROFILE WHILE HE/SHE ISN'T LOGGED IN-->


    <!--

    THIS IS WHEN ADMIN IS VIEWING PROFILE OF USER

    es washalet tu gindat shesvla profile.jsp ze

    -->
    <%if(id==null && DatabaseManager.isAdmin(DatabaseManager.checkLogin(username, password))){%>

    <%}else{%>

    <%if(DatabaseManager.isAdmin(DatabaseManager.checkLogin(username, password)) && (DatabaseManager.checkLogin(username, password)!= Integer.parseInt(id))){%>

    <br>

    <div class="row buttons">
        <div class="col-sm-6">
            <form method="post" action="RemoveUser" id="remove_user">
                <input type="hidden" name="id" value=<%=userId%>>
                <button class="btn btn-danger btn-lg">REMOVE USER</button>
            </form>
        </div>

        <div class="col-sm-6">
            <form method="post" action="PromoteAdmin" id="set_as_admin_form">
                <input type="hidden" name="id" value=<%=userId%>>
                <button class="btn btn-danger btn-lg">PROMOTE USER TO ADMIN</button>
            </form>
        </div>
    </div>

    <%}}%>

    <!-- END OF AMDIN'S PROFILE-->
</div>

<jsp:include page="footer.jsp"/>
