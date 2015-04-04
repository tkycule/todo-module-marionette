class App.Controller extends Backbone.Marionette.Controller

  initialize: ->

    App.session = new App.Session()

    App.rootView = new App.RootView()
    App.rootView.render()
    new App.HeaderView(model: App.session).render()

  index: ->
    @skipLogin ->
      App.rootView.main.show(new App.IndexView(model: App.session))

  new_user: ->
    @skipLogin ->
      App.rootView.main.show(new App.NewUserView())

  tasks: (filter) ->

  edit_task: (id) ->
    
  logout: ->
    
  skipLogin: (callback) ->
    unless App.session.currentUser()
      callback.call(this)
    else
      Backbone.history.navigate("/tasks", true)

  requireLogin: (callback) ->
    if App.session.currentUser()
      callback.call(this)
    else
      Backbone.history.navigate("/", true)
    
