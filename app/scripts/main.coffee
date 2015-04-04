$(document).on("click", "a[href]", (e) ->
  e.preventDefault()
  Backbone.history.navigate($(this).attr("href").substr(1), true)
)

$.ajaxSetup({
  dataType: "json"
  beforeSend: (xhr) ->
    if currentUser = App.session.currentUser()
      xhr.setRequestHeader("Authorization", currentUser.get("authentication_token"))
})

@App = new Mn.Application()
@App.on("start", ->
  new App.Router(controller: new App.Controller())
  Backbone.history.start({pushState: true})
)
