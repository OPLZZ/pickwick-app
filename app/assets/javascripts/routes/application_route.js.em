class PickwickApp.ApplicationRoute extends Ember.Route
  actions:
    goToDetail: (job_posting) ->
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
      @transitionTo "job_posting", job_posting
      @controller.set "menuVisible", false
      @controller.set "infoVisible", false
      @controller.set "detailVisible", true
      @controller.pushBody()

    backFromDetail: ->
      @transitionTo "job_postings"
      @controller.set "detailVisible", false
      @controller.pushBody()

    backFromMenu: ->
      @transitionTo "job_postings"
      @controller.set "menuVisible", false
      @controller.pushBody()

    searchFromMenu: ->
      @controllerFor('job_postings').send('search')
      $('#search_query_text_box').blur()
      localStorage["search_query"]     = @controller.search_query
      localStorage["search_location"]  = @controller.search_location
      localStorage["person_about"]     = @controller.person_about
      localStorage["person_education"] = @controller.person_education
      @controller.set "menuVisible", false
      @controller.set "likedVisible",  false
      @controller.pushBody()

    goToLiked: ->
      @controller.set "likedVisible", true
      @controller.pushBody()

    goToIndex: ->
      @controller.set "likedVisible",  false
      @controller.set "detailVisible", false
      @controller.set "menuVisible", false
      @controller.set "infoVisible", false
      @controller.pushBody()

    goToInfo: ->
      @controller.set "menuVisible", false
      @controller.set "infoVisible", true
      @controller.pushBody()

    goToMenu: ->
      @controller.set "menuVisible", true
      @controller.set "infoVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()
      $('#search_query_text_box').focus()
