<jsp:include page="header.jsp">
    <jsp:param name="title" value="Home"/>
</jsp:include>
<div class="cover">
    <div class="hero-text">
        <h1>Challenge your knowledge!</h1>
        <h4>Register or Sign Up, Create and Take Quizzes.</h4>
        <button class="btn btn-danger btn-lg" data-toggle="modal" data-target="#logIn">LOG IN</button>
        <a href="register.jsp" class="btn btn-danger btn-lg">SIGN UP</a>
    </div>
</div>
<div class="container featured">
    <div class="row">
        <h2>Featured Learning Quizzes!</h2>
    </div>
    <div class="row justify-content-around">
        <div class="col-sm-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div class="clear"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
        <div class="col-sm-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div class="clear"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
        <div class="col-sm-3 item">
            <div class="img" style="background-image:url('img/quizzes/football.jpg');"></div>
            <div class="description">
                <span class="left">Football Quiz</span>
                <span class="right">Sports</span>
                <div class="clear"></div>
                <hr>
                <a href="#">Take Quiz</a>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid counters">
    <div class="jumbotron paral paralsec">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count">120</h1>
                    <h4>USER</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count">612</h1>
                    <h4>QUIZ</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count">50</h1>
                    <h4>CREATOR</h4>
                </div>
                <div class="col-md-3 col-sm-6 col-12 item">
                    <h1 class="count">2306</h1>
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
        <div class="col-sm-3 each">
            <h4>1. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
        <div class="col-sm-3 each">
            <h4>2. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
        <div class="col-sm-3 each">
            <h4>3. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
    </div>

    <div class="row justify-content-around second-row">
        <div class="col-sm-3 each">
            <h4>4. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
        <div class="col-sm-3 each">
            <h4>5. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
        <div class="col-sm-3 each">
            <h4>6. USER</h4>
            <hr>
            <div class="description">
                <p><span>SCORE:</span> <span>1251251</span></p>
                <p><span>TITLE:</span> <span>CAKEHOLDER</span></p>
                <p><span>QUIZ TAKEN:</span> <span>1250</span></p>
            </div>
        </div>
    </div>
    <div class="row last-row">
        <div class="col-12">
            <a href="#" class="btn btn-warning btn-lg">SEE ALL</a>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>