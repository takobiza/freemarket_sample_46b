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
      grandBox.val('');
      parentBox.parent().remove();
      $('.single-main__sell-registration__upload-drop-box__text').attr('for', 'file-photo-' + m);
    });
  }
});
