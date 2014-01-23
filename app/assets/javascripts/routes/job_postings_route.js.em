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
        #load record from hash into store
        this.get('store').pushPayload('job_posting', {job_postings: [item] })
        #push object to list of liked jobs
        @get('job_posting_cache').pushObject(this.get('store').find("job_posting", id))

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
      geolocation = Em.GeoLocation.create({autoUpdate: true})

    if @get('geolocation_object') != undefined
      args.longitude = @get('geolocation_object').longitude
      args.latitude  = @get('geolocation_object').latitude

    ccc  = @
    cont = @controller
    @get('store').find('job_posting', args).then((job_posting) ->
      ccc.get('job_posting_cache').pushObjects(job_posting.toArray())
      #set liked status from local storage
      if localStorage["liked_jobs"] == undefined
        liked_jobs    = {}
      else
        liked_jobs    = JSON.parse(localStorage["liked_jobs"])
      for job_posting in ccc.get('job_posting_cache')
        if liked_jobs[job_posting.id] != undefined
          job_posting.set("is_liked", true)

      cont.set('loadingMore', false)
      cont.set('page', page + 1)
      cont.get('length')
      if cont.get('recordsCount') == cont.get('length')
        cont.set('noMoreItems', true)
      cont.set('recordsCount', cont.get('length'))
    )