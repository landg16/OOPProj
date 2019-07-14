<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="Objects.Question" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Objects.Answer" %>
<%
    //CHECK LOG IN
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("quizzes.jsp?error=You are not logged in!");
        return;
    }
    //CHECK QUIZ ID
    String quiz_id_str = request.getParameter("id");
    if(quiz_id_str == null){
        response.sendRedirect("quizzes.jsp?error=Wrong Quiz ID!");
        return;
    }

    int quiz_id = Integer.parseInt(quiz_id_str);
    Quiz quiz = DatabaseManager.getQuiz(quiz_id);
    if(quiz == null){
        response.sendRedirect("quizzes.jsp?error=Wrong Quiz ID!");
        return;
    }

    request.setAttribute("title", quiz.getTitle());
    boolean isRandom = quiz.isRandom();
    boolean isImmediate = quiz.isImmediateCorrection();
    boolean onePage = quiz.isOnePage();
    boolean isPractice = quiz.isPracticeMode();
%>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="${title} - Make Learning Awesome"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>Quiz - <%=quiz.getTitle()%></h2>
</div>

<div class="container">
    <div class="row justify-content-around">
        <div class="col-md-8">
            <%
                ArrayList<Question> questions = DatabaseManager.getQuestions(quiz_id, isRandom);
                for (Question tmp : questions) {
                    ArrayList<Answer> answers = DatabaseManager.getAnswers(tmp.getId());
                    if (tmp.getType().equals("qr")){ %>
                        <div class="question-block">
                            <h3><%=tmp.getQuestion()%></h3>
                            <input type="text" class="form-control">
                        </div>
                    <%
                    } else if(tmp.getType().equals("fitb")) { %>
                        <div class="question-block">
                            <h4><%=tmp.getQuestion()%></h4>
                            <input type="text" class="form-control">
                            <h4><%=tmp.getSecondPart()%></h4>
                        </div>
                    <% } else if(tmp.getType().equals("prq")) { %>
                        <div class="question-block">
                            <img src="<%=tmp.getQuestion()%>" class="img-fluid">
                            <input type="text" class="form-control">
                        </div>
                    <% } else if(tmp.getType().equals("mc")) { %>
                        <div class="question-block">
                            <h3><%=tmp.getQuestion()%></h3>
                            <% for(Answer ans : answers){ %>
                                <input type="checkbox"> <%=ans.getAnswer()%>
                            <% } %>
                        </div>
                    <% }
                }
            %>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>