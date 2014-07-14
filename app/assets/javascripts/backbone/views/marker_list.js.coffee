App = @tcglServer || {}

class App.Views.MarkerList extends Backbone.View
  initialize: ->
    @listenTo App.Collections.Lines, 'change:line_id', @fetchMarker
    @listenTo App.Collections.Lines, 'remove', @fetchMarker

    @markers = []

    @pollPosition()
    @fetchMarker()

  pollPosition: ->
    setTimeout =>
      @fetchMarker(true)
    , 10000

  fetchMarker: (recurrent = false) ->
    line_ids = _.map App.Collections.Lines.models, (line) ->
      line.get('line')

    $.ajax "/lines/positions", {
      data:
        line_ids: line_ids
      success: (markers) =>
        @addMarkers(markers)
        @pollPosition() if recurrent
    }

  addMarkers: (markersArray) ->
    _.each @markers, (marker) ->
      marker.setMap(null)
    @markers = []

    _.each markersArray, (markers) =>
      _.each markers, (marker) =>
        @markers.push new MarkerWithLabel {
          map: App.Views.Map.getMap(),
          position: new google.maps.LatLng(marker.lat, marker.lng),
          labelContent: ( marker.line_name + " <br>Para: " + marker.to ),
          labelAnchor: new google.maps.Point(0, 0),
          labelClass: "label-marker",
          labelStyle: {opacity: 0.75}
        }