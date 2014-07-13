App = @tcglServer || {}

App.Collections.Schedules = new ( class Schedules extends Backbone.Collection
  model: App.Models.Schedule

  sorted: ->
    _.sortBy @models, (schedule) ->
      parseInt(schedule.get('departure').format("HHmm"))
)
