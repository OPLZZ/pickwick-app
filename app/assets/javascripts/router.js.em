# For more information see: http://emberjs.com/guides/routing/

PickwickApp.Router.map ->
  @route("liked_jobs", { path: "/oblibene" })
  @resource('job_postings', ->
    @resource('job_posting', { path: ':id' })
  )
