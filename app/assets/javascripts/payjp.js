$(document).on('turbolinks:load', function() {
  var form = $("#charge-form");
   Payjp.setPublicKey('pk_test_8ac097c8eb58056f014821bc');
   $(document).on("click", ".registration-form__add-btn", function(e) {
      e.preventDefault();
      form.find("input[type=submit]").prop("disabled", true);

    var card = {
        number: parseInt($("#payment_card_no").val()),
        cvc: parseInt($("#payment_card_security_code").val()),
        exp_month: parseInt($("#payment_card_expire_mm").val()),
        exp_year: parseInt($("#payment_card_expire_yy").val())
    };

    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        console.log(response);
        alert('トークン作成エラー発生');
      }
      else {
        $(".registration-form__card-number--form").removeAttr("name");
        $(".registration-form__sequrity-cord--form").removeAttr("name");
        $(".registration-form__expiration-date--month-form").removeAttr("name");
        $(".registration-form__expiration-date--year-form").removeAttr("name");

        var token = response.id;

        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      }
    });
  });
});
