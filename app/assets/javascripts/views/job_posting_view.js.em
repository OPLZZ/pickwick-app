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

  jobPostingDidChange:(->

    $('.job_posting.list').removeClass('active')
    job_posting_object = @get('controller.content')
    if job_posting_object != undefined
      $(".job_posting.list[data-id=#{job_posting_object.id}]").addClass('active')

      if $('#detail_map').length > 0 && job_posting_object.get('location.coordinates') && job_posting_object.get('location.coordinates.lat')

        job_posting_location = new google.maps.LatLng(job_posting_object.get('location.coordinates.lat'), job_posting_object.get('location.coordinates.lon'))

        $('#detail_map').show()

        if PickwickApp.google_map == undefined
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


          PickwickApp.google_map = new google.maps.Map(document.getElementById('detail_map'), mapOptions)
          PickwickApp.google_marker = new google.maps.Marker({
              position: job_posting_location,
              map: PickwickApp.google_map,
              title:job_posting_object.get('title')
          })
        else
          PickwickApp.google_map.setCenter(job_posting_location)
          PickwickApp.google_map.setZoom(15)
          PickwickApp.google_marker.setPosition(job_posting_location)

      else
        $('#detail_map').hide()

  ).observes('controller.content')
