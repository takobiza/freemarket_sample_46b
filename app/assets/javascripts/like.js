$(document).on('turbolinks:load', function() {
  $(function(){
    $(".item-box__item-footer--like").on('click', function(){
      var like = $(".item-box__item-footer--like")
      var id = like.data('id');
      var label = like.data('label');
      if (label == "dis-like"){
        $.ajax({
          type: 'POST',
          url: '/favorites',
          data: {
            product_id: id
          }
        })
        .done(function(data){

          if (!data){
            like.addClass('item-box__item-footer--like-heart');
            var count = parseInt($(".item-box__item-footer--like-counter").text());
            $(".item-box__item-footer--like-counter").text(count += 1);
            like.data('label', 'like');
          }

        })
        .fail(function(data){
          alert('いいね！に失敗しました。')
        });

      }else{
        $.ajax({
          type: 'delete',
          url: '/favorites/destroy',
          data: {
            product_id: id
          },
          dataType: 'json'
        })
        .done(function(data){
          like.removeClass('item-box__item-footer--like-heart');
          $(".item-box__item-footer--like").css('color', "");
          var count = parseInt($(".item-box__item-footer--like-counter").text());
          $(".item-box__item-footer--like-counter").text(count -= 1);
          like.data('label', 'dis-like');
        })
        .fail(function(data){
          alert('いいね！に失敗しました。');
        });

      }


    });
  });
});
