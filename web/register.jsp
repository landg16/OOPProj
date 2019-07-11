<jsp:include page="header.jsp">
    <jsp:param name="title" value="Sign Up"/>
</jsp:include>
<div class="container-fluid heading">
    <h2>REGISTRATION PAGE</h2>
</div>
<div class="container form">
    <div class="row justify-content-around">
        <div class="col-md-8">
            <form id="registrationForm" class="centered" action="${pageContext.request.contextPath}/Register" method="post">
                <div class="mainForm">
                    <div style="color: #ff0000;">${error}</div>
                    <div class="form-group">
                        <label for="firstName" class="form-group">First Name: (*)</label>
                        <input id="firstName" class="form-control" type="text" name="firstName" required>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="label">Last Name: (*)</label>
                        <input id="lastName" class="form-control" type="text" name="lastName" required>
                    </div>
                    <div class="form-group">
                        <label for="userName" class="form-group">User Name: (*)</label>
                        <input id="userName" class="form-control" type="text" name="userName" required>
                    </div>
                    <div class="form-group">
                        <label for="email" class="form-group">Email: (*)</label>
                        <input id="email" class="form-control" type="text" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password" class="form-group">Password: (*)</label>
                        <input id="password" class="form-control" type="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="repeatPassword" class="form-group">Repeat Password: (*)</label>
                        <input id="repeatPassword" class="form-control" type="password" name="repeatPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="image" class="form-group">Image URL:</label>
                        <input id="image" class="form-control" type="text" name="image" placeholder="Default Avatar">
                    </div>
                    <small>* is a required field.</small><br><br>
                    <div class="form-group">
                        <input type="submit" value="Create an account" class="btn btn-warning">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
