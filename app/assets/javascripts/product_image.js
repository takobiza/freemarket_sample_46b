$(document).on('turbolinks:load', function() {

  $('.single-main__sell-registration__upload-drop-box__text').on('click', function() {
    var i = $('img.single-main__sell-registration__upload-drop-box__photo__image-area__image').length;

    if ($('#file-photo-' + i)[0].files[0] !== undefined) {
      // inputにfileが入っていたら以下を実行
      var i = 0;
      if ($('#file-photo-' + i)[0].files[0] !== undefined) {
        var i = 1;
        if ($('#file-photo-' + i)[0].files[0] !== undefined) {
          var i = 2;
          if ($('#file-photo-' + i)[0].files[0] !== undefined) {
            var i = 3;
            if ($('#file-photo-' + i)[0].files[0] !== undefined) {
              var i = 4;
            }
          }
        }
      }
      $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + i);
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

      $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + p).attr('edit_value', p);

      function remove_image(target) {
        target.find("a.single-main__sell-registration__upload-drop-box__photo__image-area__remove-btn").on('click', function(){
          var input =$(this);
          var parentBox = input.parent().prev();
          var grandBox = parentBox.parent().prev();
          var m = grandBox.attr('value');
          grandBox.val('');
          parentBox.parent().remove();
          $('.single-main__sell-registration__upload-drop-box__text').attr('edit_value', m).attr('for', 'file-photo-' + m);
        });
      }
    });
  });

});
