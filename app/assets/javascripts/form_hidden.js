$(document).on('turbolinks:load', function() {

  $('#shippingpay-method').on('change', function() {
    var n = $(this).val();
    if ( n == 0 ) {
      $('#seller-fee').css('display', 'block');
      $('#purchaser-fee').css('display', 'none');
      $('#purchaser-fee').find('.single-main__sell-registration__options__product__box__select-box').val('');
    } else if ( n == 1 ) {
      $('#purchaser-fee').css('display', 'block');
      $('#seller-fee').css('display', 'none');
      $('#seller-fee').find('.single-main__sell-registration__options__product__box__select-box').val('');
    }
  });

});
