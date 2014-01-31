class PickwickApp.JobPostingsController extends Ember.ArrayController with InfiniteScroll.ControllerMixin
  perPage: 25
  urlForLoadMore: undefined
  loadingError:  false
  likedVisible:  false
  hasLikedJobs:  false
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