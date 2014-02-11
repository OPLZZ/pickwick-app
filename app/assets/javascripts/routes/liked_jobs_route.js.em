class PickwickApp.LikedJobsRoute extends Em.Route
  model: ->
    @set('liked_jobs_cache', Em.A([]))
    @get('liked_jobs_cache')
