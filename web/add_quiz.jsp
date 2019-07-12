<%@ page import="DataAccess.DatabaseManager" %>
<%
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("index.jsp?error=You are not logged in!");
        return;
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Add Quiz"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>ADD QUIZ</h2>
</div>
<div class="container">
    <div class="row justify-content-around">
        <div class="col-md-9 quiz_form">
            <form method="post" action="AddQuiz">
                <div class="form-group">
                    <label for="title">Quiz Title</label>
                    <input type="text" class="form-control" name="title" id="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Quiz Description</label>
                    <textarea class="form-control" name="description" id="description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Quiz Image</label>
                    <input type="text" class="form-control" name="image" id="image" required/>
                </div>
                <hr>
                <div class="row two_column">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Randomize question order</label>
                            <br>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning active">
                                    <input type="radio" name="randomize" value="true" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="randomize" value="false" autocomplete="off"> NO
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 right_align">
                        <div class="form-group">
                            <label>One or Multiple Page</label>
                            <br>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning active">
                                    <input type="radio" name="one_page" value="true" autocomplete="off" checked required> One
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="one_page" value="false" autocomplete="off"> Multiple
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row two_column">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Immediate Correction</label>
                            <br>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning active">
                                    <input type="radio" name="immediate" value="true" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="immediate" value="false" autocomplete="off"> NO
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 right_align">
                        <div class="form-group">
                            <label>Practice Mode</label>
                            <br>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning active">
                                    <input type="radio" name="practice" value="true" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="practice" value="false" autocomplete="off"> NO
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                <h4>Questions:</h4>
                <input type="hidden" name="question_count" id="count" value="0">
                <div class="form-group">
                    <label for="type">Add Question</label>
                    <div class="row">
                        <div class="col-md-9">
                            <select name="type" id="type" class="form-control">
                                <option value="qr">Question-Response</option>
                                <option value="fitb">Fill in the Blank</option>
                                <option value="mc">Multiple Choice</option>
                                <option value="prq">Picture-Response Questions</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <button type="button" id="addQuestion" class="btn btn-warning w-100">Add Question</button>
                        </div>
                    </div>
                </div>
                <hr>
                <div id="questions">
                </div>
                <button type="submit" class="btn btn-primary btn-lg">Add Quiz</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>