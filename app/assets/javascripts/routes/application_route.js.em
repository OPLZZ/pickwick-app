class PickwickApp.ApplicationRoute extends Ember.Route
  events:
    goToJobPosting: (job_posting) ->
      if job_posting
        @send "showDetail"
      @transitionTo "job_posting", job_posting

    goToJobPostingsFromMenu: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @transitionTo "job_postings"
      @controller.pushBody()

    backToJobPostings: ->
      @controller.set "menuVisible", false
      @controller.set "detailVisible", false
      @transitionTo "job_postings"
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

