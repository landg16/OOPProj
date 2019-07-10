<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${param.title} - Make Learning Awesome!</title>
    <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="img/favicon.ico" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,600,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar" id="navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp"><img src="img/logo.png" alt="logo"/></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navigation"
                        aria-controls="navigation" aria-expanded="false" aria-label="Toggle Navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navigation">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Quizes</a>
                        </li>

                        <!--

                        THIS SHOULD BE DISPLAYED WHEN ADMIN IS LOGGED IN

                        <li class="nav-item">
                            <a class="nav-link" href="#">Make an announcement</a>
                        </li>
                        -->
                        <li class="nav-item">
                            <a class="nav-link" href="leaderboard.jsp">Leaderboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="about.jsp">About</a>
                        </li>
                        <%--                    <li class="nav-item">--%>
                        <%--                        <a class="nav-link" href="#">Log In</a>--%>
                        <%--                    </li>--%>
                        <%--                    <li class="nav-item">--%>
                        <%--                        <a class="nav-link" href="#">Register</a>--%>
                        <%--                    </li>--%>
                    </ul>
                </div>
            </div>
        </nav>
    </header>