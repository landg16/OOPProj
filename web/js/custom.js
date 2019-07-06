window.onscroll = function() {menuOnScroll()};

function menuOnScroll() {
    if (document.body.scrollTop > 100 || document.documentElement.scrollTop > 100) {
        document.getElementById("navbar").classList.add("scroll");
    } else {
        document.getElementById("navbar").classList.remove("scroll");
    }
}