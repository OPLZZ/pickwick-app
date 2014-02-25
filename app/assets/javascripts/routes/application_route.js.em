class PickwickApp.ApplicationRoute extends Ember.Route
  actions:
    goToDetail: (job_posting) ->
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
      @transitionTo "job_posting", job_posting

    backFromDetail: ->
      if @controller.get('likedVisible')
        @transitionTo "job_postings.liked"
      else
        @transitionTo "job_postings"

    backFromMenu: ->
      @transitionTo "job_postings"
      $('#search_query_text_box').blur()
      $('#search_location_box').blur()
      $('#person_about_box').blur()

    searchFromMenu: ->
      @controllerFor('job_postings').send('search')
      @remembered_scroll = 0
      $('#search_query_text_box').blur()
      $('#search_location_box').blur()
      $('#person_about_box').blur()

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
      $('#search_query_text_box').focus()

