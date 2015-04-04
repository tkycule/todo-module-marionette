class App.NewUserView extends Backbone.Marionette.ItemView

  template: App.templates.NewUser

  initialize: ->
    @model = new App.User()

  ui:
    email: "#user_email"
    password: "#user_password"
    passwordConfirmation: "#user_password_confirmation"
    formGroup: ".form-group"

  modelEvents:
    "invalid": "onInvalid"

  events:
    "submit form#new_user": "submit"

  submit: (e) ->
    e.preventDefault()

    @model.set("email", @ui.email.val())
    @model.set("password", @ui.password.val())
    @model.set("password_confirmation", @ui.passwordConfirmation.val())

    @ui.formGroup.removeClass("has-error").find(".help-block").html("")

    if @model.isValid()
      @model.save().done =>
        App.session.setUser(@model)
        Backbone.history.navigate("/tasks", true)

  onInvalid: (model, error) ->
    _.each(error, (value, key) ->
      @ui.formGroup.filter(".user_#{key}")
        .addClass("has-error")
        .find(".help-block").html(value)
    , this)
  

