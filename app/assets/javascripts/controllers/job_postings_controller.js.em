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
      @get('target').send('search')

  hasItem: (propName, value) ->
    try
      return @findProperty(propName, value)
    catch error
      console.log(error)
      return undefined

  addItem: (item) ->
    @pushObject item

  removeItem: (propName, value) ->
    item = @hasItem(propName, value)
    if item != undefined
      @removeObject item
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
    unless @hasItem('id', item.id)
      @similar_jobs.pushObject item
      return true
    return false

  removeSimilarItem: (propName, value) ->
    item = @hasItem(propName, value)
    if item != undefined
      @similar_jobs.removeObject item
      return true
    else
      console.log("Job: #{propName} -> #{value} not removed ->#{item}")
      return false