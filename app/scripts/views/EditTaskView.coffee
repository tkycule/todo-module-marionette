class App.EditTaskView extends Backbone.Marionette.ItemView

  template: App.templates.EditTask

  ui:
    title: "#task_title"
    memo: "#task_memo"
    formGroup: ".form-group"

  events:
    "submit": "onSubmit"

  modelEvents:
    "invalid": "onInvalid"

  onSubmit: (e) ->
    e.preventDefault()

    @model.set("title", @ui.title.val())
    @model.set("memo", @ui.memo.val())

    @ui.formGroup.removeClass("has-error").find(".help-block").html("")

    if @model.isValid()
      @model.save().done(->
        Backbone.history.navigate("/tasks", true)
        Backbone.trigger("flash:show", {msg: "更新しました。"})
      )

    return false

  onInvalid: (model, error) ->
    _.each(error, (value, key) ->
      @ui.formGroup.filter(".task_#{key}")
        .addClass("has-error")
        .find(".help-block").html(value)
    , this)
  

