# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.User extends Ember.Object
  id: null
  system_id: null
  name:  ''
  token: null

  save_params: (->
    {
      user: {
        system_id:  @system_id
        name:       @name
        token:      @token
      }
    }
  ).property('id, name, token')

  update_attributes: (args) ->
    @id = args.id if args.id

  after_save_hooks: ->
    Ember.run ->
      app_controller = PickwickApp.__container__.lookup('controller:application');
      app_controller.set('user', user)

      controller = PickwickApp.__container__.lookup('controller:user_job_postings');
      controller.set('user', user)
      controller.send('search')

  save: ->
    this_object = @
    url = "#{window.PickwickApp.user_url_point}/users"

    Ember.run ->
      $.ajax(
        method: 'POST'
        dataType: 'json'
        contentType: 'application/json'
        url: url
        processData: false
        data: JSON.stringify(this_object.save_params)
        headers: { 'Application-Token': window.PickwickApp.user_api_token}
        cache: false
      ).done( (data) ->
        this_object.update_attributes(data.user)
        this_object.after_save_hooks()
      ).error (error)->
        console.log("ERROR WITH SAVING")
