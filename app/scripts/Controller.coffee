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
    @requireLogin =>

      App.filter = filter || "inbox"

      unless @tasksCollection
        @tasksCollection = new App.TasksCollection()
        @tasksCollection.fetch({reset: true})

      if App.rootView.main.currentView instanceof App.TasksView
        App.rootView.main.currentView.render()
      else
        App.rootView.main.show(new App.TasksView(collection: @tasksCollection))


  edit_task: (id) ->
    
  logout: ->
    @requireLogin ->
      App.session.logout()
      Backbone.history.navigate("", true)
      Backbone.trigger("flash:show", {msg: "ログアウトしました。"})

    
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
    
