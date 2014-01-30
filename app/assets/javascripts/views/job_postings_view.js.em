# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View with InfiniteScroll.ViewMixin
  templateName: 'job_postings'
  scrolling_element: '.infinite-scroll-list'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 80
    swipeThreshold: 200

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
#    if direction is Em.OneGestureDirection.Right
#      @get("controller").send "showMenu"
    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"

  didInsertElement: ->
    @setupInfiniteScrollListener()
    if localStorage["liked_jobs"] != undefined && Object.keys(JSON.parse(localStorage["liked_jobs"])).length > 0
      @controller.set('hasLikedJobs', true)

  willDestroyElement: ->
    @teardownInfiniteScrollListener()
