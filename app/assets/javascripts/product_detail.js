$(document).on('turbolinks:load', function() {

    $('.item-box__item-main--sub-img li').hover(function(){
        var index = $('.item-box__item-main--sub-img li').index(this);
        var imageurl = $('.item-box__item-main--sub-img li').eq(index).find('img').attr('src');
        $('.active-img').attr('src', imageurl);
    });
});

