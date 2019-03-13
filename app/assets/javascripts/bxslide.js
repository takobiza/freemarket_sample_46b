$(document).on('turbolinks:load', function() {
    $(document).ready(function(){
      $('.bxslider').bxSlider({
        auto: true,
        speed: 1000,
        moveSlides: 1,
        pause: 3000,
        maxSlides: 1,
        slideWidth: 1500,
        randomStart: true,
        autoHover: true,
        infiniteLoop: true
      });
    });
});
