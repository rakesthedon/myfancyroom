$(function()
  {
    $('a.page-scroll').bind('click', function(event)
    {
        $('html, body').stop().animate({scrollTop: $($(this).attr('href')).offset().top}, 1500, 'easeInOutExpo');       
        event.preventDefault();
    });
});

$(function()
  {
    $(".navbar-nav li a").click(function(event) {
      $(".navbar-collapse").collapse('hide');
    });
});
