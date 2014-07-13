App = @tcglServer || {}

class App.Views.NearLine extends Backbone.View
  template: _.template(
    "<a href='#' class='js-add_linha' data-linha='<%= id %>'>"+
    "<icon class='fa fa-plus'></i>"+
    "</a> <%= code_name %><br />"),

  initialize: (line) ->
    @line = line

  render: ->
    @$el.html(@template(@line))
    return @

  remove: ->
    @$el.remove()
