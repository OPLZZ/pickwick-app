class PickwickApp.JobPostingsRoute extends Em.Route with InfiniteScroll.RouteMixin

  model: ->
    @set('job_posting_cache', Em.A([]))
    @fetchPage(0)
    @get('job_posting_cache')

  actions:
    getMore: ->
      page = @controller.get("page")
      @fetchPage(page)

    fetchPage: ->
      page = @controller.get("page")
      @fetchPage(page)

    search: ->
      @controller.set('loadingMore', true)
      @controller.set('noMoreItems', false)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      @fetchPage(0)

    show_liked: ->
      @set('cache_for_search', Em.A([]))
      for item in @get('job_posting_cache')
        @get('cache_for_search').pushObject(item)

      @controller.set('loadingMore', true)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      for id, item of JSON.parse(localStorage["liked_jobs"])
        item.id = id
        #push object to list of liked jobs
        @get('job_posting_cache').pushObject(PickwickApp.JobPosting.create(item))

    back_from_liked: ->
      @controller.set('loadingMore', false)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      for item in @get('cache_for_search')
        @get('job_posting_cache').pushObject(item)

  fetchPage: (page) ->
    app_controller = @controllerFor('application')
    args = {
      limit:            10
      from:             page * 10
      query:            app_controller.search_query
      location:         app_controller.search_location
      person_about:     app_controller.person_about
      person_education: app_controller.person_education
    }

    if @get('geolocation_object') == undefined
      @set('geolocation_object', Em.GeoLocation.create({autoUpdate: true}))

    if @get('geolocation_object') != undefined
      args.longitude = @get('geolocation_object').longitude
      args.latitude  = @get('geolocation_object').latitude

    ccc  = @
    cont = @controller

    $.ajax(
      method: 'GET'
      dataType: 'json'
      url: "job_postings"
    ).done (data) ->
      postings = data.job_postings.map (job_data) -> PickwickApp.JobPosting.create(job_data)
      ccc.get('job_posting_cache').pushObjects(postings)
