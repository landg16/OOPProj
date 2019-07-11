<%@ page import="DataAccess.DatabaseManager" %>
<%
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    if(!DatabaseManager.checkLogin(username, password)){
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
            <form method="post">
                <div class="form-group">
                    <label for="title">Quiz Title</label>
                    <input type="text" class="form-control" name="title" id="title">
                </div>
                <div class="form-group">
                    <label for="description">Quiz Description</label>
                    <textarea class="form-control" name="description" id="description"></textarea>
                </div>
                <div class="form-group">
                    <label for="image">Quiz Image</label>
                    <textarea class="form-control" name="image" id="image"></textarea>
                </div>
                <hr>
                <div class="row two_column">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Randomize question order</label>
                            <br>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-warning active">
                                    <input type="radio" name="randomize" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="randomize" autocomplete="off"> NO
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
                                    <input type="radio" name="one_page" autocomplete="off" checked required> One
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="one_page" autocomplete="off"> Multiple
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
                                    <input type="radio" name="immediate" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="immediate" autocomplete="off"> NO
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
                                    <input type="radio" name="practice" autocomplete="off" checked required> YES
                                </label>
                                <label class="btn btn-warning">
                                    <input type="radio" name="practice" autocomplete="off"> NO
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
                <!--- QR TYPE --->
<%--                <div class="form-group">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-md-5">--%>
<%--                            <label>Question #1</label>--%>
<%--                            <input type="text" class="form-control" name="question1" id="question1" placeholder="Ask Your Question">--%>
<%--                        </div>--%>
<%--                        <div class="col-md-5">--%>
<%--                            <label>Answer #1</label>--%>
<%--                            <input type="text" class="form-control" name="answer1" id="answer1" placeholder="Answer Your Question">--%>
<%--                        </div>--%>
<%--                        <div class="col-md-2 d-flex flex-column">--%>
<%--                            <button type="button" id="removeQuestion1" class="btn btn-danger w-100 mt-auto">Remove</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <!--- END QR TYPE --->--%>
<%--                <hr>--%>
<%--                <!--- FITB TYPE --->--%>
<%--                <div class="form-group">--%>
<%--                    <label>Text before the Gap #2</label>--%>
<%--                    <input type="text" class="form-control" name="before_gap1" id="beforeGap1">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label>The Gap #2</label>--%>
<%--                    <input type="text" class="form-control" name="gap" id="gap">--%>
<%--                </div>--%>
<%--                <div class="form-group">--%>
<%--                    <label>Text After the Gap #2</label>--%>
<%--                    <input type="text" class="form-control" name="after_gap1" id="afterGap1">--%>
<%--                </div>--%>
<%--                <button type="button" id="removeQuestion2" class="btn btn-danger">Remove</button>--%>
<%--                <!--- END FITB TYPE --->--%>
<%--                <hr>--%>
<%--                <!--- MC TYPE --->--%>
<%--                <div class="form-group">--%>
<%--                    <div class="row"><input type="hidden" value="2" id="question3AnswerCount" name="question3_answers">--%>
<%--                        <div class="col-md-6">--%>
<%--                            <label>Question #3</label>--%>
<%--                            <input type="text" class="form-control" name="question3" id="question3">--%>
<%--                        </div>--%>
<%--                        <div class="col-md-3 d-flex flex-column">--%>
<%--                            <button type="button" id="addChoice3" class="btn btn-success w-100 mt-auto">Add Choice</button>--%>
<%--                        </div>--%>
<%--                        <div class="col-md-3 d-flex flex-column">--%>
<%--                            <button type="button" id="removeQuestion3" class="btn btn-danger w-100 mt-auto">Remove</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- ANSWER -->--%>
<%--                    <div class="row" id="question3_answer1">--%>
<%--                        <div class="col-md-9">--%>
<%--                            <label>Answer #1</label>--%>
<%--                            <div class="input-group">--%>
<%--                                <div class="input-group-prepend">--%>
<%--                                    <div class="input-group-text">--%>
<%--                                        <input type="radio" name="question3_answer1" aria-label="Correct Answer" checked>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <input type="text" class="form-control" aria-label="Answer box for question">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- END ANSWER -->--%>
<%--                    <!-- ANSWER -->--%>
<%--                    <div class="row" id="question3_answer2">--%>
<%--                        <div class="col-md-9">--%>
<%--                            <label>Answer #2</label>--%>
<%--                            <div class="input-group">--%>
<%--                                <div class="input-group-prepend">--%>
<%--                                    <div class="input-group-text">--%>
<%--                                        <input type="radio" name="question3_answer2" aria-label="Correct Answer">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <input type="text" class="form-control" aria-label="Answer box for question">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- END ANSWER -->--%>
<%--                    <!-- ANSWER -->--%>
<%--                    <div class="row" id="question3_answer">--%>
<%--                        <div class="col-md-9">--%>
<%--                            <label>Answer #3</label>--%>
<%--                            <div class="input-group">--%>
<%--                                <div class="input-group-prepend">--%>
<%--                                    <div class="input-group-text">--%>
<%--                                        <input type="radio" name="question3_answer3" aria-label="Correct Answer">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <input type="text" class="form-control" aria-label="Answer box for question">--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="col-md-3 d-flex flex-column">--%>
<%--                            <button type="button" data-question-number="3" data-answer-number="3" class="btn btn-danger w-100 mt-auto removeMC">Remove</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- END ANSWER -->--%>
<%--                </div>--%>
<%--                <!--- END MC TYPE --->--%>
<%--                <hr>--%>
<%--                <!--- QR TYPE --->--%>
<%--                <div class="form-group">--%>
<%--                    <div class="row">--%>
<%--                        <div class="col-md-5">--%>
<%--                            <label>Question #4</label>--%>
<%--                            <input type="text" class="form-control" name="question1" id="question4" placeholder="Provide Image URL">--%>
<%--                        </div>--%>
<%--                        <div class="col-md-5">--%>
<%--                            <label>Answer #4</label>--%>
<%--                            <input type="text" class="form-control" name="answer1" id="answer4" placeholder="Answer Your Question">--%>
<%--                        </div>--%>
<%--                        <div class="col-md-2 d-flex flex-column">--%>
<%--                            <button type="button" id="removeQuestion4" class="btn btn-danger w-100 mt-auto">Remove</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <!--- END QR TYPE --->--%>
<%--                <hr>--%>
                <button type="submit" class="btn btn-primary btn-lg">Add Quiz</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>