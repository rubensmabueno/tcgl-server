App = @tcglServer || {}

class App.Views.ItineraryList extends Backbone.View
  collection: App.Collections.Itineraries

  initialize: ->
    @paths = []

  change: ->
    @removeAll()
    itinerariesGrouped = App.Collections.Itineraries.groupedByLine()

    _.each itinerariesGrouped, (itineraries) =>
      itineraryList = []
      color = _.first(itineraries).get('color')

      _.each itineraries, (itinerary) ->
        itineraryList.push(new google.maps.LatLng(itinerary.get('lat'), itinerary.get('lng')))

      @paths.push( new google.maps.Polyline({
        map: App.Views.Map.getMap(),
        path: itineraryList,
        strokeColor: color
        strokeWeight: 2
      }));

  removeAll: ->
    _.each @paths, (path) ->
      path.setMap(null)
    @paths = []