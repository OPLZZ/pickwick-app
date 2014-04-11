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
      @transitionTo "job_postings"
      @controllerFor('job_postings').send('search')
      @remembered_scroll = 0
      $('#search_query_text_box').blur()
      $('#search_location_box').blur()
      $('#person_about_box').blur()

      localStorage["search_query"]     = @controller.search_query
      localStorage["search_location"]  = @controller.search_location
      localStorage["person_about"]     = @controller.person_about
      localStorage["person_education"] = @controller.person_education

    goToLiked: ->
      @transitionTo "job_postings.liked"

    goToIndex: ->
      @transitionTo "job_postings"

    goToInfo: ->
      @transitionTo "job_postings.info"

    goToUserJobPostings: ->
      @transitionTo "user_job_postings"

    goToMenu: ->
      @transitionTo "job_postings.search"
      $('#search_query_text_box').focus()

    backFromUserJobPosting: ->
      @transitionTo "user_job_postings"

    goToNewUserJobPosting: ->
      @transitionTo 'user_job_posting.new'

    goToUserJobPosting: (model) ->
      if @controllerFor('application').user && @controllerFor('application').user.id
        @transitionTo 'user_job_posting', model
      else
        @transitionTo 'user_job_postings'

    editUserJobPosting: (model) ->
      if @controllerFor('application').user && @controllerFor('application').user.id
        @transitionTo 'user_job_posting.edit', model.duplicate()
      else
        @transitionTo 'user_job_postings'
  
    createUserJobPosting: (model) ->
      if @controllerFor('application').user && @controllerFor('application').user.id
        @controllerFor('user_job_postings').addItem(model)
        model.save()
        @transitionTo( 'user_job_posting', model )
      else
        @transitionTo 'user_job_postings'

    updateUserJobPosting: (model) ->
      if @controllerFor('application').user && @controllerFor('application').user.id
        model.save()
        @controllerFor('user_job_postings').updateItem(model)
        @transitionTo( 'user_job_posting', model )
      else
        @transitionTo 'user_job_postings'

    removeUserJobPosting: (model) ->
      if @controllerFor('application').user && @controllerFor('application').user.id
        model.destroy()
        @controllerFor('user_job_postings').removeItem('id', model.id)
        @transitionTo( 'user_job_postings' )
      else
        @transitionTo 'user_job_postings'

    cancleUserJobPosting: ->
      @transitionTo "user_job_postings"
