<%@ page import="DataAccess.DatabaseManager" %><%--
  Created by IntelliJ IDEA.
  User: Oniani
  Date: 7/11/2019
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<jsp:include page="header.jsp">
    <jsp:param name="title" value="Announcements"/>
</jsp:include>

<%
    String username = (String)session.getAttribute("username");
    String password = (String)session.getAttribute("password");
    int k = DatabaseManager.checkLogin(username, password);

    if(k==-1){
        response.sendRedirect("index.jsp?error=You are not logged in!");
        return;
    }
%>

<div class="container-fluid heading">
    <h2>Announcements</h2>
</div>
<div class="container form">
    <div class="row buttons">
        <div class="col-sm-4">
            <h2>Announcement#1</h2>
            <p>Date: 23 DICK DAY</p>
            <h6>LASHA YLEA, MAGIS YLEOBA DIZAINIS GAMO ALERTEBI UNDA GAMEKETEBINA ROMELIC DEDAMOTyNULAD MAXINJI
            IQNEBODA, AMITOM ESE IYOS DA YVELA DAKMAYOFILDES.</h6>
        </div>

        <div class="col-sm-4">
            <h2>Announcement#2</h2>
            <p>Date: 23 Dick day</p>
            <h6>(same but in lowercase) lasha ylea, magis yleoba dizainis gamo alertebi unda gameketebina romelic dedamotynulad maxinji
            iqneboda, amitom ese iyos da yvela dakmayofildeba</h6>
        </div>

        <div class="col-sm-4">
            <h2>Announcement#3</h2>
            <p>Date: 23 YlE RiCxVi</p>
            <h6>(same but fuck knows) lAsHa YlEa, MaGiS yLeObA dIzAiNiS gAmO aLeRtEbI uNdA gAmEkEtEbInA rOmElIc DeDaMoTyNuLaD mAxInJi
                IqNeBoDa, AmItOm EsE iYoS dA yVeLa DaKmaYoFiLdEbA</h6>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>