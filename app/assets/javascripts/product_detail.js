$(document).on('turbolinks:load', function() {

    $('.item-box__item-main--sub-img li').hover(function(){
        var index = $('.item-box__item-main--sub-img li').index(this);
        var imageurl = $('.item-box__item-main--sub-img li').eq(index).find('img').attr('src');
        $('.active-img').attr('src', imageurl);
    });

  $("dd").hide();
  $("body").append(`<div id='glayLayer'></div>
                      <div id='overLayer'></div>`);
  $("#glayLayer").on("click", function(){
    $(this).fadeOut();
    $("#overLayer").fadeOut();
  });

  $(".item-box__delete").on("click",function(){
    $("#glayLayer").fadeIn();
    $("#overLayer").fadeIn().html($("+dd",this).html()).css({"margin-top":"-"+$("#overLayer").height()/2+"px", "margin-left":"-"+$("#overLayer").width()/2+"px"
      });
    });



  });


