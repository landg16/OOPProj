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
            <h4 class="cat_title">Filter Quizes</h4>
            <% Map<Integer, String> categorys = DatabaseManager.getCategories();
                for (Map.Entry<Integer, String> tmp : categorys.entrySet()) { %>
            <div class="custom-control custom-checkbox mb-3">
                <input type="checkbox" class="custom-control-input filter_category" id="<%=tmp.getValue()%>">
                <label class="custom-control-label" for="<%=tmp.getValue()%>"><%=tmp.getValue()%></label>
            </div>
            <%}%>
        </div>
        <div class="col-sm-9 quiz_prepare">
            <div class="row Quiz_List">
                <%for (Quiz quiz : DatabaseManager.getAllQuizes()) {%>
                <div class="col-md-6 col-lg-4 item <%=quiz.getType()%> filter_box">
                    <div class="img" style="background-image:url(<%=quiz.getImageUrl()%>);"></div>
                    <div class="description">
                        <%=quiz.getTitle()%>
                        <hr>
                        <span class="left"><a href="quiz.jsp?id=<%=quiz.getId()%>">Take Quiz</a></span>
                        <span class="right"><%=quiz.getType()%></span>
                        <div class="clear"></div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
