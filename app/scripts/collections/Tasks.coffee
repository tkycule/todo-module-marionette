class App.TasksCollection extends Backbone.Collection

  model: App.Task
  url: "#{App.env.apiHost}/v1/tasks"

  comparator: (model) ->
    0 - model.get('id')
  
  inboxes: ->
    return @filtered('inbox')

  completed: ->
    return @filtered('completed')

  deleted: ->
    return @filtered('deleted')

  filtered: (state) ->
    _tasks = @filter((task) -> return task.get('aasm_state') == state)
    return _tasks
