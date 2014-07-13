App = @tcglServer || {}

App.Collections.Itineraries = new ( class Itineraries extends Backbone.Collection
  model: App.Models.Itinerary

  sorted: ->
    _.sortBy @models, (itinerary) ->
      ( itinerary.get('to') * 10000 ) + itinerary.get('order')

  groupedByLine: ->
    _.groupBy @sorted(), (itinerary) ->
      itinerary.get('line_id')
)