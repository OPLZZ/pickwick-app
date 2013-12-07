class PickwickApp.ApplicationController extends Em.Controller
  menuVisible: false
  detailVisible: false
  search_query: ''

  pushBody: ->
    if @get("menuVisible")
      return $(".ember-application").addClass("push-right")
    else if @get("detailVisible")
      return $(".ember-application").addClass("push-left")
    $("body").removeClass "push-right"
    $("body").removeClass "push-left"
