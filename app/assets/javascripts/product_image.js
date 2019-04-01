$(document).on('turbolinks:load', function() {

  $('.single-main__sell-registration__upload-drop-box__text').on('click', function() {
    if (location.href.match(/\/products\/\d+\/edit/)) {
      var i = $('.single-main__sell-registration__upload-drop-box__text').attr('edit_value');
    } else {
      var i = $('img.single-main__sell-registration__upload-drop-box__photo__image-area__image').length;
    }


    $('#file-photo-' + i).off().on('change',function() {
      var file_photo = $(this);
      var filepropArray = $(this).prop('files');
      var fileprop = filepropArray[0];
      var find_img = $(this).parent().find('img');
      var filereader = new FileReader();
      var view_box = $(this).parent();
      var img =
         `<div class="single-main__sell-registration__upload-drop-box__photo__image-area">
            <img alt="" class="single-main__sell-registration__upload-drop-box__photo__image-area__image", width="114">
            <p class="single-main__sell-registration__upload-drop-box__photo__image-area__btn-area">
              <a class="single-main__sell-registration__upload-drop-box__photo__image-area__remove-btn">削除</a>
              <a class="single-main__sell-registration__upload-drop-box__photo__image-area__edit-btn">編集</a>
            </p>
          </div>`

      view_box.append(img);

      filereader.onload = function() {
        view_box.find('img').attr('src', filereader.result);
        remove_image(view_box);
      }

      filereader.readAsDataURL(fileprop);

      var p = $('img.single-main__sell-registration__upload-drop-box__photo__image-area__image').length;

      $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + p);

      function remove_image(target) {
        target.find("a.single-main__sell-registration__upload-drop-box__photo__image-area__remove-btn").on('click', function(){
          var input =$(this);
          var parentBox = input.parent().prev();
          var grandBox = parentBox.parent().prev();
          var m = grandBox.attr('value');
          grandBox.val('');
          parentBox.parent().remove();
          $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + m);
        });
      }
    });
  });

});
