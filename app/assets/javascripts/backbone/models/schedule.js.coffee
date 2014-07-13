App = @tcglServer || {}

class App.Models.Schedule extends Backbone.Model
  constructor: (schedule) ->
    schedule.departure = @formatDate(schedule.departure)
    schedule.arrive = @formatDate(schedule.arrive)
    super

  formatDate: (dateTime) ->
    moment(dateTime).zone("0000")
