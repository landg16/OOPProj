<%@ page import="Objects.Quiz" %>
<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.User" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>Result</h2>
</div>

<div class="container">
    <% Quiz quiz = DatabaseManager.getQuiz(Integer.parseInt(request.getParameter("quizID"))); %>
    <% User creator = DatabaseManager.getUser(quiz.getQuizOwnerId());%>
    <div class="row justify-content-around">
        <div class="col-md-5">
            <div class="summary_table1">
                <img src="<%=quiz.getImageUrl()%>" class="img-fluid">
                <div class="quiz_info">
                    <p>Quiz Name: <%=quiz.getTitle()%>
                    </p>
                    <hr>
                    <p>Category: <%=quiz.getType()%>
                    </p>
                    <p>Created by: <a href="profile.jsp?id=<%=creator.getId()%>"><%=creator.getUsername() %>
                    </a></p>
                </div>
            </div>
        </div>

        <div class="col-md-7">
            <div class="row justify-content-around">
                <div class="col-md-6">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">CORRECT ANSWERS</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <p class="quiz_summary_names">OUT OF <%=request.getParameter("quizSize")%>
                            </p>
                            <p class="correct_answers_text"><%=request.getParameter("correctAnswers")%>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-around">
                <div class="col-md-6">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">SCORE</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <div class="score_time_text"><%=request.getParameter("score")%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-around">
                <div class="col-md-6">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">TIME</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <div class="score_time_text"><%=request.getParameter("time")%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>