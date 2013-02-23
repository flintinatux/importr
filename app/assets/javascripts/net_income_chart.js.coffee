create_chart = (series) ->
  chart = new Highcharts.StockChart {
    chart: {
      renderTo: 'net_income_chart'
    },

    plotOptions: {
      line: {
        connectNulls: true
      }
    },

    series: series
  }

load_chart = () ->
  series_path = $('#net_income_chart').attr 'href'
  if series_path
    $.getJSON series_path, (series) ->
      create_chart(series)

$(document).ready () ->
  load_chart()