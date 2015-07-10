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
