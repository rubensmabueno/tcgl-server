App = @tcglServer || {}

class App.Models.Line extends Backbone.Model
  defaults: {
    schedules: [],
    itineraries: []
  }

  changeSchedules: (schedules) ->
    App.Collections.Schedules.remove(@get('schedules'))

    scheduleList = []
    _.each schedules, (schedule) ->
      scheduleList.push( new App.Models.Schedule(schedule) )

    @set('schedules', scheduleList)

    App.Collections.Schedules.add(@get('schedules'))

  changeItineraries: (itineraries) ->
    App.Collections.Itineraries.remove(@get('itineraries'))

    itineraryList = []
    _.each itineraries, (itinerary) ->
      itineraryList.push( new App.Models.Itinerary(itinerary) )

    @set('itineraries', itineraryList)

    App.Collections.Itineraries.add(@get('itineraries'))