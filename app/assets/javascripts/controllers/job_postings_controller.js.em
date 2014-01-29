class PickwickApp.JobPostingsController extends Ember.ArrayController with InfiniteScroll.ControllerMixin
  perPage: 25
  urlForLoadMore: undefined
  loadingError: false
  likedVisible:  false
  hasLikedJobs:  false
  search: () ->
    @set("page", 0)
    @set('recordsCount', -1)
    @get('target').send('search')
