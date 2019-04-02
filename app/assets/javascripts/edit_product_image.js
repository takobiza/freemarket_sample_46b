$(document).on('turbolinks:load', function() {
  if (location.href.match(/\/products\/\d+\/edit/)) {
    var firstChildList = $('ul.single-main__sell-registration__upload-drop-box__list').find('li:first-child');

    firstChildList.nextAll("li").find('input').attr('id', 'file-photo-1').attr('value', '1');

    firstChildList.nextAll("li").nextAll("li").find('input').attr('id', 'file-photo-2').attr('value', '2');

    firstChildList.nextAll("li").nextAll("li").nextAll("li").find('input').attr('id', 'file-photo-3').attr('value', '3');

    firstChildList.nextAll("li").nextAll("li").nextAll("li").nextAll("li").find('input').attr('id', 'file-photo-4').attr('value', '4');

    $('.single-main__sell-registration__upload-drop-box__photo__image-area').find("p.single-main__sell-registration__upload-drop-box__photo__image-area__btn-area").find("a.single-main__sell-registration__upload-drop-box__photo__image-area__remove-btn").on('click', function(){
      var input =$(this);
      var parentBox = input.parent().prev();
      var grandBox = parentBox.parent().prev();
      var m = grandBox.attr('value');
      console.log(m);
      grandBox.val('');
      parentBox.parent().remove();
      $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + m).attr('edit_value', m);
    });

    $('.single-main__sell-registration__upload-drop-box__text').on('click', function() {
      var g = $(this).attr('edit_value');

      $('#file-photo-' + g).off().on('change',function() {
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
        }

        filereader.readAsDataURL(fileprop);

        var p = $('img.single-main__sell-registration__upload-drop-box__photo__image-area__image').length;

        $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + p).attr('edit_value', p);
      });

    });

  }
});
