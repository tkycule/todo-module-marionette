class App.Task extends Backbone.Model

  urlRoot: "#{App.env.apiHost}/v1/tasks"

  defaults:
    aasm_state: "inbox"
  
  complete: (callback) ->
    @_changeState(@url() + "/complete", "PUT", callback)

  delete: (callback) ->
    @_changeState(@url(), "DELETE", callback)

  revert: (callback) ->
    @_changeState(@url() + "/revert", "PUT", callback)
    
  _changeState: (url, type, callback) ->
    $.ajax(
      url: url
      type: type
    ).done((result) =>
      @set("aasm_state", result.aasm_state)
      callback.call()
    )

  validate: ->

    errors = {}

    if @get("title") == ""
      errors.title  = "入力してください"
    
    return errors if !_.isEmpty(errors)
