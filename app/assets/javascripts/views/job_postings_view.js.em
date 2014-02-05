# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View with InfiniteScroll.ViewMixin
  templateName: 'job_postings'
  scrolling_element: '.infinite-scroll-list'

  didInsertElement: ->
    @setupInfiniteScrollListener()
    if localStorage["liked_jobs"] != undefined && Object.keys(JSON.parse(localStorage["liked_jobs"])).length > 0
      @controller.set('hasLikedJobs', true)

    #do first search when list was inserted
    @controller.send('search')

  willDestroyElement: ->
    @teardownInfiniteScrollListener()
