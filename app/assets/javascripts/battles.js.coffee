# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  t = setInterval =>
    $.ajax
      type: 'get'
      url: $(location).attr('href') + "/log.json"
      success: (json) ->
        clearInterval(t) if json.status == 'finished'
        $('pre#log').text(json.log)
  , 1000 if $('pre#log').length