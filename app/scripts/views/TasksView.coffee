class App.TasksView extends Backbone.Marionette.CompositeView

  template: App.templates.Tasks
  childView: App.TaskView
  childViewContainer: "#tasks"

  ui:
    title: "#task_title"
    inboxCount: ".inbox-count"
    completedCount: ".completed-count"
    deletedCount: ".deleted-count"
    menuInbox: "#menu-inbox"
    menuCompleted: "#menu-completed"
    menuDeleted: "#menu-deleted"

  events:
    "submit #new_task": "create"

  collectionEvents:
    "add change sync": "updateCount"

  onRender: ->
    @updateCount()
    @toggleCurrent()

  filter: (child, index, collection) ->
    child.get("aasm_state") == App.filter

  create: (e) ->
    e.preventDefault()

    task = new App.Task(title: @ui.title.val())
    if task.isValid()
      task.save().done( =>
        @collection.add(task)
        Backbone.history.navigate('/tasks', true)
        Backbone.trigger("flash:show", {msg: "作成しました。"})
      )
      @ui.title.val("")

    return false

  updateCount: ->
    @ui.inboxCount.html(@collection.inboxes().length)
    @ui.completedCount.html(@collection.completed().length)
    @ui.deletedCount.html(@collection.deleted().length)
    
  toggleCurrent: ->
    @ui.menuInbox.toggleClass("current", App.filter == "inbox")
    @ui.menuCompleted.toggleClass("current", App.filter == "completed")
    @ui.menuDeleted.toggleClass("current", App.filter == "deleted")

