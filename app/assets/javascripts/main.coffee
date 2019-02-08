# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

this.select_all = ->
  $('input[name="wordset_id[]"]').prop('checked', true)

this.select_none = ->
  $('input[name="wordset_id[]"]').prop('checked', false)

