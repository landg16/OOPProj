<jsp:include page="header.jsp">
    <jsp:param name="title" value="Sign Up"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>MAKE AN ANNOUNCEMENT</h2>
</div>

<div class="container">
    <div class="form-group">
        <label for="Title">Announcement title</label>
        <input type="text" class="form-control" name="TiTle" id="Title">
    </div>
    <div class="form-group">
        <label for="Description">Announcement text</label>
        <textarea class="form-control" name="Description" id="Description"></textarea>
    </div>

    <button>Make an announcement</button>
</div>

<jsp:include page="footer.jsp"/>