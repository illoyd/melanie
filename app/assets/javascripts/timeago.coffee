readyTimeago = ->
  $("time.timeago").timeago()

$(document).ready(readyTimeago)
$(document).on('page:load', readyTimeago)