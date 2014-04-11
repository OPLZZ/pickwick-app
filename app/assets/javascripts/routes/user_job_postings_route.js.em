class PickwickApp.UserJobPostingsRoute extends Em.Route

  model: ->
    @set('job_posting_cache', Em.A([]))
    @get('job_posting_cache')

  actions:
    search_user: ->
      @controller.set('noMoreItems', false)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      @fetchPage(true)

    getMore: ->
      @fetchPage()

    fetchPage: ->
      @fetchPage()

    inViewShown: ->
      return if @controller.get('noMoreItems')
      return if @controller.get('loadingMore')
      @controller.set('loadingMore', true)
      @fetchPage()

    tryAgain: ->
      if @controllerFor('job_postings').get('urlForLoadMore') == undefined
        @fetchPage()
      else
        @fetchPage()

  addJobPostingFromAjax: (job_posting) ->
    controller = @controllerFor('user_job_postings')
    controller.addItem(job_posting)

  loadDataFromAjax: (data) ->
    controller = @controllerFor('user_job_postings')
    if data.total == 0
      controller.set('loadingMore', false)
      controller.set('noMoreItems', true)
    else
      postings = data.job_postings.map (job_data) -> PickwickApp.JobPosting.create(job_data)

      for job_posting in postings
        @addJobPostingFromAjax(job_posting)

      #next loading---
      controller.set('noMoreItems', true)

      #stop loading more
      controller.set('loadingMore', false)

  user_token: ->
    app_controller = @controllerFor('application')
    if app_controller.user
      app_controller.user.token
    else
      ""

  user_id: ->
    app_controller = @controllerFor('application')
    if app_controller.user
      app_controller.user.id
    else
      ""

  fetchPage: () ->
    controller = @controllerFor('user_job_postings')

    route = @
    controller.set('loadingMore', true)
    #hide error
    controller.set('loadingError', false)

    url = "#{window.PickwickApp.user_url_point}/users/#{@user_id()}/job_postings"

    $.ajax(
      method: 'GET'
      dataType: 'json'
      url: url
      headers: { 
        'Application-Token': window.PickwickApp.user_api_token
        'User-Token': @user_token()
      }
      cache: false
    ).done( (data) ->
      route.loadDataFromAjax(data)
    ).error (error)->
      #show loading error
      controller.set('loadingError', true)
