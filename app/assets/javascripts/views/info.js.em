# for more details see: http://emberjs.com/guides/views/

class PickwickApp.InfoView extends Ember.View
  templateName: 'info'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 80
    swipeThreshold: 200


#  swipeEnd: (recognizer, evt) ->
#    direction = recognizer.get("swipeDirection")#

#    if direction is Em.OneGestureDirection.Left
#      @get("controller").send "hideInfo"
