# for more details see: http://emberjs.com/guides/views/

class PickwickApp.UserJobPostingsView extends Ember.View
  templateName: 'user_job_postings'
  touch_scroll_element: '.infinite-scroll-detail'
  swipeOptions:
    direction: Em.OneGestureDirection.Right

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    @get("controller").send "backToJobPostings" if direction is Em.OneGestureDirection.Right

  setupInView: ->
    controller = @controller
    $('.in_view_postings').bind('inview', (event, isInView, visiblePartX, visiblePartY) ->
      if (isInView)
        controller.send('inViewShown')
    )

  teardownInView: ->
    $('.in_view_postings').unbind('inview')

  willDestroyElement: ->
    @teardownInView()


  didInsertElement: ->
    @setupInView()
    @jobPostingDidChange()

  jobPostingDidChange:(->

    $('.job_posting.list').removeClass('active')
    job_posting_object = @get('controller.content')

  ).observes('controller.content')
