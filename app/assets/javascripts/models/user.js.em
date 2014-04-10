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
      ).error (error)->
        console.log("ERROR WITH SAVING")
