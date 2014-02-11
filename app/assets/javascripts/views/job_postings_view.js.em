# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingsView extends Ember.View
  templateName: 'job_postings'
  scrolling_element: '.infinite-scroll-list'

  didInsertElement: ->
    @setupInView()
    if localStorage["liked_jobs"] != undefined && Object.keys(JSON.parse(localStorage["liked_jobs"])).length > 0
      @controller.set('hasLikedJobs', true)

    #do first search when list was inserted
    @controller.send('search')

  willDestroyElement: ->
    @teardownInView()

  setupInView: ->
    controller = @controller
    $('.in_view_postings').bind('inview', (event, isInView, visiblePartX, visiblePartY) ->
      if (isInView)
        controller.send('inViewShown')
    )

  teardownInView: ->
    $('.in_view_postings').unbind('inview')