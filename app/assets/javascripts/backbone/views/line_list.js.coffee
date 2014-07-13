App = @tcglServer || {}

class App.Views.LineList extends Backbone.View
  el: $('#new_access')

  events:
    'cocoon:after-insert': 'addOne'
    'cocoon:before-remove': 'removeOne'

  initialize: ->
    @collection = App.Collections.Lines
    @schedules = App.Collections.Schedules

    @counterId = 0

    $('.nested-fields').each (index, lines) =>
      @addOne('', lines)

  addOne: (e, insertedItem) =>
    $(insertedItem).prop('id', "line-#{@counterId}")

    line = new App.Models.Line({id: @counterId})
    lineItem = new App.Views.Line({el: $(insertedItem), model: line})
    @collection.add(line)

    @counterId++

  removeOne: (e, removedItem) =>
    id = parseInt($(removedItem).prop('id').split('-')[1])
    @collection.remove(@collection.get(id))
