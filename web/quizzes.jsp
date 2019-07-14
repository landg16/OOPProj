<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.Quiz" %>
<%@ page import="java.util.Map" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz Select"/>
</jsp:include>
<div class="container-fluid heading">
    <h2>Select Desirable Quiz</h2>
</div>
<div class="container">
    <div class="row">
        <div class="col-sm-3 select_categories">

            <% Map<Integer, String> categorys = DatabaseManager.getCategories();
                for (Map.Entry<Integer, String> tmp : categorys.entrySet()) {%>

            <div class="form-check">
                <input id="<%=tmp.getValue()%>" type="checkbox"
                       class="form-check-input filter_category"><%=tmp.getValue()%>
            </div>

            <%}%>

        </div>
        <div class="col-sm-9 quiz_prepare">
            <div class="row Quiz_List">

                <%for (Quiz quiz : DatabaseManager.getAllQuizes()) {%>
                <div class="col-sm-3 item <%=quiz.getType()%> filter_box">
                    <div class="img" style="background-image:url(<%=quiz.getImageUrl()%>);"></div>
                    <div class="description">
                        <span class="left"><%=quiz.getDescription()%></span>
                        <span class="right"><%=quiz.getType()%></span>
                        <div class="clear"></div>
                        <hr>
                        <a href="quiz.jsp?id=<%=quiz.getId()%>">Take Quiz</a>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
