# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View with InfiniteScroll.ViewMixin, PickwickApp.TouchScroll
  templateName: 'job_postings'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 80
    swipeThreshold: 200

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    console.log("OUTING")
#    if direction is Em.OneGestureDirection.Right
#      @get("controller").send "showMenu"
    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"

  didInsertElement: ->
    @setupInfiniteScrollListener()
  willDestroyElement: ->
    @teardownInfiniteScrollListener()
