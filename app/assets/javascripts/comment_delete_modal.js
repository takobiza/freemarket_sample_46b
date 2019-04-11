$(document).on('turbolinks:load', function() {
  $(function(){
    $(".is-modal-icon").on('click', function(){
      $(".is-modal__body_gray").text($(this).data('message'));
      var id = $(this).data('id');
      $(".button_to").attr('action', `/comments/${id}`);
      $(".is-modal").fadeIn();
    })
    $(".cancel-btn,.is-modal").unbind().click(function(){
      $(".is-modal").fadeOut();
    })
  });
});
