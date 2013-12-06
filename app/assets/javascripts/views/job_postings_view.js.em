# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View with InfiniteScroll.ViewMixin, PickwickApp.TouchScroll
  templateName: 'job_postings'
  swipeOptions:
    direction: Em.OneGestureDirection.Left | Em.OneGestureDirection.Right
    cancelPeriod: 80
    swipeThreshold: 80

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")

    console.log(@get("controller"))
    console.log(direction)
    if direction is Em.OneGestureDirection.Right
      @get("controller").send "showMenu" #"goToJobPostingsFromMenu"
    else if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"


  didInsertElement: ->
    @setupInfiniteScrollListener()
  willDestroyElement: ->
    @teardownInfiniteScrollListener()
