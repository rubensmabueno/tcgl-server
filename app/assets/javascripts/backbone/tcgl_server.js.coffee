@tcglServer = @tcglServer || {}

@tcglServer = new (class App extends Backbone.View
  Views: {}
  Models: {}
  Collections: {}

  start: ->
    _.templateSettings = interpolate : /\{\{(.+?)\}\}/g

    @lineList = new @Views.LineList()
    @markerList = new @Views.MarkerList()
)
