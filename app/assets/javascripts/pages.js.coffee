# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Load the countdown for this game
load_countdown = () ->
  timer = $('#countdown')
  year = timer.data 'year'
  month = timer.data 'month'
  day = timer.data 'day'
  date = new Date(year, month-1, day)
  timer.countdown { until: date, format: 'odHMS' }
  # timer.countdown 'pause'

$(document).ready () ->
  load_countdown()