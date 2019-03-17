jQuery(document).ready(function(){
$(function(){
    $('.item-main__sub-img li').hover(function(){
        var index = $('.item-main__sub-img li').index(this);
        var imageurl = $('.item-main__sub-img li').eq(index).find('img').attr('src');
        $('.item-main__main-img__img').attr('src', imageurl);
    });
});
});
