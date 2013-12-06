# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View with InfiniteScroll.ViewMixin, PickwickApp.TouchScroll
  templateName: 'job_postings'
  touch_scroll_element: '.infinite-scroll-list'
  swipeOptions:
    direction: Em.OneGestureDirection.Left
    cancelPeriod: 80
    swipeThreshold: 200

  touchMove: (event) ->
    unless $('body').hasClass('push-left')
      super(event)

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
#    if direction is Em.OneGestureDirection.Right
#      @get("controller").send "showMenu"
    if direction is Em.OneGestureDirection.Left
      @get("controller").send "hideMenu"

  didInsertElement: ->
    @setupInfiniteScrollListener()
  willDestroyElement: ->
    @teardownInfiniteScrollListener()
