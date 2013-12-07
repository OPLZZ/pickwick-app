class PickwickApp.JobPostingsController extends Ember.ArrayController with InfiniteScroll.ControllerMixin
  perPage: 10
  page: 0

  search: (args) ->
    @set('model', [])
    geolocation = Em.GeoLocation.create({autoUpdate: false})
    args.longitude = geolocation.longitude
    args.latitude  = geolocation.latitude
    @set('job_postings_cache', @get('store').find('job_posting', args))
    @set('model', @get('job_postings_cache'))