$(function() {
  $('body').on('click', '.entry a', function(){
  	$('.timeline-modal').empty();
  	$('.timeline-modal, .timeline-modal-close, .timeline-modal-bg').addClass('is-visible')
  	$('.timeline-modal').load($(this).prop('href'), function() {
  		$('.timeline-modal').addClass('remove-loading')
		});
    return false
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