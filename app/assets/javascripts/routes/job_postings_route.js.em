class PickwickApp.JobPostingsRoute extends Em.Route
  model: ->
    unless @get('job_postings_cache')
      @set('job_postings_cache', @get('store').findAll('job_posting'))
    @get('job_postings_cache')

  actions:
    getMore: ->
      nextPage = @controller.get("page") + 1
      perPage = @controller.get("perPage")
      items = undefined
      items = @fetchPage(nextPage, perPage)
      @controller.send('gotMore', items, nextPage)

  fetchPage: (page, perPage) ->
    geolocation = Em.GeoLocation.create({autoUpdate: false})
    app_controller = @controllerFor('application')
    args = {
      query:            app_controller.search_query
      location:         app_controller.search_location
      person_about:     app_controller.person_about
      person_education: app_controller.person_education
      longitude:    geolocation.longitude
      latitude:     geolocation.latitude
    }
    items = Em.A([])
    firstIndex = (page - 1) * perPage
    lastIndex = page * perPage
    items

