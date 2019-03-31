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

  function purchaserFeeHTML() {
    var html = `<option value="0">未定</option>
    <option value="3">レターパック</option>
    <option value="5">クロネコヤマト</option>
    <option value="6">ゆうパック</option>`
    return html;
  }

  function sellerFeeHTML() {
    var html = `<option value="0">未定</option>
    <option value="1">らくらくメルカリ便</option>
    <option value="2">ゆうメール</option>
    <option value="3">レターパック</option>
    <option value="4">普通郵便(定形、定形外)</option>
    <option value="5">クロネコヤマト</option>
    <option value="6">ゆうパック</option>
    <option value="7">クリックポスト</option>
    <option value="8">ゆうパケット</option>`
    return html;
  }

  $(function() {
    if (location.href.match(/\/products\/\d+\/edit/)) {
      $('#shippingpay-method').prepend("<option value> --- </option>");
      var methodNumber = $('#shippingpay-method').val();
      if ( methodNumber == 0 ) {
        $('#purchaser-fee').css('display', 'none');
        $('#edit_seller_fee').append(sellerFeeHTML);
        $('#edit_purchaser_fee').append(purchaserFeeHTML);
      } else if ( methodNumber == 1 ) {
        $('#seller-fee').css('display', 'none');
        $('#edit_purchaser_fee').append(purchaserFeeHTML);
        $('#edit_seller_fee').append(sellerFeeHTML);
      }
    }
  });

});
