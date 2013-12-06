# For more information see: http://emberjs.com/guides/routing/

PickwickApp.Router.map ->
  @resource('job_postings', ->
    @resource('job_posting', { path: ':id' })
  )
