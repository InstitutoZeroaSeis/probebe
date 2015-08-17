//= require jquery.mask

function impersonate_success_callback(data){
  location.reload();
}

function impersonate_error_callback(data){
  location.reload();
}

function authorize_receive_sms_success_callback(data){
  Carnival.reloadIndexPage()
}

function unauthorize_receive_sms_success_callback(data){
  Carnival.reloadIndexPage()
}


$(document).ready(function() {
  var phoneMask;

  phoneMask = function(phone) {
    var has_ninth_digit;
    has_ninth_digit = false;
    if (phone) {
      has_ninth_digit = phone.replace(/[^\d]/g, '').length >= 11;
    }
    if (has_ninth_digit) {
      return $(".phone").mask('00 00000-0000');
    } else {
      return $(".phone").mask('00 0000-00009');
    }
  };

  phoneMask($('.phone').val());

  $('.phone').focusout(function(event) {
    return phoneMask($(this).val());
  });
});
