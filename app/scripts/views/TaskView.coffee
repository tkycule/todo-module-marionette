class App.TaskView extends Backbone.Marionette.ItemView

  tagName: "li"
  className: "task clearfix"
  template: App.templates.Task

  ui:
    taskComplete: ".task-complete"
    taskDelete: ".task-delete"
    taskRevert: ".task-revert"

  events:
    "click .task-actions a": "taskAction"

  modelEvents:
    "sync": "render"

  onRender: ->
    @ui.taskComplete.toggle(@model.get("aasm_state") == "inbox")
    @ui.taskDelete.toggle(@model.get("aasm_state") != "deleted")
    @ui.taskRevert.toggle(@model.get("aasm_state") != "inbox")

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
  

