$(document).on('turbolinks:load', function() {
  function appendBrandName(data) {
    var html = `<li class="single-main__sell-registration__options__product__box__suggestion-area__brand-name">
                  <p value="${ data.id }">${ data.name }</p>
                </li>`
    $('#brands-area').append(html);
  }

  var disabledKeys = ["9", "16", "17", "18", "37", "38", "39", "40", "27"]

  $('#brand-type-area').on('keyup', function(e) {
    if ($.inArray(`${e.keyCode}`, disabledKeys) == -1) {
      $('#brand-number-area').val('');
    }
    var brandNameKeyword = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/brands/new',
      data: {
        brand_name_keyword: brandNameKeyword
      },
      dataType: 'json'
    })
    .done(function(brands){
      if ( brands[0].name == $('#brand-type-area').val() ) {
        var brandJustId = brands[0].id
        $('#brand-number-area').attr('value', brandJustId);
      }
      $('#brands-area').empty();
      brands.forEach(function(brand) {
        appendBrandName(brand);
      });
      if ( brands.length == 0 || $('#brand-type-area').val().length == 0 ) {
        $('#brands-area').empty();
      }
      $('li.single-main__sell-registration__options__product__box__suggestion-area__brand-name').on('click', function() {
        var brandName = $(this).find('p').text();
        var brandId = $(this).find('p').attr('value');
        $('#brand-type-area').val(brandName);
        $('#brand-number-area').attr('value', brandId);
        $('#brands-area').empty();
      });
    })
    .fail(function(){
      $('#brand-number-area').val('');
    })
  });
});
