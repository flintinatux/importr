# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Add the Bootstrap Datepicker
$(document).on 'focus', "[data-behavior='datepicker']", (e) ->
    $(this).datepicker { 
      'autoclose': true,
      'format': 'yyyy-mm-dd',
      'todayHighlight': true,
      'weekStart': 0
    }