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

update_clock = (elem, utc_offset) ->
  # Generate offset time
  current_time = new Date()
  offset = current_time.getTime() + Math.round(utc_offset * 60 * 60 * 1000)
  world_time = new Date()
  world_time.setTime offset

  # Get hours and minutes
  hours = world_time.getUTCHours()
  hours += 24 if hours < 0
  minutes = world_time.getUTCMinutes()

  # Choose either "AM" or "PM"
  time_of_day = if hours < 12 then "AM" else "PM"

  # Convert the hours component to 12-hour format
  hours = if hours > 12 then hours - 12 else hours
  hours = if hours == 0 then 12 else hours

  # Pad the minutes and seconds with leading zeros
  hours   = ( if hours   < 10 then "0" else "" ) + hours
  minutes = ( if minutes < 10 then "0" else "" ) + minutes

  # Compose the string for display
  time_string = hours + ":" + minutes + " " + time_of_day
  elem.html(time_string)

clocks = '#beijing': 8, '#new_delhi': 5.5, '#london': 0, '#atlanta': -5, '#los_angeles': -8

update_clocks = () ->
  for city, offset of clocks
    update_clock($(city), offset)
    
$(document).ready () ->
  load_countdown()
  update_clocks()
  setInterval () ->
    update_clocks()
  , 60000