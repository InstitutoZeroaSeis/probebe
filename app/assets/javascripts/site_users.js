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
    has_ninth_digit = phone.replace(/[^\d]/g, '').length > 10;
    if (has_ninth_digit) {
      return '00 00000-0000';
    } else {
      return '00 0000-0000';
    }
  };
  return $(".phone").mask(phoneMask, {
    onKeyPress: function(phone, e, currentField, options) {
      return $(currentField).mask(phoneMask(phone), options);
    }
  });
});
