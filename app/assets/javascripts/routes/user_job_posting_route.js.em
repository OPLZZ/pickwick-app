class PickwickApp.UserJobPostingRoute extends Em.Route

  model: (params) ->
    console.log(params)
    cache = @controllerFor('user_job_postings')
    if cache != undefined
      item = cache.hasItem('id', params.id)
      if item
        return item

    output = @get_job_posting_from_url(params.id)
    output

  get_job_posting_from_url: (id) ->
    this_route = @
    $.getJSON("#{window.PickwickApp.user_url_point}/vacancies/#{id}?token=#{window.PickwickApp.user_token}").then (response) ->
      Ember.run ->
        this_route.load_job_posting(response.vacancy)

  load_job_posting: (data) ->
    PickwickApp.JobPosting.create data
