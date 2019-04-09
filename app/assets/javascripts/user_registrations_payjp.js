$(document).on('turbolinks:load', function() {
  var form = $("#card-form");
   Payjp.setPublicKey('pk_test_8ac097c8eb58056f014821bc');
   $(document).on("click", ".create_card_btn", function(e) {
      e.preventDefault();

      form.find("input[type=submit]").prop("disabled", true);
      var year =  "20"+ $("#user_credit_year").val()
      var number = $("#user_card_number").val().split('-').join('');

    var card = {
        number: parseInt(number),
        cvc: parseInt($("#user_card_code").val()),
        exp_month: parseInt($("#user_credit_month").val()),
        exp_year: parseInt(year)
    };

    Payjp.createToken(card, function(s, response) {
        var token = response.id;
        form.append($('<input type="hidden" name="payjpToken" />').val(token));
        form.get(0).submit();
      });
  });
});
