App = @tcglServer || {}

class App.Views.Schedule extends Backbone.View
  template: _.template('<td><%= line %></td>' +
    '<td><%= departure.format("HH:mm") %></td>' +
    '<td><%= arrive.format("HH:mm") %></td>' +
    '<td><%= via %></td>'),

  tagName: 'tr',

  render: ->
    @$el.html(@template(@model.toJSON()))
    return @