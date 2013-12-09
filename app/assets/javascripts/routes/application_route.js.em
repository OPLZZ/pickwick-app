class PickwickApp.ApplicationRoute extends Ember.Route
  events:
    goToJobPosting: (job_posting) ->
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
        @send "showDetail"
      @transitionTo "job_posting", job_posting

    goToJobPostingsFromMenu: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @transitionTo "job_postings"
      @controller.pushBody()

    searchJobPostingsFromMenu: ->
      $('#search_query_text_box').blur()
      @controllerFor('job_postings').send('search', {
        query: @controller.search_query
        location: @controller.search_location
        person_about: @controller.person_about
        person_education: @controller.person_education
      })
      @send('goToJobPostingsFromMenu')

    backToJobPostings: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()

    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @controller.pushBody()

    showMenu: ->
      @controller.set "menuVisible", true
      @controller.set "detailVisible", false
      @controller.pushBody()

    hideMenu: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()

    showDetail: ->
      @controller.set "detailVisible", true
      @controller.set "menuVisible", false
      @controller.pushBody()

    hideDetail: ->
      @controller.set "detailVisible", false
      @controller.set "menuVisible", false
      @controller.pushBody()

