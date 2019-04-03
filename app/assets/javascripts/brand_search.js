$(document).on('turbolinks:load', function() {
  $('#brand-type-area').on('keyup', function() {
    var brandName = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/brands/new',
      data: {
        brand_name: brandName
      },
      dataType: 'json'
    })
    .done(function(data){
      $('#brand-number-area').attr('value', data.id);
    })
    .fail(function(){
      $('#brand-number-area').val('');
    })
  });
});
