$(document).on('turbolinks:load', function() {

  $("#user_card_number").keypress(function(){
    if ($(this).val().length == 4 || $(this).val().length == 9 || $(this).val().length == 14){
      $(this).val( $(this).val() + "-");
    };
  });

});
