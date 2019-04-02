$(document).on('turbolinks:load', function() {
  function addComma(price_string) {
    return price_string.replace(/(\d)(?=(\d\d\d)+$)/g, "$1,");
  }

  $('.single-main__sell-registration__options__product__price-box__price').on('keyup', function() {
    var price = $(this).val().match(/^\d+$/);
    if (price >= 300 && price <= 9999999) {
      var tax = Math.floor(price/10);
      var profit = price - tax;
      var tax_s = addComma(String(tax));
      var profit_s = addComma(String(profit));
      $('.single-main__sell-registration__options__product__price-box__comission').text("¥" + tax_s);
      $('.single-main__sell-registration__options__product__price-box-profit__profit').text("¥" + profit_s);
    } else {
      $('.single-main__sell-registration__options__product__price-box__comission').text("-");
      $('.single-main__sell-registration__options__product__price-box-profit__profit').text("-");
    }
  });

  $(function() {
    if (location.href.match(/\/products\/\d+\/edit/)) {
      var default_price = $('.single-main__sell-registration__options__product__price-box__price').val();
      var default_tax = Math.floor(default_price/10);
      var default_profit = default_price - default_tax;
      var default_tax_s = addComma(String(default_tax));
      var default_profit_s = addComma(String(default_profit));
      $('.single-main__sell-registration__options__product__price-box__comission').text("¥" + default_tax_s);
      $('.single-main__sell-registration__options__product__price-box-profit__profit').text("¥" + default_profit_s);
    }
  });


});
