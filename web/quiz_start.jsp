<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.Answer" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="Objects.UserHistory" %>
<%
    //CHECK LOG IN
    String username = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if (k == -1) {
        response.sendRedirect("quizzes.jsp?error=You are not logged in!");
        return;
    }
    //CHECK QUIZ ID
    String quiz_id_str = request.getParameter("id");
    if (quiz_id_str == null) {
        response.sendRedirect("quizzes.jsp?error=Wrong Quiz ID!");
        return;
    }

    int quiz_id = Integer.parseInt(quiz_id_str);
    Quiz quiz = DatabaseManager.getQuiz(quiz_id);
    if (quiz == null) {
        response.sendRedirect("quizzes.jsp?error=Wrong Quiz ID!");
        return;
    }

    int historyId = DatabaseManager.insertHistory(k, quiz_id);
    request.setAttribute("title", quiz.getTitle());

    //Get timer start
    ArrayList<UserHistory> uh = DatabaseManager.getUserHistory(k);
    UserHistory current = null;
    for(UserHistory tmp : uh){
        if(!tmp.getIsEnded() && tmp.getQuizId() == quiz_id) current= tmp;
    }

    long curTime = DatabaseManager.getSQLTime().getTime() - current.getQuizStart();
    //end timer sstart
    boolean isRandom = quiz.isRandom();
    boolean isImmediate = quiz.isImmediateCorrection();
    boolean onePage = quiz.isOnePage();
%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="${title} - Make Learning Awesome"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>Quiz - <%=quiz.getTitle()%>
    </h2>
</div>

<div class="container quiz_start">
    <div class="row quiz_details">
        <div class="col-md-4 text-md-right">
            Immediate Correction: <% if (isImmediate) out.println("Yes");
        else out.println("No"); %>
        </div>
        <div class="col-md-4 text-md-center">
            Random Order: <% if (isRandom) out.println("Yes");
        else out.println("No"); %>
        </div>
        <div class="col-md-4 text-md-left" id="timer">
            <div id="timestart" style="display:none;"><%=curTime%></div>
            Time Count: <span id="minutes">00</span>:<span id="seconds">00</span>
        </div>
    </div>
    <div class="row justify-content-around">
        <div class="col-md-8">
            <form action="CompleteQuiz" method="post">
                <input type="hidden" value="<%=historyId%>" name="historyId">
                <input type="hidden" value="<%=quiz_id%>" name="quiz_id">
                <%
                    ArrayList<Question> questions = DatabaseManager.getQuestions(quiz_id, isRandom);
                    int i = 0;
                    for (Question tmp : questions) {
                        i++;
                        ArrayList<Answer> answers = DatabaseManager.getAnswers(tmp.getId());
                        if (tmp.getType().equals("qr")) { %>
                <div class="row question_block">
                    <div class="col-auto">
                        <h3 class="text-right"><b>Question #<%=i%>:</b></h3>
                        <h3 class="text-right diff"><b>Answer #<%=i%>: </b></h3>
                    </div>
                    <div class="col-auto">
                        <h3><%=tmp.getQuestion()%>
                        </h3>
                        <input type="text" name="answer<%=tmp.getId()%>" class="form-control diff"
                               placeholder="Please insert your answer here">
                    </div>
                </div>
                <hr>
                <%
                } else if (tmp.getType().equals("fitb")) { %>
                <div class="row question_block">
                    <div class="col-auto">
                        <h3 class="text-right"><b>Before Gap #<%=i%>:</b></h3>
                        <h3 class="text-right diff"><b>Gap #<%=i%>: </b></h3>
                        <h3 class="text-right diff"><b>After Gap #<%=i%>: </b></h3>
                    </div>
                    <div class="col-auto">
                        <h3><%=tmp.getQuestion()%>
                        </h3>
                        <input type="text" name="answer<%=tmp.getId()%>" class="form-control diff"
                               placeholder="Please insert your answer here">
                        <h3 class="diff1"><%=tmp.getSecondPart()%>
                        </h3>
                    </div>
                </div>
                <hr>
                <% } else if (tmp.getType().equals("prq")) { %>
                <div class="row question_block">
                    <div class="col-auto">
                        <h3 class="text-right"><b>Question #<%=i%>:</b></h3>
                        <h3 class="text-right diff"><b>Answer #<%=i%>: </b></h3>
                    </div>
                    <div class="col-auto">
                        <h3><img src="<%=tmp.getQuestion()%>" class="img-fluid"/></h3>
                        <input type="text" name="answer<%=tmp.getId()%>" class="form-control diff"
                               placeholder="Please insert your answer here">
                    </div>
                </div>
                <hr>
                <% } else if (tmp.getType().equals("mc")) { %>
                <div class="row question_block">
                    <div class="col-sm-4">
                        <h3 class="text-right"><b>Question #<%=i%>:</b></h3>
                        <h3 class="text-right diff"><b>Answers #<%=i%>: </b></h3>
                    </div>
                    <div class="col-sm-8">
                        <h3><%=tmp.getQuestion()%>
                        </h3>
                        <div class="row mc">
                            <%
                                int j = 0;
                                for (Answer ans : answers) {
                                    j++; %>
                            <div class="col-md-6">
                                <div class="input-style">
                                    <div class="custom-control custom-radio">
                                        <input type="radio" id="answer<%=j%><%=tmp.getId()%>" name="answer<%=tmp.getId()%>"
                                               class="custom-control-input" value="<%=ans.getAnswer()%>">
                                        <label class="custom-control-label" for="answer<%=j%><%=tmp.getId()%>"><%=ans.getAnswer()%></label>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
                <hr>
                <% }
                }
                %>
                <div class="row">
                    <div class="col-sm-4 text-sm-left">
                        <button type="button" class="btn btn-primary">Previous Question</button>
                    </div>
                    <div class="col-sm-4 text-sm-center">
                        <button type="submit" class="btn btn-success">Submit</button>
                    </div>
                    <div class="col-sm-4 text-sm-right">
                        <button type="button" class="btn btn-primary">Next Question</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>