class App.IndexView extends Backbone.Marionette.ItemView

  template: App.templates.Index
  
  events:
    "submit form#new_user": "submit"

  ui:
    email: "#user_email"
    password: "#user_password"

  modelEvents:
    "invalid": "onInvalid"

  submit: (e) ->
    e.preventDefault()

    @model.set("email", @ui.email.val())
    @model.set("password", @ui.password.val())

    if @model.isValid()
      @model.save().done( ->
        Backbone.history.navigate("/tasks", true)
        Backbone.trigger("flash:show", {msg: "ログインしました。"})
      ).fail( ->
        alert "ログインに失敗しました"
      )

  onInvalid: (model, error) ->
    alert error
