
slideCounter = 1;

$('a').click(function(){
  if($('.show').hasClass('last') == true){
    return false;
  } else {
    slideCounter = slideCounter++;
    $(this).parent().toggleClass('show');
    $(this).parent().next().toggleClass('show');
    return false;
  }
})


$('.page3 a').click(function(){
  $('body').scrollTo( 750, 800 );
  return false;
})

$('.page5 a').click(function(){
  $('body').scrollTo( 1550, 800 );
  return false;
})

$('.page6 a').click(function(){
  $('body').scrollTo( 2140, 800 );
  return false;
})
