$(document).on('turbolinks:load', function() {
  $(".header-inner__bottom--right-login a").hover(
     function () {
      $(this).css({"cssText" : "color : #0099e8 !important"});
      var children = $(this).children("i");
      children.css({"cssText" : "color : #0099e8 !important"});
    },
    function () {
      $(this).css('color','');
      var children = $(this).children("i");
      children.css('color','');

    }

  );

  $(".header-inner__bottom--right-mypage").hover(
     function () {
      $(".header-inner__bottom--right-mypage-box").css('display','block');
    },
    function () {
      $(".header-inner__bottom--right-mypage-box").css('display','none');
    }

  );

});
