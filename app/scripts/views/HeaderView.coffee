class App.HeaderView extends Backbone.Marionette.ItemView

  template: false
  el: "header"

  ui:
    isLogin: ".is-login"
    isNotLogin: ".is-not-login"

  modelEvents:
    "change": "change"

  onRender: ->
    @change()

  change: ->
    currentUser = @model.currentUser()

    @ui.isLogin.toggle(!!currentUser)
    @ui.isNotLogin.toggle(!currentUser)

    if currentUser
      @$(".email").html(currentUser.get("email"))
