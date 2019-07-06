        <footer class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 copyright">
                        All Rights Reserved &copy; <a href="index.jsp">QuizCake</a>
                    </div>
                    <div class="col-md-6 socials ml-auto">
                        <img src="img/socials/fb.png" />
                        <img src="img/socials/twitter.png" />
                        <img src="img/socials/youtube.png" />
                        <img src="img/socials/instagram.png" />
                    </div>
                </div>
            </div>
        </footer>

        <div class="modal login" tabindex="-1" role="dialog" id="logIn">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Log In</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="Login" method="post">
                            <div class="form-group">
                                <label for="user">Username:</label>
                                <input type="text" name="username" id="user" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="pass">Password:</label>
                                <input type="password" name="password" id="pass" class="form-control"/>
                            </div>
                            <button type="submit" class="btn btn-warning">Log In</button>
                            <a href="forgot_password.jsp" class="forgot right">Forgot Password?</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="js/popper.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/custom.js"></script>
    </body>
</html>