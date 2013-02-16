# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ajaxComplete () ->

  # Add error styling to forms
  $('.field_with_errors').parents('.control-group').addClass('error')