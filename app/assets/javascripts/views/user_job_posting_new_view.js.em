# for more details see: http://emberjs.com/guides/views/


class PickwickApp.UserJobPostingNewView extends Ember.View
  templateName: 'user_job_posting/new'

  didInsertElement: ->
    $('textarea').autoGrow()