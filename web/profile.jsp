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
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">CHAT WITH FRIENDS</a>
        </div>

        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">FRIEND REQUESTS</a>
        </div>

    </div>

    <div class="row achievements justify-content-around">
        <div class="col-sm-4">
            <h4>Amateur Author</h4>
            <h4>Prolific Author</h4>
            <h4>Prodigous Author</h4>
            <h4>Quiz Machine</h4>
            <h4>I'm the greatest</h4>
            <h4>Practice Makes Perfect</h4>
        </div>
    </div>

    <!-- End of when you are visiting your profile-->


    <!-- when you are visiting someone else's profile-->
    <div class="row buttons">
        <div class="col-sm-4">
            <a href="register.jsp" class="btn btn-danger btn-lg">SEND FRIEND REQUEST</a>
        </div>

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
