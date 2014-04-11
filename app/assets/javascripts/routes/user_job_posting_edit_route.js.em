class PickwickApp.UserJobPostingEditRoute extends Em.Route

  model: (params) ->
    console.log(params)
    cache = @controllerFor('user_job_postings')
    if cache != undefined
      item = cache.hasItem('id', params.id)
      if item
        return item

    @transitionTo('user_job_postings')
