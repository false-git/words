# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $("#btn_select_all").click ->
    $('input[name="wordset_id[]"]').prop('checked', true)
  $("#btn_select_none").click ->
    $('input[name="wordset_id[]"]').prop('checked', false)
  $("#btn_speak").click ->
    speak($("#text_speak").val())
  if $("#text_speak").val()?
    speak($("#text_speak").val())

speak = (text) ->
    uttr = new SpeechSynthesisUtterance()
    uttr.text = text
    uttr.lang = "en-US"
    speechSynthesis.speak(uttr)
  
