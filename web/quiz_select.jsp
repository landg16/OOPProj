<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz Select"/>
</jsp:include>
<div class="container-fluid heading">
    <h2>Select Desirable Quiz</h2>
</div>
<div class="container">
    <div class="row justify-content-around">
        <div class="col-md-12 quiz_prepare">
            <div class="Quiz_List">
                <div class="row">
                    <%for (Quiz quiz : DatabaseManager.getQuizes()) {%>
                    <div class="col-sm-3 item">
                        <div class="img" style="background-image:url(<%=quiz.getQuizImage()%>);"></div>
                        <div class="description">
                            <span class="left"><%=quiz.getQuizDescription()%></span>
                            <span class="right"><%=quiz.getQuizType()%></span>
                            <div class="clear"></div>
                            <hr>
                            <a href="quiz.jsp?id=<%=quiz.getQuizId()%>">Take Quiz</a>
                        </div>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
