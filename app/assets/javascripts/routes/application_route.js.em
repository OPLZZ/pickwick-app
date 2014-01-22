class PickwickApp.ApplicationRoute extends Ember.Route
  actions:
    goToJobPosting: (job_posting) ->
      if job_posting
        $('.infinite-scroll-detail').scrollTo({top: 0, left: 0}, {duration:0})
      @send "showDetail"
      @transitionTo "job_posting", job_posting
      @controller.pushBody()

    goToJobPostingsFromMenu: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @transitionTo "job_postings"
      @transitionTo "job_postings.index"
      @controller.pushBody()

    searchJobPostingsFromMenu: ->
      @controllerFor('job_postings').set "likedVisible", false
      $('#search_query_text_box').blur()
      @controllerFor('job_postings').send('search', {
        query: @controller.search_query
        location: @controller.search_location
        person_about: @controller.person_about
        person_education: @controller.person_education
      })
      @send('goToJobPostingsFromMenu')

    goFromLikedJobPostings: ->
      @controllerFor('job_postings').send('back_from_liked')
      @controllerFor('job_postings').set "likedVisible", false

      list_scroll_top = @list_scroll_top
      scrool = ->
        $('.infinite-scroll-list').scrollTo({top: list_scroll_top, left: 0}, {duration:0})
      window.setTimeout(scrool,50)


    goToLikedJobPostings: ->
      @list_scroll_top = $('.infinite-scroll-list').scrollTop()
      @controllerFor('job_postings').send('show_liked')
      @controllerFor('job_postings').set "likedVisible", true

    backToJobPostings: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @controller.pushBody()

    toggleMenu: ->
      @controller.toggleProperty "menuVisible"
      @transitionTo "job_postings.index"
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

    hideDetail: ->
      @controller.set "detailVisible", false
      @controller.set "menuVisible", false
      @controller.pushBody()

