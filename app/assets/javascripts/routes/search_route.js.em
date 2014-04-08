class PickwickApp.SearchRoute extends Ember.Route
  redirect: (params)->
    @controllerFor('application').set('search_query', params.query)
    @controllerFor('job_postings').send('search')
    @transitionTo('job_postings.index')