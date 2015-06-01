//= require ckeditor/init

$(document).ready(function () {
  

  var imageCoveUploadFunction = CKEDITOR.tools.addFunction(function(url){
    $('#articles_journalistic_article_cover').val(url);
    $('#image-cover-preview').attr('src', window.location.origin + url).show();;
  });  


  $('#add-image-cover').click(function(event){
    event.preventDefault();

    var width = parseInt(window.screen.width*0.8); //80% da janela
    var height = parseInt(window.screen.height*0.7); //70% da janela
    var specs = "location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,scrollbars=yes,width=" + width + ",height=" + height + ",top=0,left=0";
    var url = window.location.origin + "/ckeditor/pictures?CKEditor=articles_journalistic_article_text&CKEditorFuncNum=" + imageCoveUploadFunction + "&langCode=en";

    window.open(url, 'imageCoverUploadWindow', specs);
  });

});