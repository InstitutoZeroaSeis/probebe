$(function() {
  $('body').on('click', '.entry a', function(event){
    event.preventDeafult()
    var href = $(this).attr('href');
    if (href.slice(-1) === '#') {
      return;
    }
  	$('.timeline-modal').empty();
  	$('.timeline-modal, .timeline-modal-close, .timeline-modal-bg').addClass('is-visible')
  	$('.timeline-modal').load(href, function() {
  		$('.timeline-modal').addClass('remove-loading')
		});
  });

  $('body').on('click', '.timeline-modal-close, .timeline-modal-bg', function(){
  	$('.timeline-modal, .timeline-modal-close, .timeline-modal-bg').removeClass('is-visible')
  	$('.timeline-modal').removeClass('remove-loading')
  	$('.timeline-modal').empty();

    return false
  });

  $('a[href=#]').click(function(){
    event.preventDefault();
  });
});
