<jsp:include page="header.jsp">
    <jsp:param name="title" value="Home"/>
</jsp:include>
<div class="cover">
    <div class="hero-text">
        <h1>Challenge your knowledge!</h1>
        <h4>Register or Sign Up, Create and Take Quizzes.</h4>
        <button class="btn btn-danger btn-lg">SIGN UP</button>
        <button class="btn btn-danger btn-lg">REGISTRATION</button>
    </div>
</div>
<div class="container featured">
    <div class="row">
        <h2>Featured Learning Quizzes!</h2>
    </div>
    <div class="row justify-content-around">
        <div class="col-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div style="clear: both;"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
        <div class="col-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div style="clear: both;"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
        <div class="col-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div style="clear: both;"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>