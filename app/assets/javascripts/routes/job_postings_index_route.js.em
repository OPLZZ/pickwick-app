class PickwickApp.JobPostingsIndexRoute extends Em.Route
  model: ->
    @get('store').findAll('job_posting')
