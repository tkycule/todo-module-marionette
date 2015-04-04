class App.TaskView extends Backbone.Marionette.ItemView

  tagName: "li"
  className: "task clearfix"
  template: App.templates.Task

  events:
    "click .task-actions a": "taskAction"

  modelEvents:
    "sync": "render"

  templateHelpers: -> {
    showComplete: @model.get("aasm_state") == "inbox"
    showDelete: @model.get("aasm_state") != "deleted"
    showRevert: @model.get("aasm_state") != "inbox"
  }

  flashMessages:
    complete: "完了にしました。"
    delete: "ゴミ箱に入れました。"
    revert: "収集箱に戻しました。"

  taskAction: (event) ->
    action = $(event.currentTarget).data("action")
    @model[action]( =>
      this.remove()
      Backbone.trigger("flash:show", {msg: @flashMessages[action]})
    )
  

