# for more details see: http://emberjs.com/guides/views/

PickwickApp.google_map = undefined
PickwickApp.google_marker = undefined

class PickwickApp.JobPostingView extends Ember.View
  templateName: 'job_posting'
  touch_scroll_element: '.infinite-scroll-detail'
  swipeOptions:
    direction: Em.OneGestureDirection.Right

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    @get("controller").send "backToJobPostings" if direction is Em.OneGestureDirection.Right

  didInsertElement: ->
    @jobPostingDidChange()

  jobPostingDidChange:(->

    $('#detail_map').hide()

    $('.job_posting.list').removeClass('active')
    job_posting_object = @get('controller.content')

    if job_posting_object != undefined

      $(".job_posting.list[data-id=#{job_posting_object.id}]").addClass('active')

      if $('#detail_map').length > 0 && job_posting_object.get('location.coordinates') && job_posting_object.get('location.coordinates.lat')

        job_posting_location = "#{job_posting_object.get('location.coordinates.lat')},#{job_posting_object.get('location.coordinates.lon')}"

        $('#detail_map').show()
        zoom = 12

        if job_posting_object.distance && job_posting_object.distance < 10
          zoom = 15

        $('#detail_map').html("<img src='http://maps.googleapis.com/maps/api/staticmap?ll=#{job_posting_location}&zoom=#{zoom}&size=640x350&maptype=roadmap&markers=color:red%7Csize:big%7C#{job_posting_location}&sensor=false'>")

  ).observes('controller.content')
