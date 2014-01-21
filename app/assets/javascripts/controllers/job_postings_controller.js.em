class PickwickApp.JobPostingsController extends Ember.ArrayController with InfiniteScroll.ControllerMixin
  perPage: 10
  page: 1

  search: () ->
    @set("page", 0)
    @set('recordsCount', -1)
    @get('target').send('search')
