class PickwickApp.JobPostingsController extends Ember.ArrayController
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
      Ember.run ->
        PickwickApp.__container__.lookup('route:job_postings').send('search')

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

  hasSimilarItem: (propName, value) ->
    try
      return @similar_jobs.findProperty(propName, value)
    catch error
      console.log(error)
      return undefined

  addSimilarItem: (item) ->
    #add only if it doesn't exists in main array
    unless @hasSimilarItem('id', item.id) || @hasItem('id', item.id)
      this_controller = @
      Ember.run ->
        this_controller.similar_jobs.pushObject item
      return true
    return false

  removeSimilarItem: (propName, value) ->
    item = @hasSimilarItem(propName, value)
    if item != undefined
      this_controller = @
      Ember.run ->
        this_controller.similar_jobs.removeObject item
      return true
    else
      console.log("Job: #{propName} -> #{value} not removed ->#{item}")
      return false