# for more details see: http://emberjs.com/guides/views/

class PickwickApp.SearchMenuView extends Ember.View
  templateName: 'search_menu'
  swipeOptions:
    direction: Em.OneGestureDirection.Left

  didInsertElement: ->
    $('textarea').autoGrow()

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")

    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"
