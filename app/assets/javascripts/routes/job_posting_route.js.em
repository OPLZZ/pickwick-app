class PickwickApp.JobPostingRoute extends Em.Route

  model: (params) ->
    cache = @controllerFor('job_postings').get('job_posting_cache')
    if cache != undefined
      item = cache.findProperty('id', params.id)
      if item
        return item

    $.getJSON("http://pickwick-api.dev.vhyza.eu/vacancies/#{params.id}?token=59a3b1a51c80c8db71c9a881d8b23c6e2b41727c").then (response) ->
      PickwickApp.JobPosting.create response.vacancy