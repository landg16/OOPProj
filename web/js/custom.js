window.onscroll = function() {menuOnScroll()};

function menuOnScroll() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        document.getElementById("navbar").classList.add("scroll");
    } else {
        document.getElementById("navbar").classList.remove("scroll");
    }
}

$(window).scroll(function() {
    var a = $(this).scrollTop();
    var k = $(".count");
    if(0 < k.length && k.offset().top < a + window.screen.height && !k.eq(0).hasClass("active")){
        k.each(function() {
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
});

$(document).ready(function () {
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
});