$ ->
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="popover-prevent-default"]').popover().click((e) -> e.preventDefault())
