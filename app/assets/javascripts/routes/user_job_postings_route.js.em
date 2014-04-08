class PickwickApp.UserJobPostingsRoute extends Em.Route

  model: ->
    @set('job_posting_cache', Em.A([]))
    @get('job_posting_cache')

  actions:
    getMore: ->
      @fetchPage(false)

    fetchPage: ->
      @fetchPage(false)

    inViewShown: ->
      return if @controller.get('noMoreItems')
      return if @controller.get('loadingMore')
      @controller.set('loadingMore', true)
      @fetchPage()

    tryAgain: ->
      if @controllerFor('job_postings').get('urlForLoadMore') == undefined
        @fetchPage(true)
      else
        @fetchPage(false)

  addJobPostingFromAjax: (job_posting) ->
    controller = @controllerFor('own_job_postings')
    controller.addItem(job_posting)

  loadDataFromAjax: (data) ->
    controller = @controllerFor('own_job_postings')
    if data.total == 0
      controller.set('loadingMore', true)
    else
      postings = data.vacancies.map (job_data) -> PickwickApp.JobPosting.create(job_data)

      for job_posting in postings
        @addJobPostingFromAjax(job_posting)

      #next loading---
      if data.links && data.links.next
        controller.set('urlForLoadMore', data.links.next)
      else
        controller.set('noMoreItems', true)

      #stop loading more
      controller.set('loadingMore', false)

  getUrlForFetch: (search) ->
    controller = @controllerFor('job_postings')
    if search
      #clear previous search
      controller.set('urlForLoadMore', undefined)

      return "#{window.PickwickApp.user_url_point}/vacancies"
    else if controller.get('urlForLoadMore') != undefined
      return controller.get('urlForLoadMore')
    else
      return "#{window.PickwickApp.user_url_point}/vacancies"

  fetchPage: (search, similar = false) ->
    controller = @controllerFor('job_postings')
    route = @
    controller.set('loadingMore', true)
    #hide error
    controller.set('loadingError', false)

    url = @getUrlForFetch(search)

    args.token    = "#{window.PickwickApp.user_api_token}"
    args.per_page = controller.get('perPage')

    $.ajax(
      method: 'GET'
      dataType: 'json'
      url: url
      data: args
      cache: false
    ).done( (data) ->
      route.loadDataFromAjax(data)
    ).error (error)->
      #show loading error
      controller.set('loadingError', true)
