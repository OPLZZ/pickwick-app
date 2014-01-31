# for more details see: http://emberjs.com/guides/views/

class PickwickApp.LikedJobsView extends Ember.View with InfiniteScroll.ViewMixin
  templateName: 'liked_jobs'
  scrolling_element: '.infinite-scroll-list'

  didInsertElement: ->
    @setupInfiniteScrollListener()

  willDestroyElement: ->
    @teardownInfiniteScrollListener()
