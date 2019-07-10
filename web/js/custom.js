window.onscroll = function () {
    menuOnScroll();
    counterUp()
};

// $(window).scroll(counterUp());

$(document).ready(function () {
    registrationValidation();
    addQuestion();
});

function removeQuestion () {
    $(".removeQuestion").off("click");
    $(".removeQuestion").on('click', function () {
        var which = parseInt($(this).data("remove")); //2
        var counter = parseInt($("#count").val()); //3
        $("#toRemove"+which).remove();
        for(var i = which; i<counter; i++){
            var selector = $("#toRemove"+(i+1));
            var toChange =  selector.html();
            var regex = new RegExp((i+1), "g");
            toChange = toChange.replace(regex, i);
            selector.html(toChange);
            selector.attr("id", "toRemove"+i);
            removeQuestion();
        }
        $("#count").val(counter-1);
    });
}

function addQuestion() {
    $("#addQuestion").click(function () {
        var type = $("#type").val();
        var count = parseInt($("#count").val());
        count++;
        var html;
        if (type === "qr") {
            html = '<!--- QR TYPE --->\n' +
                '                <div class="form-group" id="toRemove' + count + '">\n' +
                '                    <input type="hidden" name="type' + count + '" id="type' + count + '" value="' + type + '"> \n' +
                '                    <div class="row">\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Question #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '" placeholder="Ask Your Question">\n' +
                '                        </div>\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Answer #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="answer' + count + '" id="answer' + count + '" placeholder="Answer Your Question">\n' +
                '                        </div>\n' +
                '                        <div class="col-md-two d-flex flex-column">\n' +
                '                            <button type="button" data-remove="' + count + '" class="btn btn-danger w-100 mt-auto removeQuestion">Remove</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                <hr></div>\n' +
                '                <!--- END QR TYPE --->\n';
        } else if (type === "fitb") {
            html = '<div id="toRemove' + count + '">' +
                '            <input type="hidden" name="type' + count + '" id="type' + count + '" value="' + type + '"> \n' +
                '               <div class="form-group">\n' +
                '                    <label>Text before the Gap #' + count + '</label>\n' +
                '                    <input type="text" class="form-control" name="before_gap' + count + '" id="beforeGap' + count + '">\n' +
                '                </div>\n' +
                '                <div class="form-group">\n' +
                '                    <label>The Gap #' + count + '</label>\n' +
                '                    <input type="text" class="form-control" name="gap' + count + '" id="gap' + count + '">\n' +
                '                </div>\n' +
                '                <div class="form-group">\n' +
                '                    <label>Text After the Gap #' + count + '</label>\n' +
                '                    <input type="text" class="form-control" name="after_gap' + count + '" id="afterGap' + count + '">\n' +
                '                </div>\n' +
                '                <button type="button" data-remove="' + count + '" class="btn btn-danger w-100 mt-auto removeQuestion">Remove</button>' +
                '<hr></div>\n' +
                '                <!--- END FITB TYPE --->\n';
        } else if (type === "prq") {
            html = '<!--- PQR TYPE --->\n' +
                '                <div class="form-group" id="toRemove' + count + '">\n' +
                '                    <div class="row">\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Question #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '" placeholder="Provide Image URL">\n' +
                '                        </div>\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Answer #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="answer' + count + '" id="answer' + count + '" placeholder="Answer Your Question">\n' +
                '                        </div>\n' +
                '                        <div class="col-md-two d-flex flex-column">\n' +
                '                            <button type="button" data-remove="' + count + '" class="btn btn-danger w-100 mt-auto removeQuestion">Remove</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                <hr></div>\n' +
                '                <!--- END PQR TYPE --->';
        } else if (type === "mc") {
            html = '<!--- MC TYPE --->\n' +
                '                <div class="form-group" id="toRemove' + count + '">\n' +
                '                    <div class="row">\n' +
                '                       <input type="hidden" value="2" id="question' + count + 'AnswerCount" name="question' + count + '_answers">' +
                '                        <div class="col-md-six">\n' +
                '                            <label>Question #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '">\n' +
                '                        </div>\n' +
                '                        <div class="col-md-three d-flex flex-column">\n' +
                '                            <button type="button" id="addChoice' + count + '" data-choice="' + count + '" class="btn btn-success w-100 mt-auto addChoice">Add Choice</button>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-three d-flex flex-column">\n' +
                '                            <button type="button" data-remove="' + count + '" class="btn btn-danger w-100 mt-auto removeQuestion">Remove</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- ANSWER -->\n' +
                '<div id="answers' + count + '">' +
                '                    <div class="row" id="question' + count + '_answer1">\n' +
                '                        <div class="col-md-nine">\n' +
                '                            <label>Answer #1</label>\n' +
                '                            <div class="input-group">\n' +
                '                                <div class="input-group-prepend">\n' +
                '                                    <div class="input-group-text">\n' +
                '                                        <input type="radio" name="question' + count + '_answer1" aria-label="Correct Answer" checked>\n' +
                '                                    </div>\n' +
                '                                </div>\n' +
                '                                <input type="text" class="form-control" aria-label="Answer box for question">\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- END ANSWER -->\n' +
                '                    <!-- ANSWER -->\n' +
                '                    <div class="row" id="question' + count + '_answer2">\n' +
                '                        <div class="col-md-nine">\n' +
                '                            <label>Answer #2</label>\n' +
                '                            <div class="input-group">\n' +
                '                                <div class="input-group-prepend">\n' +
                '                                    <div class="input-group-text">\n' +
                '                                        <input type="radio" name="question' + count + '_answer2" aria-label="Correct Answer">\n' +
                '                                    </div>\n' +
                '                                </div>\n' +
                '                                <input type="text" class="form-control" aria-label="Answer box for question">\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- END ANSWER -->\n' +
                '                  </div><hr>' +
                '                </div>\n' +
                '                <!--- END MC TYPE --->\n';
        }
        $("#questions").append(html);
        if (type === "mc") {
            $('#addChoice' + count).click(function () {
                var question_count = $('#question' + count + 'AnswerCount').val();
                question_count++;
                $('#question' + count + 'AnswerCount').val(question_count);
                var gtml = '<!-- ANSWER -->\n' +
                    '                    <div class="row" id="question' + count + '_answer">\n' +
                    '                        <div class="col-md-nine">\n' +
                    '                            <label>Answer #' + question_count + '</label>\n' +
                    '                            <div class="input-group">\n' +
                    '                                <div class="input-group-prepend">\n' +
                    '                                    <div class="input-group-text">\n' +
                    '                                        <input type="radio" name="question' + count + '_answer' + question_count + '" aria-label="Correct Answer">\n' +
                    '                                    </div>\n' +
                    '                                </div>\n' +
                    '                                <input type="text" class="form-control" aria-label="Answer box for question">\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="col-md-three d-flex flex-column">\n' +
                    '                            <button type="button" data-question-number="' + count + '" data-answer-number="' + question_count + '" class="btn btn-danger w-100 mt-auto removeMC">Remove</button>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <!-- END ANSWER -->';
                $("#answers" + count).append(gtml);
            });
        }
        $("#count").val(count);
        removeQuestion();
    });
}

function menuOnScroll() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        document.getElementById("navbar").classList.add("scroll");
    } else {
        document.getElementById("navbar").classList.remove("scroll");
    }
}

function registrationValidation() {
    $("#registrationForm").validate({
        rules: {
            password: {
                required: true,
                minlength: 6,
                maxlength: 50
            },
            repeatPassword: {
                equalTo: "#password"
            },
            email: {
                required: true,
                email: true
            },
            firstName: "required",
            lastName: "required",
            userName: "required"
        },
        message: {
            firstName: "<p class='error'>Please enter your first name</p>",
            lastName: "<p class='error'>Please enter your last name</p>",
            userName: "<p class='error'>Please enter your user name</p>",
            email: "<p class='error'>Please enter your email</p>",
            password: "<p class='error'>Password must contain at least 8 characters</p>",
            repeatPassword: "<p class='error'>Passwords don't match</p>"
        }
    });
}

function counterUp () {
    var a = $(this).scrollTop();
    var k = $(".count");
    if (0 < k.length && k.offset().top < a + window.screen.height && !k.eq(0).hasClass("active")) {
        k.each(function () {
            $(this).addClass("active");
            $(this).prop("Counter", 0).animate({
                Counter: $(this).text()
            }, {
                duration: 4000,
                easing: "swing",
                step: function (a) {
                    $(this).text(Math.ceil(a))
                }
            })
        });
    }
}