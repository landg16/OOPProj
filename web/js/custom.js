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