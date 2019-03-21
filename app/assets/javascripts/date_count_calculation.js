$(document).on('turbolinks:load', function() {

  function calcDaysForBrithdayForm(){
      var day = $('#user_user_detail_attributes_birth_day');
      day.empty();
      var y = $('#user_user_detail_attributes_birth_year').val();
      var m = $('#user_user_detail_attributes_birth_month').val();

      if (m == 2 && ((y % 400 == 0) || ((y % 4 == 0) && (y % 100 != 0)))) {
        var last = 29;
      } else {
        var last = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)[m-1];
      }

      day.append('<option value="">--</option>');
      for (var i = 1; i <= last; i++) {
        if (day == i) {
          day.append('<option value="' + i + '" selected>' + i + '</option>');
        } else {
          day.append('<option value="' + i + '">' + i + '</option>');
        }
      }
    }

    $('#user_user_detail_attributes_birth_year').change(function(){
      calcDaysForBrithdayForm();
    });

    $('#user_user_detail_attributes_birth_month').change(function(){
      calcDaysForBrithdayForm();
    });

});
