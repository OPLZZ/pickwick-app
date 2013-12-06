# for more details see: http://emberjs.com/guides/views/

class PickwickApp.SearchMenuView extends Ember.View
  templateName: 'search_menu'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 100
    swipeThreshold: 10

  touchMove: (event) ->
    #event.preventDefault()

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")

    console.log(@get("controller"))
    console.log(direction)
    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"
