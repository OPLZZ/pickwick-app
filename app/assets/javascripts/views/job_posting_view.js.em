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

    #fix - open detail if loading from url
    app = @controller.controllers.application
    app.set "detailVisible", true
    app.pushBody()

    $('#detail_map').hide()

    $('.job_posting.list').removeClass('active')
    job_posting_object = @get('controller.content')


    if job_posting_object != undefined
      $(".job_posting.list[data-id=#{job_posting_object.id}]").addClass('active')

      if $('#detail_map').length > 0 && job_posting_object.get('location.coordinates') && job_posting_object.get('location.coordinates.lat')

        job_posting_location = new google.maps.LatLng(job_posting_object.get('location.coordinates.lat'), job_posting_object.get('location.coordinates.lon'))

        $('#detail_map').show()

        mapOptions = {
          zoom: 15,
          center: job_posting_location,
          panControl: false,
          draggable: false,
          zoomControl: false,
          zoomControlOptions: {
            style: google.maps.ZoomControlStyle.SMALL
          },
          mapTypeControl: false,
          scaleControl: false,
          streetViewControl: false,
          overviewMapControl: false
        }

        if PickwickApp.google_map != undefined
          PickwickApp.google_marker = null
          PickwickApp.google_map = null

        PickwickApp.google_map = new google.maps.Map(document.getElementById('detail_map'), mapOptions)
        PickwickApp.google_marker = new google.maps.Marker({
            position: job_posting_location,
            map: PickwickApp.google_map,
            title:job_posting_object.get('title')
        })
  ).observes('controller.content')
