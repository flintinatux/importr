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
  current_time = new Date()
  offset = current_time.getTime() + Math.round(utc_offset * 60 * 60 * 1000)
  world_time = new Date()
  world_time.setTime offset
  hours = world_time.getUTCHours()
  hours += 24 if hours < 0
  minutes = world_time.getUTCMinutes()

  # Choose either "AM" or "PM" as appropriate
  time_of_day = if hours < 12 then "AM" else "PM"

  # Convert the hours component to 12-hour format if needed
  hours = if hours > 12 then hours - 12 else hours

  # Convert an hours component of "0" to "12"
  hours = if hours == 0 then 12 else hours

  # Pad the minutes and seconds with leading zeros, if required
  hours   = ( if hours   < 10 then "0" else "" ) + hours
  minutes = ( if minutes < 10 then "0" else "" ) + minutes

  # Compose the string for display
  time_string = hours + ":" + minutes + " " + time_of_day
  
  elem.html(time_string)


clocks = '#beijing': 8, '#new_delhi': 5.5, '#london': 0

update_clocks = () ->
  for city, offset of clocks
    update_clock($(city), offset)
    setInterval () ->
      update_clock($(city), offset)
    , 60000

$(document).ready () ->
  load_countdown()
  update_clocks()