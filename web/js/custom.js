window.onscroll = function() {menuOnScroll()};

function menuOnScroll() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        document.getElementById("navbar").classList.add("scroll");
    } else {
        document.getElementById("navbar").classList.remove("scroll");
    }
}

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