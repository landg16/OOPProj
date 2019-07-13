<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.User" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Friends"/>
</jsp:include>

<%
    String id = request.getParameter("id");
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("index.jsp?error=You are not logged in!");
        return;
    }
%>

<div class="container-fluid heading">
    <h2>Friends</h2>
</div>

<%
    int userId;
    userId = DatabaseManager.checkLogin(username, password);
    User user = DatabaseManager.getUser(userId);
%>

<form class="row">
    <div class="col-sm-10">
        <input class="form-control" type="text" placeholder="Type here">
    </div>
    <div class="col-sm-2">
        <button type="submit"><p>Search</p></button>
    </div>
</form>

<div class="container user-margin">
    <div class="row justify-content-around">
        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>



        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>



        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>
    </div>


    <div class="row justify-content-around">
        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>



        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>



        <div class="col-sm-4">
            <div class="personal">
                <div class="square" style="background-image: url('https://scontent.ftbs5-1.fna.fbcdn.net/v/t1.0-9/66132146_2136193703157888_3685640234176872448_n.jpg?_nc_cat=104&_nc_oc=AQnR61l1CnK1367Q-5KlSVJb9r44pdM5vOf2EEH2mnBSQHgZtdaHifTiskDtKq-JJ8w&_nc_ht=scontent.ftbs5-1.fna&oh=0f1f070e4e883ed79b0afc78b2bf072f&oe=5DB8B875')"></div>
                <h2>Nick Oniani</h2>
                <h6>CEO & CO-FOUNDER @UNLEASH AR</h6>
                <h6>Free University of Georgia</h6>
                <p>10 quizzes</p>
                <p><button class="btn btn-dark w-100 button-class">View</button></p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp"/>
