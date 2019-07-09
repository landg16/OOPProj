<jsp:include page="header.jsp">
    <jsp:param name="title" value="Leaderboard"/>
</jsp:include>
<div class="container-fluid heading">
    <h2>LEADERBOARD<br>TOP 100</h2>
</div>
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
            <tr>
                <th scope="row">1</th>
                <td>Mark</td>
                <td>Otto</td>
                <td>@mdo</td>
                <td>20</td>
            </tr>
            <tr>
                <th scope="row">2</th>
                <td>Jacob</td>
                <td>Thornton</td>
                <td>@fat</td>
                <td>20</td>
            </tr>
            <tr>
                <th scope="row">3</th>
                <td>Larry</td>
                <td>the Bird</td>
                <td>@twitter</td>
                <td>20</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<jsp:include page="footer.jsp"/>