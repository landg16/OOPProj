<jsp:include page="header.jsp">
    <jsp:param name="title" value="Quiz"/>
</jsp:include>

<div class="container-fluid heading">
    <h2>Result</h2>
</div>

<div class="container">
    <div class="row justify-content-around">
        <div class="col-md-4">
            <div class="summary_table1">
                <div class=""></div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="row justify-content-around">
                <div class="col-md-4">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">CORRECT ANSWERS</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <p class="quiz_summary_names">OUT OF 10</p>
                            <p class="correct_answers_text">8</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-around">
                <div class="col-md-4">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">SCORE</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <div class="score_time_text">17</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row justify-content-around">
                <div class="col-md-4">
                    <div class="summary_table3">
                        <div class="quiz_score">
                            <div class="correct_answers_text">
                                <p class="statistic_names">TIME</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="summary_table2">
                        <div class="quiz_score">
                            <div class="score_time_text">10:23</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>