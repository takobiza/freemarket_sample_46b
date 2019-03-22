$(document).on('turbolinks:load', function() {
  if (window.location.href.match(/sms_confirmation/)){
    $('.progress-state--first--line').css("background","#ea352d");

    $('.progress-state--second--line-left').css("background","#ea352d");


    $('li.signup-header-page-bar__member-information').css("color","#888");
    $('li.signup-header-page-bar__member-information').css("font-weight",100);

    $('li.signup-header-page-bar__phone-number').css("color","#ea352d");
    $('li.signup-header-page-bar__phone-number').css("font-weight",600);



    $('.progress-state--second').css("background","#ea352d");


  }else if(window.location.href.match(/address/)){
    $('.progress-state--first--line').css("background","#ea352d");
    $('.progress-state--second--line-left').css("background","#ea352d");
    $('.progress-state--second--line-right').css("background","#ea352d");
    $('.progress-state--third--line-left').css("background","#ea352d");

    $('li.signup-header-page-bar__member-information').css("color","#888");
    $('li.signup-header-page-bar__member-information').css("font-weight",100);

    $('li.signup-header-page-bar__delivery-address').css("color","#ea352d");
    $('li.signup-header-page-bar__delivery-address').css("font-weight",600);

    $('.progress-state--second').css("background","#ea352d");
    $('.progress-state--third').css("background","#ea352d");
  }else if(window.location.href.match(/credit/)){
    $('.progress-state--first--line').css("background","#ea352d");
    $('.progress-state--second--line-left').css("background","#ea352d");
    $('.progress-state--second--line-right').css("background","#ea352d");
    $('.progress-state--third--line-left').css("background","#ea352d");
    $('.progress-state--third--line-right').css("background","#ea352d");
    $('.progress-state--forth--line-left').css("background","#ea352d");

    $('li.signup-header-page-bar__member-information').css("color","#888");
    $('li.signup-header-page-bar__member-information').css("font-weight",100);

    $('li.signup-header-page-bar__payment-method').css("color","#ea352d");
    $('li.signup-header-page-bar__payment-method').css("font-weight",600);

    $('.progress-state--second').css("background","#ea352d");
    $('.progress-state--third').css("background","#ea352d");
    $('.progress-state--forth').css("background","#ea352d");
  }else if(window.location.href.match(/completed/)){
    $('.progress-state--first--line').css("background","#ea352d");
    $('.progress-state--second--line-left').css("background","#ea352d");
    $('.progress-state--second--line-right').css("background","#ea352d");
    $('.progress-state--third--line-left').css("background","#ea352d");
    $('.progress-state--third--line-right').css("background","#ea352d");
    $('.progress-state--forth--line-left').css("background","#ea352d");
    $('.progress-state--forth--line-right').css("background","#ea352d");
    $('.progress-state--fifth--line').css("background","#ea352d");

    $('li.signup-header-page-bar__member-information').css("color","#888");
    $('li.signup-header-page-bar__member-information').css("font-weight",100);

    $('li.signup-header-page-bar__all-end').css("color","#ea352d");
    $('li.signup-header-page-bar__all-end').css("font-weight",600);

    $('.progress-state--second').css("background","#ea352d");
    $('.progress-state--third').css("background","#ea352d");
    $('.progress-state--forth').css("background","#ea352d");
    $('.progress-state--fifth').css("background","#ea352d");
  }
});
