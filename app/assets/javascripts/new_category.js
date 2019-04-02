$(document).on('turbolinks:load', function() {

function buildOption(categories) {
  var html = `<option value="${ categories.id }">
    ${ categories.name }
  </option>`
  return html
}

  $('#large_category').on('change', function() {
    var large_category_id = $(this).val();
    $('#middle_category_box').css('display', 'block');
    $.ajax({
      type: 'GET',
      url: '/sells',
      data: {
        category_id: large_category_id
      },
      dataType: 'json'
    })
    .done(function(categories){
      $('#middle_category').empty();
      $('#middle_category').append("<option value> --- </option>");
      $('#small_category').empty();
      $('#small_category').append("<option value> --- </option>");
      categories.forEach(function(categories) {
        var option = buildOption(categories);
        $('#middle_category').append(option);
      })
    })
    .fail(function(categories){
      $('#middle_category').empty();
      $('#middle_category').append("<option value> --- </option>");
      $('#middle_category_box').css('display', 'none');
      $('#small_category').empty();
      $('#small_category').append("<option value> --- </option>");
      $('#small_category_box').css('display', 'none');
    })
  });

  $('#middle_category').on('change', function() {
    var middle_category_id = $(this).val();
    $('#small_category_box').css('display', 'block');
    $.ajax({
      type: 'GET',
      url: '/sells',
      data: {
        category_id: middle_category_id
      },
      dataType: 'json'
    })
    .done(function(categories){
      $('#small_category').empty();
      $('#small_category').append("<option value> --- </option>");
      categories.forEach(function(categories) {
        var option = buildOption(categories);
        $('#small_category').append(option);
      })
    })
    .fail(function(categories){
      $('#small_category').empty();
      $('#small_category').append("<option value> --- </option>");
      $('#small_category_box').css('display', 'none');
    })
  });

  $(function() {
    if (location.href.match(/\/products\/\d+\/edit/)) {
      $('#large_category').prepend("<option value> --- </option>");
      $('#middle_category').prepend("<option value> --- </option>");
      $('#small_category').prepend("<option value> --- </option>");
    }
  });

});
