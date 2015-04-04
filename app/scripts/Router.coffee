class App.Router extends Backbone.Marionette.AppRouter

  appRoutes:
    "": "index"
    "users/new": "new_user"
    "tasks(/:filter)": "tasks"
    "tasks/:id/edit": "edit_task"
    "logout": "logout"

