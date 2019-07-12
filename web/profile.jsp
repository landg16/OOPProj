<%@ page import="Objects.User" %>
<%@ page import="DataAccess.DatabaseManager" %><%--
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

<div class="container profile" >

    <%
        String id = request.getParameter("id");
        String username = (String)session.getAttribute("username");
        String password = (String)session.getAttribute("password");
        int userId;
        if(id==null){
            userId = DatabaseManager.checkLogin(username, password);
        } else {
            userId = Integer.parseInt(id);
        }
        User user = DatabaseManager.getUser(userId);
        if(user == null) {
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
        </div>

    </div>

    <br>
    <br>

    <!-- When you are visiting your own profile-->

    <% if(id==null){ %>
    <div class="row buttons">
        <div class="col-sm-4">
            <p class="headline_text">CHALLENGE REQUESTS</p>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
        </div>

        <div class="col-sm-4">
            <p class="headline_text">CHAT WITH FRIENDS</p>
            <p style="margin-top: 10px"> <a href="register.jsp">Nikolai nikolaevich </a></p>
            <p> <a href="register.jsp">guja gujaevich</a></p>
        </div>

        <div class="col-sm-4">
            <p class="headline_text">FRIEND REQUESTS</p>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
        </div>
    </div>

    <br>
    <br>

    <div class="row buttons">
        <div class="col-sm-6">
            <a href="announcements.jsp" class="btn btn-danger btn-lg">ANNOUNCEMENTS</a>
        </div>

        <div class="col-sm-6">
            <a href="add_quiz.jsp" class="btn btn-danger btn-lg">CREATE YOUR A OWN QUIZ</a>
        </div>
    </div>

    <br>
    <br>

    <div class="row">
        <div class="col-sm-8">
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
            <a href="register.jsp" class="btn btn-danger btn-lg historyBT">SEE ALL QUIZZES</a>
        </div>

        <div class="col-sm-4">
            <div class="row achievements justify-content-around">
                <div class="col-sm-10">
                    <h2>ACHIEVEMENTS ⭐</h2>
                    <p>Amateur Author ⭐</p>
                    <p>Prolific Author ⭐</p>
                    <p>Prodigous Author ⭐</p>
                    <p>Quiz Machine ⭐</p>
                    <p>I'm the greatest ⭐</p>
                    <p>Practice Makes Perfect ⭐</p>
                </div>
            </div>
        </div>
    </div>


    <!-- End of when you are visiting your profile-->

    <%}%>

    <br>
    <br>

    <!-- when you are visiting someone else's profile-->

    <%if(id!=null && DatabaseManager.checkLogin(username, password)!=-1){%>

    <div class="row buttons">
        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">SEND FRIEND REQUEST</a>
        </div>

        <!--- when he isn't friend, then remove

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">SEND FRIEND REQUEST</a>
        </div>

        -->

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">CHAT WITH HIM/HER</a>
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">CHALLENGE TO QUIZ</a>
        </div>
    </div>

    <!-- END OF when you are visiting someone else's profile-->

    <%}%>

    <!-- THIS IS WHEN USER IS VIEWING A PROFILE WHILE HE/SHE ISN'T LOGGED IN-->


    <!--

    THIS IS WHEN ADMIN IS VIEWING PROFILE OF USER

    es washalet tu gindat shesvla profile.jsp ze

    <%if(user.isAdmin()){%>

    <div class="row buttons"
        <div class="col-sm-6">
             <a href="register.jsp" class="btn btn-danger btn-lg">REMOVE USER ACCOUNT</a>
        </div>

        <div class="col-sm-6">
             <a href="register.jsp" class="btn btn-danger btn-lg">PROMOTE USER TO ADMIN</a>
        </div>
    </div>

    <%}%>

    END OF AMDIN'S PROFILE-->
</div>

<jsp:include page="footer.jsp"/>
