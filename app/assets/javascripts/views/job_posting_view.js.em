# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingView extends Ember.View with PickwickApp.TouchScroll
  templateName: 'job_posting'
  swipeOptions:
    direction: Em.OneGestureDirection.Right
    cancelPeriod: 80
    swipeThreshold: 200

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    console.log("OUTING DETAIL")
    @get("controller").send "backToJobPostings" if direction is Em.OneGestureDirection.Right
