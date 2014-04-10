# for more details see: http://emberjs.com/guides/views/

class PickwickApp.UserJobPostingView extends Ember.View
  templateName: 'user_job_posting'
  touch_scroll_element: '.infinite-scroll-detail'
  swipeOptions:
    direction: Em.OneGestureDirection.Right

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    @get("controller").send "backToJobPostings" if direction is Em.OneGestureDirection.Right

  didInsertElement: ->
    @jobPostingDidChange()

  jobPostingDidChange:(->

    $('.job_posting.list').removeClass('active')
    job_posting_object = @get('controller.content')

  ).observes('controller.content')
