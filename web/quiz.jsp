<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.User" %>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Add Quiz"/>
</jsp:include>
    <div class="container">
        <div class="col-md-12 quiz_summary">
            <form id="quizSummaryForm" method="post">
                <div class="head_info"
                    <%
                        int quizId = Integer.parseInt(request.getParameter("id"));
                        Quiz quiz = DatabaseManager.getQuiz(quizId);
                        User user = DatabaseManager.getUser(quiz.getQuizOwnerId());
                    %>
                    <div class="owner_name">
                        <h5>Quiz Made By <a href="#"><%=user.getNickName()%></a></h5>
                        <h6>(Type: <%=quiz.getQuizType()%>)</h6>
                    </div>
                    <div class="description">
                        <div class="description_text">Description: <%=quiz.getQuizDescription()%></div>
                        <div class="col-sm-3 img" style="background-image:url(<%=quiz.getQuizImage()%>);"></div>
                    </div>
                    <div class="statistics">
                        <div id="user_results" class="col-sm-4">
                            <div class="form-group">
                                <label for="type">Sort Your Results By</label>
                                <div class="row">
                                    <select name="type" id="type" class="form-control">
                                        <option value="date">Date</option>
                                        <option value="score">Score</option>
                                        <option value="time">Time</option>
                                    </select>
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Score</th>
                                            <th scope="col">Date</th>
                                            <th scope="col">Time</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>1</td>
                                            <td>1</td>
                                            <td>1</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
<jsp:include page="footer.jsp"/>

