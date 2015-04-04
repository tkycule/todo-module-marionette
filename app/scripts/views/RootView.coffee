class App.RootView extends Backbone.Marionette.LayoutView

  template: false
  el: "body"

  regions:
    header: "header"
    main: "#main"

  ui:
    flash: ".alert"

  initialize: ->
    @listenTo(Backbone, "flash:show", @showFlash)
    @listenTo(Backbone, "flash:hide", @hideFlash)

  showFlash: (data) ->

    data = $.extend({type: "info"}, data)

    @ui.flash.removeClass((index, css) ->
      return css.match(/alert-\S+/)
    ).addClass("alert-#{data.type}").show().find("p").html(data.msg)

  hideFlash: ->
    @ui.flash.hide()
  

