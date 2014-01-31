class PickwickApp.ApplicationRoute extends Ember.Route
  actions:
    goToJobPosting: (job_posting) ->
      @send('goToMenuFromInfo')
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
      @send "showDetail"
      @transitionTo "job_posting", job_posting
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @send('goToMenuFromInfo')
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @transitionTo "job_postings"
      @transitionTo "job_postings.index"
      @controller.pushBody()

    goToMenuFromInfo: ->
      $('.ember-application').removeClass "push-info"
      @controller.set "infoVisible", false

    goToInfoFromMenu: ->
      $('.ember-application').addClass "push-info"
      @controller.set "infoVisible", true


    searchJobPostingsFromMenu: ->
      @send('goToMenuFromInfo')
      @send('goFromLikedJobsToPostings')
      @controllerFor('job_postings').set "likedVisible", false
      $('#search_query_text_box').blur()
      @controllerFor('job_postings').send('search', {
        query: @controller.search_query
        location: @controller.search_location
        person_about: @controller.person_about
        person_education: @controller.person_education
      })
      localStorage["search_query"]     = @controller.search_query
      localStorage["search_location"]  = @controller.search_location
      localStorage["person_about"]     = @controller.person_about
      localStorage["person_education"] = @controller.person_education

      @send('goToJobPostingsFromMenu')

    goFromLikedJobPostings: ->
      @send('goToMenuFromInfo')
      @controllerFor('job_postings').send('back_from_liked')
      @controllerFor('job_postings').set "likedVisible", false

      list_scroll_top = @list_scroll_top
      scrool = ->
        $('.infinite-scroll-list').scrollTo({top: list_scroll_top, left: 0}, {duration:0})
      window.setTimeout(scrool,50)

    goToLikedJobs: ->
      $('.ember-application').addClass "push-liked"
      @controller.set "likedVisible", true

    goFromLikedJobsToPostings: ->
      $('.ember-application').removeClass "push-liked"
      @controller.set "likedVisible", false

    goToLikedJobPostings: ->
      @send('goToMenuFromInfo')
      @list_scroll_top = $('.infinite-scroll-list').scrollTop()
      @controllerFor('job_postings').send('show_liked')
      @controllerFor('job_postings').set "likedVisible", true

    backToJobPostings: ->
      @send('goToMenuFromInfo')
      @send('goFromLikedJobsToPostings')
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()

    toggleMenu: ->
      @send('goToMenuFromInfo')
      @controller.toggleProperty "menuVisible"
      @transitionTo "job_postings.index"
      @controller.pushBody()

    showMenu: ->
      @send('goToMenuFromInfo')
      @controller.set "menuVisible", true
      @controller.set "detailVisible", false
      @controller.pushBody()

    hideMenu: ->
      @send('goToMenuFromInfo')
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()

    showDetail: ->
      @send('goToMenuFromInfo')
      @controller.set "detailVisible", true
      @controller.set "menuVisible", false

    hideDetail: ->
      @send('goToMenuFromInfo')
      @controller.set "detailVisible", false
      @controller.set "menuVisible", false
      @controller.pushBody()

