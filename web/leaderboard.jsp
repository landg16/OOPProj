<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.User" %>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Leaderboard"/>
</jsp:include>
<div class="container-fluid heading">
    <h2>LEADERBOARD<br>TOP 100</h2>
</div>
<div class="container leaderboard_page">
    <div class="row">
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-light active" id="today_button">
                <input type="radio" name="period" autocomplete="off" checked required> Today
            </label>
            <label class="btn btn-light" id="allTime_button">
                <input type="radio" name="period" autocomplete="off"> All
                Time
            </label>
        </div>
    </div>
    <div class="row">
        <table class="table" id="today_leaderboard">
            <thead class="thead-dark">
            <tr>
                <th scope="col">#</th>
                <th scope="col">First Name</th>
                <th scope="col">Last Name</th>
                <th scope="col">User</th>
                <th scope="col">Score</th>
            </tr>
            </thead>
            <tbody>
            <% int count = 0; %>
            <% for (User leaderUsers : DatabaseManager.getLeaderUsers()) { %>
            <tr>
                <% count++; %>
                <th scope="row"><%=count%>
                </th>
                <td><%=leaderUsers.getFirstname() %>
                </td>
                <td><%=leaderUsers.getLastname() %>
                </td>
                <td>@<%=DatabaseManager.getScore(leaderUsers.getId()) %>
                </td>
                <td><%=leaderUsers.getId() %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <table class="table" id="allTime_leaderboard">
            <thead class="thead-dark">
            <tr>
                <th scope="col">#</th>
                <th scope="col">First Name</th>
                <th scope="col">Last Name</th>
                <th scope="col">User</th>
                <th scope="col">Score</th>
            </tr>
            </thead>
            <tbody>
            <% int count1 = 0; %>
            <% for (User user : DatabaseManager.getDailyLeaderUsers()) { %>
            <tr>
                <% count1++; %>
                <th scope="row"><%=count1%>
                </th>
                <td><%=user.getFirstname() %>
                </td>
                <td><%=user.getLastname() %>
                </td>
                <td>@<%=DatabaseManager.getScore(user.getId()) %>
                </td>
                <td><%=user.getId() %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp"/>