class PickwickApp.ApplicationController extends Em.Controller
  menuVisible: false
  pushBody: ->
    return $(".ember-application").addClass("push-right")  if @get("menuVisible")
    $("body").removeClass "push-right"
