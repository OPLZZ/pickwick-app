# for more details see: http://emberjs.com/guides/views/

class PickwickApp.JobPostingView extends Ember.View
  templateName: 'job_posting'
  touch_scroll_element: '.infinite-scroll-detail'
  swipeOptions:
    direction: Em.OneGestureDirection.Right
    cancelPeriod: 80
    swipeThreshold: 200

  swipeEnd: (recognizer, evt) ->
    direction = recognizer.get("swipeDirection")
    @get("controller").send "backToJobPostings" if direction is Em.OneGestureDirection.Right

  jobPostingDidChange:(->
    job_posting_object = @get('controller.content')

    console.log(job_posting_object)
    if job_posting_object != undefined && $('#detail_map').length > 0
      job_posting_location = new google.maps.LatLng(-34.397, 150.644)
      mapOptions = {
        zoom: 8,
        center: job_posting_location,
        panControl: false,
        zoomControl: false,
        zoomControlOptions: {
          style: google.maps.ZoomControlStyle.SMALL
        },
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        overviewMapControl: false
      }

      map = new google.maps.Map(document.getElementById('detail_map'), mapOptions)

      marker = new google.maps.Marker({
          position: job_posting_location,
          map: map,
          title:job_posting_object.get('title')
      })

      console.log(mapOptions)

  ).observes('controller.content')
