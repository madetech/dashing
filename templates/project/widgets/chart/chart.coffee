class Dashing.Chart extends Dashing.Widget

  @accessor 'current', ->
    points = @get('points')
    return @get('displayedValue') if @get('displayedValue')

  ready: ->
    $node = $(@node)
    google.setOnLoadCallback @drawChart $node, @get 'points'

  getHeight: (container) ->
    (Dashing.widget_base_dimensions[1] * container.data("sizey"))

  getWidth: (container) ->
    (Dashing.widget_base_dimensions[0] * container.data("sizex")) + Dashing.widget_margins[0] * 2 * (container.data("sizex") - 1)

  drawChart: ($node, points) ->

    $node = $(@node)
    container = $node.parent()
    chart_container = $node.find('.chart-container')[0]

    data = google.visualization.arrayToDataTable points

    @chart = new google.visualization.AreaChart chart_container
    @render_data $node, container, data

  render_data: ($node, container, data) ->
    try
      @chart.clearChart()
    @chart.draw data, @options $node.data('xaxis_label'), $node.data('yaxis_label'), @getWidth(container), @getHeight(container)

  options: (x_title, y_title, width, height) ->
    areaOpacity: "1.0"
    axisTitlesPosition: "in"
    backgroundColor: "transparent"
    chartArea:
      left: 0
      top: 0
      width: "100%"
      height:"100%"
    colors: ['white'],
    enableInteractivity: false
    hAxis:
      titleTextStyle:
        color: 'black'
        fontName: 'Open Sans'
        fontSize: 20
      textStyle:
        color: 'black'
        fontName: 'Open Sans'
        fontSize: 15
      title: x_title
      textPosition: "in"
      gridlines:
        color: 'transparent'
        count: 0
    vAxis:
      titleTextStyle:
        color: 'black'
        fontName: 'Open Sans'
        fontSize: 20
      textStyle:
        color: 'black'
        fontName: 'Open Sans'
        fontSize: 20
      title: y_title
      textPosition: "in"
    width: width
    height: height

  onData: (data) ->
    if @chart
      $node = $(@node)
      container = $node.parent()
      new_data = google.visualization.arrayToDataTable data.points
      @render_data $node, container, new_data
