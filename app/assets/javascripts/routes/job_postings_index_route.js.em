class PickwickApp.JobPostingsIndexRoute extends Em.Route
  model: ->
    unless @get('job_postings_cache')
      @set('job_postings_cache', @get('store').findAll('job_posting'))
    @get('job_postings_cache')
