App = @tcglServer || {}

App.Views.ScheduleList = new ( class ScheduleList extends Backbone.View
  collection: App.Collections.Schedules

  initialize: ->
    @table1 = $('#js-schedule-1')
    @table2 = $('#js-schedule-2')

    @schedules = []

    @pollColor()

  pollColor: ->
    setTimeout =>
      @color()
      @pollColor()
    , 60000

  change: =>
    @removeAll()
    collectionSize = _.size @collection.sorted()

    _.each @collection.sorted(), (schedule, index) =>
      scheduleView = new App.Views.Schedule({model: schedule})

      if index < ( collectionSize / 2 )
        @table1.find('tbody').append(scheduleView.render().el)
      else
        @table2.find('tbody').append(scheduleView.render().el)

      @schedules.push scheduleView

    @color()

  removeAll: ->
    _.each @schedules, (schedule) ->
      schedule.remove()
    @schedules = []

  color: ->
    _.each @schedules, (schedule) ->
      departureTimeEl = $(schedule.el).find('td:nth-child(2)')

      departureTime = parseInt(departureTimeEl.text().split(':').join(''))
      now = parseInt(moment().format('HHmm'))

      if(departureTime < now)
        $(schedule.el).removeClass('success')
        $(schedule.el).addClass('danger')
      else
        $(schedule.el).removeClass('danger')
        $(schedule.el).addClass('success')
)