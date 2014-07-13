App = @tcglServer || {}

class App.Views.Line extends Backbone.View
  events:
    'change': 'change'

  initialize: ->
    @lineSelect = @$('.js-line_select')
    @daySelect = @$('.js-day_select')
    @originSelect = @$('.js-origin_select')
    @destinationSelect = @$('.js-destination_select')

    @lineSelect.on 'change', @lineChange
    @daySelect.on 'change', @dayChange
    @originSelect.on 'change', @originChange
    @destinationSelect.on 'change', @destinationChange

    @itineraryList = new App.Views.ItineraryList()

    @listenTo(@model, 'remove', @remove)
    @listenTo(@model, 'change:line', @changeLine)

    @schedules = []
    @lineChange()

  lineChange: =>
    @model.set('line', @lineSelect.val())
    App.Collections.Lines.trigger 'change:line_id'

    $.ajax("/lines/#{@model.get('line')}"+
           "/days", {
    success: (res) =>
      @fillDays(res[0])
      @fillOrigins(res[1])
      @fillDestinations(res[2])
      @scheduleChange()
      @itineraryChange()
    })

  dayChange: =>
    @model.set('day', @daySelect.val())

    $.ajax("/lines/#{@model.get('line')}"+
           "/days/#{@model.get('day')}"+
           "/origins", {
    success: (res) =>
      @fillOrigins(res[0])
      @fillDestinations(res[1])
      @scheduleChange()
    })

  originChange: =>
    @model.set('origin', @originSelect.val())

    $.ajax("/lines/#{@model.get('line')}"+
           "/days/#{@model.get('day')}"+
           "/origins/#{@model.get('origin')}"+
           "/destinations", {
    success: (res) =>
      @fillDestinations(res[0])
      @scheduleChange()
    })

  destinationChange: =>
    @model.set('destination', @destinationSelect.val())

    @scheduleChange()

  fillDays: (days) ->
    @daySelect.html('')
    @model.set('day', days[0].id)

    _.each days, (day) =>
      dayEl = $("<option />").val(day.id).text(day.name)

      if moment().day() > 0 and moment().day() < 6 and day.id == 0
        dayEl.prop('selected', 'selected')
      else if moment().day() == 6 and day.id == 1
        dayEl.prop('selected', 'selected')
      else
        dayEl.prop('selected', 'selected')

      @daySelect.append(dayEl)

  fillOrigins: (origins) ->
    @originSelect.html('')
    @model.set('origin', origins[0].id)

    _.each origins, (origin) =>
      @originSelect.append($("<option />").val(origin.id).text(origin.name))

  fillDestinations: (destinations) ->
    @destinationSelect.html('')
    @model.set('destination', destinations[0].id)

    _.each destinations, (destination) =>
      @destinationSelect.append($("<option />")
                        .val(destination.id)
                        .text(destination.name))

  scheduleChange: ->
    $.ajax("/lines/#{@model.get('line')}"+
           "/days/#{@model.get('day')}"+
           "/origins/#{@model.get('origin')}"+
           "/destinations/#{@model.get('destination')}/schedules", {
    success: (res) =>
      @model.changeSchedules(res)
      App.Views.ScheduleList.change()
    })

  itineraryChange: ->
    $.ajax("/lines/#{@model.get('line')}"+
           "/itineraries", {
    success: (res) =>
      @model.changeItineraries(res)
      @itineraryList.change()
    })