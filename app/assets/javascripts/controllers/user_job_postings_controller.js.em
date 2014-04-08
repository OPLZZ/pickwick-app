class PickwickApp.UserJobPostingsController extends Ember.ArrayController
  perPage: 25
  urlForLoadMore: undefined
  loadingError:  false
  hasLikedJobs:  false
  loadingSimilar: true
  loadingOtherSimilar: true
  similar_jobs:  Em.A([])
  searchQuery: ''
  actions: 
    search: () ->
      @set("page", 0)
      @set('recordsCount', -1)
      @get('target').send('search')

  hasItem: (propName, value) ->
    try
      return @findProperty(propName, value)
    catch error
      console.log(error)
      return undefined

  addItem: (item) ->
    this_controller = @
    Ember.run ->
      this_controller.pushObject item

  removeItem: (propName, value) ->
    item = @hasItem(propName, value)
    if item != undefined
      this_controller = @
      Ember.run ->
        this_controller.removeObject item
      return true
    else
      console.log("Job: #{propName} -> #{value} not removed ->#{item}")
      return false
