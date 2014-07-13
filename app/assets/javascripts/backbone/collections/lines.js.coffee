App = @tcglServer || {}

App.Collections.Lines = new ( class Lines extends Backbone.Collection
  model: App.Models.Line
)
