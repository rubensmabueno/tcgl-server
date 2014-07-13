App = @tcglServer || {}

App.Views.Map = new ( class Map extends Backbone.View
  el: $('#map-canvas')

  initialize: ->
    @map = new google.maps.Map(@el, @options())
    google.maps.event.addListener @map, "dblclick", @addMarker
    @departureLines = []
    @arrivalLines = []

    @itineraries = new App.Views.ItineraryList()

  addMarker: (mEvent) =>
    unless @markerDeparture?
      @markerDeparture = new MarkerWithLabel(
        map: @map
        position: mEvent.latLng
        labelContent: ("Partida")
        labelAnchor: new google.maps.Point(0, 0)
        labelClass: "label-marker"
        draggable: true
        labelStyle:
          opacity: 0.75
      )

      @calcDeparture()

      google.maps.event.addListener @markerDeparture, "dragend", =>
        @calcDeparture()

    else unless @markerArrival?
      @markerArrival = new MarkerWithLabel(
        map: @map
        position: mEvent.latLng
        labelContent: ("Chegada")
        labelAnchor: new google.maps.Point(0, 0)
        labelClass: "label-marker"
        draggable: true
        labelStyle:
          opacity: 0.75
      )

      @calcArrival()

      google.maps.event.addListener @markerArrival, "dragend", =>
        @calcArrival()

  calcDeparture: =>
    @departureCircle.setMap(null) if @departureCircle != undefined

    @$el.parent(".col-md-12").
         removeClass("col-md-12").
         addClass("col-md-9")

    $(".js-onibus_partida_chegada").removeClass "hidden"

    $.ajax
      url: "/lines/near_stops"
      data:
        position:
          lat: @markerDeparture.getPosition().lat()
          lng: @markerDeparture.getPosition().lng()
      dataType: "json"
      method: "GET"
      success: (res) =>
        lines = res[0]
        radius = res[1]

        @departureCircle = @drawDistanceCircle(@markerDeparture.getPosition(),
                                               radius)
        @departureLines.forEach (departureLine) ->
          departureLine.remove()

        lines.forEach (line) =>
          departureLine = new App.Views.NearLine(line)
          $(".js-onibus_partida").append departureLine.render().$el
          @departureLines.push departureLine

  calcArrival: ->
    @arrivalCircle.setMap(null) if @arrivalCircle != undefined

    $.ajax
      url: "/lines/near_stops"
      data:
        position:
          lat: @markerArrival.getPosition().lat()
          lng: @markerArrival.getPosition().lng()
      dataType: "json"
      method: "GET"
      success: (res) =>
        lines = res[0]
        radius = res[1]

        @arrivalCircle = @drawDistanceCircle(@markerArrival.getPosition(),
                                             radius)
        @arrivalLines.forEach (arrivalLine) ->
          arrivalLine.remove()

        lines.forEach (line) =>
          arrivalLine = new App.Views.NearLine(line)
          $(".js-onibus_chegada").append arrivalLine.render().$el
          @arrivalLines.push arrivalLine

  drawDistanceCircle: (center, radius) ->
    new google.maps.Circle(
      strokeColor: "#FF0000"
      strokeOpacity: 0.8
      strokeWeight: 2
      fillColor: "#FF0000"
      fillOpacity: 0.35
      map: @map
      center: center
      radius: radius * 1000
    )

  getMap: ->
    @map

  options: ->
    {
      zoom: 14
      maxZoom: 16
      minZoom: 1
      streetViewControl: false
      center: new google.maps.LatLng(-23.307895, -51.161442)
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
)