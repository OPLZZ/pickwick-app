# for more details see: http://emberjs.com/guides/views/


class PickwickApp.UserJobPostingEditView extends Ember.View
  templateName: 'user_job_posting/edit'

  didInsertElement: ->
    $('textarea').autoGrow()