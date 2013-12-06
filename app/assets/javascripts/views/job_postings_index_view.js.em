# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsIndexView extends Ember.View with InfiniteScroll.ViewMixin
  templateName: 'job_postings_index'
  swipeOptions:
    direction: Em.OneGestureDirection.Left | Em.OneGestureDirection.Right
    cancelPeriod: 100
    swipeThreshold: 10

  touchMove: (event) ->
    event.preventDefault()

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    if direction is Em.OneGestureDirection.Right
      @get("controller").send "goToJobPostingsFromMenu"
    else @get("controller").send "toggleMenu"  if direction is Em.OneGestureDirection.Left


  didInsertElement: ->
    @setupInfiniteScrollListener()
  willDestroyElement: ->
    @teardownInfiniteScrollListener()
