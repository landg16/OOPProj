window.onscroll = function () {
    menuOnScroll();
    counterUp();
};

$( window ).on( "resize",function() {
    equalHeights(".item .description");
});

$(document).ready(function () {
    filterQuizes();
    sortTable();
    everyInputInsideValue();
    registrationValidation();
    addQuestion();
    quizValidation();
    toggleLeaderboard();
    equalHeights(".item .description");
});

function showForgotModal() {
    $('#logIn').modal('hide');
    $('#forgotPassword').modal('show');
    return false;
}

function everyInputInsideValue() {
    $('input').each(function () {
        $(this).on("keyup", function () {
            $(this).attr('value', $(this).val());
        });
    });
}

function removeQuestion() {
    $(".removeQuestion").off("click");
    $(".removeQuestion").on('click', function () {
        var which = parseInt($(this).data("remove")); //2
        var counter = parseInt($("#count").val()); //3
        $("#toRemove" + which).remove();
        for (var i = which; i < counter; i++) {
            var selector = $("#toRemove" + (i + 1));
            var toChange = selector.html();
            var regex = new RegExp((i + 1), "g");
            toChange = toChange.replace(regex, i);
            selector.html(toChange);
            selector.attr("id", "toRemove" + i);
            removeQuestion();
        }
        $("#count").val(counter - 1);
        everyInputInsideValue();
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
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '" placeholder="Ask Your Question" required>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Answer #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="answer' + count + '" id="answer' + count + '" placeholder="Answer Your Question" required>\n' +
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
                '                    <input type="text" class="form-control" name="gap' + count + '" id="gap' + count + '" required>\n' +
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
                '                <input type="hidden" name="type' + count + '" id="type' + count + '" value="' + type + '">\n' +
                '                    <div class="row">\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Image #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '" placeholder="Provide Image URL" required>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-five">\n' +
                '                            <label>Answer #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="answer' + count + '" id="answer' + count + '" placeholder="Answer Your Question" required>\n' +
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
                '                <input type="hidden" name="type' + count + '" id="type' + count + '" value="' + type + '"> \n' +
                '                    <div class="row">\n' +
                '                        <div class="col-md-six">\n' +
                '                            <label>Question #' + count + '</label>\n' +
                '                            <input type="text" class="form-control" name="question' + count + '" id="question' + count + '" required>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-three d-flex flex-column">\n' +
                '                            <button type="button" id="addChoice' + count + '" data-choice="' + count + '" class="btn btn-success w-100 mt-auto addChoice">Add Choice</button>\n' +
                '                        </div>\n' +
                '                        <div class="col-md-three d-flex flex-column">\n' +
                '                            <button type="button" data-remove="' + count + '" class="btn btn-danger w-100 mt-auto removeQuestion">Remove</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- ANSWER -->\n' +
                '               <div id="answers_' + count + '">' +
                '                    <div class="row" class="mc_question' + count + '">\n' +
                '                        <div class="col-md-nine">\n' +
                '                            <label>Answer (Corrrect)</label>\n' +
                '                            <div class="input-group">\n' +
                '                                <input type="text" class="form-control is-valid" name="answer' + count + '" aria-label="Answer box for question" required>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- END ANSWER -->\n' +
                '                    <!-- ANSWER -->\n' +
                '                    <div class="row" class="mc_question' + count + '">\n' +
                '                        <div class="col-md-nine">\n' +
                '                            <label>Answer</label>\n' +
                '                            <div class="input-group">\n' +
                '                                <input type="text" class="form-control is-invalid" name="answer' + count + '" aria-label="Answer box for question" required>\n' +
                '                            </div>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <!-- END ANSWER -->\n' +
                '                  </div><hr>' +
                '                </div>\n' +
                '                <!--- END MC TYPE --->\n';
        }
        $("#questions").append(html);
        // var radio = $("input:radio.radio");
        // radio.off("change");
        // radio.change(function () {
        //
        // });
        if (type === "mc") {
            $('#addChoice' + count).click(function () {
                var gtml = '<!-- ANSWER -->\n' +
                    '                    <div class="row" class="mc_question' + count + '_answer">\n' +
                    '                        <div class="col-md-nine">\n' +
                    '                            <label>Answer</label>\n' +
                    '                            <div class="input-group">\n' +
                    '                                <input type="text" class="form-control is-invalid" name="answer' + count + '" aria-label="Answer box for question" required>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                        <div class="col-md-three d-flex flex-column">\n' +
                    '                            <button type="button" data-question="' + count + '" class="btn btn-danger w-100 mt-auto removeMC">Remove</button>\n' +
                    '                        </div>\n' +
                    '                    </div>\n' +
                    '                    <!-- END ANSWER -->';
                $("#answers_" + count).append(gtml);
                removeMCQuestion();
            });
        }
        $("#count").val(count);
        removeQuestion();
        everyInputInsideValue();
    });
}

function removeMCQuestion() {
    everyInputInsideValue();
    var selector = $(".removeMC");
    selector.off("click");
    selector.click(function () {
        $(this).parent().parent().remove();
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
            image: {
                required: false,
                url: true
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

function counterUp() {
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

function quizValidation() {
    $("#add_quiz_form").validate({
        ignore: "",
        rules: {
            title: "required",
            description:  {
                required: true,
                maxlength: 250
            },
            category: "required",
            image: {
                required: true,
                url: true
            },
            count: {
                required: true,
                minValue: 1,
                maxValue: 30
            }
        },
        message: {
            title: "<p class='error'>Please enter quiz title</p>",
            description: {
                required: "<p class='error'>Please enter description</p>",
                maxlength: "<p class='error'>Description's max length is 250 character</p>"
            },
            category: "<p class='error'>Please choose category</p>",
            image: "<p class='error'>Please enter correct image URL</p>",
            count:  {
                required: "<p class='error'>You must reload this page.</p>",
                minValue: "<p class='error'>You must enter at least one question.</p>",
                maxValue: "<p class='error'>You can only enter 30 question.</p>"
            }
        }
    });
}

function sortTable(){
    $('#myResults').addClass('tablesorter');

    $("#myResults").tablesorter({
        theme: 'black',
        sortList: [[0,0],[1,0]]
    });
}

function toggleLeaderboard() {
    $("#today_leaderboard").show();
    $("#allTime_leaderboard").hide();
    $("#today_button").click(function () {
        $("#today_leaderboard").show();
        $("#allTime_leaderboard").hide();
    });
    $("#allTime_button").click(function () {
        $("#today_leaderboard").hide();
        $("#allTime_leaderboard").show();
    });
}

function filterQuizes() {
    var checked = new Set();
    $(".filter_category").click(function () {
        var id = this.id;
        if($(this).is(":checked")) {
            checked.add(id);
            $(".filter_box").hide();
            checked.forEach(function(value) {
                $("." + value).show();
            });
        } else {
            checked.delete(id);
            if(checked.size === 0){
                $(".filter_box").show();
            } else {
                $("." + id).hide();
            }
        }
    });
}

function equalHeights(className){
    const selector = $(className);
    var maxHeight = -1;
    selector.css('height','auto');
    selector.each(function() {
        const currHeight = $(this).height();
        maxHeight = (currHeight>maxHeight) ? currHeight : maxHeight;
    });
    selector.height(maxHeight);
}