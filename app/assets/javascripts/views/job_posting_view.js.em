# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingView extends Ember.View
  templateName: 'job_posting'
  swipeOptions:
    direction: Em.OneGestureDirection.Right
    cancelPeriod: 100
    swipeThreshold: 10

  touchMove: (event) ->
    event.preventDefault()

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    @get("controller").send "backToJobPostings"  if direction is Em.OneGestureDirection.Right
