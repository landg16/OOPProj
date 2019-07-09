<%--
  Created by IntelliJ IDEA.
  User: Oniani
  Date: 7/9/2019
  Time: 7:29 PM
  To change this template use File | Settings | File Templates.
--%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Sign Up"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>USER'S PROFILE</h2>
</div>

<div class="container profile" >
    <div class="row">
        <div class="col-sm-4">
            <img class='img-fluid' src="https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/40133576_1678577612252835_2706565188802314240_n.jpg?_nc_cat=102&_nc_oc=AQkqAzB_-LogQxTNtsA6NG94bPFmgxv05g1rZIYlKD3bK_d73KjRe8zcZiAhrLQh9kA&_nc_ht=scontent.ftbs5-1.fna&oh=b49adad1a4c0ccf5f7ec50a04e934284&oe=5DBDBB32">
        </div>

        <div class="col-sm-8">
            <h1>Nick Oniani</h1>
            <h4>CEO & CO-FOUNDER @UNLEASH AR</h4>
            <h4>Free University of Georgia</h4>
            <p>10 quizzes</p>
        </div>

    </div>

    <br>
    <br>

    <!-- When you are visiting your own profile-->
    <div class="row buttons">
        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">CHALLENGE REQUESTS</a>
            <br>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
            <p class="requests">Guja Lortkipanidze</p>
            <a href="register.jsp" class="btn btn-danger btn-sm">Accept</a>
            <a href="register.jsp" class="btn btn-danger btn-sm">Decline</a>
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">CHAT WITH FRIENDS</a>
            <p style="margin-top: 10px"> <a href="register.jsp">Nikolai nikolaevich </a></p>
            <p> <a href="register.jsp">guja gujaevich</a></p>
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">FRIEND REQUESTS</a>
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
                    <h2>ACHIEVEMENTS</h2>
                    <p>Amateur Author</p>
                    <p>Prolific Author</p>
                    <p>Prodigous Author</p>
                    <p>Quiz Machine</p>
                    <p>I'm the greatest</p>
                    <p>Practice Makes Perfect</p>
                </div>
            </div>
        </div>
    </div>
    <!-- End of when you are visiting your profile-->

    <br>
    <br>

    <!-- when you are visiting someone else's profile-->
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
</div>

<jsp:include page="footer.jsp"/>
