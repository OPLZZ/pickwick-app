class PickwickApp.SearchRoute extends Ember.Route
  redirect: (params)->
    @controllerFor('application').set('search_query', params.query)
    @transitionTo('job_postings.index')