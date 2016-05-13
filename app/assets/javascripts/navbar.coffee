$(window).scroll ->
  top = $(document).scrollTop()
  $('.hero-bg').css 'background-position': '0px -' + (top / 3).toFixed(2) + 'px'

  $navbar = $('.navbar.navbar-fixed-top')
  if top > 50
    $navbar.addClass 'navbar-default'
    $navbar.removeClass 'navbar-transparent'
  else
    $navbar.addClass 'navbar-transparent'
    $navbar.removeClass 'navbar-default'
