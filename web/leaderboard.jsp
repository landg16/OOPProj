<%@ page import="DataAccess.DatabaseManager" %>
<%@ page import="Objects.LeaderUsers" %>

<jsp:include page="header.jsp">
    <jsp:param name="title" value="Leaderboard"/>
</jsp:include>
<div class="container leaderboard_page">
    <div class="row">
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-light active">
                <input type="radio" name="period" autocomplete="off" checked required> Today
            </label>
            <label class="btn btn-light">
                <input type="radio" name="period" autocomplete="off"> All Time
            </label>
        </div>
    </div>
    <div class="row">
        <table class="table">
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
            <% int count =0; %>
            <% for (LeaderUsers leaderUsers : DatabaseManager.getLeaderUsers()) { %>
            <tr>
                <% count++; %>
                <th scope="row"><%=count%></th>
                <td><%=leaderUsers.getFirstName() %></td>
                <td><%=leaderUsers.getLastName() %></td>
                <td>@<%=leaderUsers.getScore() %></td>
                <td><%=leaderUsers.getId() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <table class="table">
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
            <% int count1=0; %>
            <% for (LeaderUsers leaderUsers : DatabaseManager.getDailyLeaderUsers()) { %>
            <tr>
                <% count1++; %>
                <th scope="row"><%=count1%></th>
                <td><%=leaderUsers.getFirstName() %></td>
                <td><%=leaderUsers.getLastName() %></td>
                <td>@<%=leaderUsers.getScore() %></td>
                <td><%=leaderUsers.getId() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
<div class="container-fluid heading">
    <h2>LEADERBOARD<br>TOP 100</h2>
</div>
<jsp:include page="footer.jsp"/>