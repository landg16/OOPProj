<jsp:include page="header.jsp">
    <jsp:param name="title" value="Home"/>
</jsp:include>

    <div class="container-fluid heading">
        <h2>ADD QUIZ</h2>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <form method="post">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" id="title">
                    </div>
                    <div class="form-group">
                        <label for="title">Quiz Type</label>
                        <select name="type">
                            <option value="qr">Question-Response</option>
                            <option value="fitb">Fill in the Blank</option>
                            <option value="mc">Multiple Choice</option>
                            <option>Picture-Response Questions</option>
                            <option>Multi-Answer Questions</option>
                            <option>Multiple Choice with Multiple Answers</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" id="title">
                    </div>
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" id="title">
                    </div>
                </form>
            </div>
        </div>
    </div>

<jsp:include page="footer.jsp"/>