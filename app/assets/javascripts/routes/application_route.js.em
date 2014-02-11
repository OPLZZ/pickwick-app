class PickwickApp.ApplicationRoute extends Ember.Route
  actions:
    goToDetail: (job_posting) ->
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
      @transitionTo "job_posting", job_posting

    backFromDetail: ->
      @transitionTo "job_postings"

    backFromMenu: ->
      @transitionTo "job_postings"

    searchFromMenu: ->
      @controllerFor('job_postings').send('search')
      $('#search_query_text_box').blur()
      localStorage["search_query"]     = @controller.search_query
      localStorage["search_location"]  = @controller.search_location
      localStorage["person_about"]     = @controller.person_about
      localStorage["person_education"] = @controller.person_education
      @transitionTo "job_postings"

    goToLiked: ->
      @transitionTo "job_postings.liked"

    goToIndex: ->
      @transitionTo "job_postings"

    goToInfo: ->
      @transitionTo "job_postings.info"

    goToMenu: ->
      @transitionTo "job_postings.search"

