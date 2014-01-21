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


  fetchPage: (page) ->
    geolocation = Em.GeoLocation.create({autoUpdate: false})
    app_controller = @controllerFor('application')
    args = {
      limit:            10
      from:             page * 10
      query:            app_controller.search_query
      location:         app_controller.search_location
      person_about:     app_controller.person_about
      person_education: app_controller.person_education
      longitude:    geolocation.longitude
      latitude:     geolocation.latitude
    }

    ccc  = @
    cont = @controller
    console.log(cont)
    @get('store').find('job_posting', args).then((job_posting) ->
      ccc.get('job_posting_cache').pushObjects(job_posting.toArray())
      cont.set('loadingMore', false)
      cont.set('page', page + 1)
      cont.get('length')
      if cont.get('recordsCount') == cont.get('length')
        cont.set('noMoreItems', true)
      cont.set('recordsCount', cont.get('length'))
    )