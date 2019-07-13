        <footer class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 copyright">
                        All Rights Reserved &copy; <a href="index.jsp">QuizCake</a>
                    </div>
                    <div class="col-md-6 socials ml-auto">
                        <a href ="https://www.facebook.com/unleashhar/" target="_blank"> <img src="img/socials/fb.png" alt="Facebook" /> </a>
                        <a href ="https://www.youtube.com/channel/UC88LEeTss6I-FO9WF7vayIw" target="_blank" > <img src="img/socials/youtube.png" alt="YouTube"/> </a>
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
                        <form action="${pageContext.request.contextPath}/Login" method="post">
                            <div class="form-group">
                                <label for="user">Username:</label>
                                <input type="text" name="username" id="user" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="pass">Password:</label>
                                <input type="password" name="password" id="pass" class="form-control"/>
                            </div>
                            <button type="submit" class="btn btn-warning">Log In</button>
                            <a onclick="showForgotModal();"
                               class="forgot right">Forgot Password?</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Forgot password pop-up -->

        <div class="modal login" tabindex="-1" role="dialog" id="forgotPassword">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Forgot password</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/forgotpassword" method="post">
                            <div class="form-group">
                                <label for="user">Your e-mail address</label>
                                <input type="text" name="email" id="email" class="form-control"/>
                            </div>
                            <div class="form-group">
                                <label for="pass">Username</label>
                                <input type="password" name="uzername" id="uzername" class="form-control"/>
                            </div>
                            <button type="submit" class="btn btn-warning">Request Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <% if(request.getParameterMap().containsKey("error")) { %>
        <!-- ERROR MODAL -->
        <div class="modal fade" id="error" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="error-container">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="text-center">ERROR</h3>
                    <h4 class="text-center"><%=request.getParameter("error")%></h4>
                </div>
            </div>
        </div>
        <script>
            window.onload = function() {
                $('#error').modal('show');
            };
        </script>
        <!-- END ERROR MODAL -->
        <% } %>

        <% if(request.getParameterMap().containsKey("success")) { %>
        <!-- SUCCESS MODAL -->
        <div class="modal fade" id="success" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="error-container">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h3 class="text-center">SUCCESS</h3>
                    <h4 class="text-center"><%=request.getParameter("success")%></h4>
                </div>
            </div>
        </div>
        <script>
            window.onload = function() {
                $('#success').modal('show');
            };
        </script>
        <!-- END SUCCESS MODAL -->
        <% } %>

        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="js/jquery.tablesorter.min.js"></script>
        <script type="text/javascript" src="js/jquery.tablesorter.pager.js"></script>
        <script type="text/javascript" src="js/popper.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/custom.js"></script>
    </body>
</html>