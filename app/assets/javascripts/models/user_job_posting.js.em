# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.UserJobPosting extends PickwickApp.JobPosting

  compensation_type_translation: {
    "monthly": 'měsíční'
    "hourly":  'hodinová'
    "annual":  'roční'
    "fixed":   'fixní'
  }

  compensation_currency_translation: {
    'CZK': 'Kč'
    'EUR': '€'
  }

  employer_type_select: [
    {'key': 'company', 'value': 'Firma'},
    {'key': 'private', 'value': 'Soukromá osoba'},
  ]

  set_defaults_for_new: ->
    @start_date = moment().format('YYYY-MM-DD')
    app_controller = PickwickApp.__container__.lookup('controller:application')
    @contact.name =  app_controller.user.name
    @employer.type = "company"

  destroy: ->
    app_controller = PickwickApp.__container__.lookup('controller:application')
    url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings/#{@id}"

    this_object = @
    Ember.run ->
      $.ajax(
        method: 'DELETE'
        dataType: 'json'
        contentType: 'application/json'
        url: url
        processData: false
        headers: {
          'Application-Token': window.PickwickApp.user_api_token
          'User-Token': app_controller.user.token
        }
        cache: false
      ).done( (data) ->
        console.log("DELETED: #{this_object.id}")
      ).error (error)->
        console.log("ERROR WITH DELETING")

  save_params: (->
    {
      job_posting: {
        title:           @title
        start_date:      @start_date
        description:     @description
        employment_type: @employment_type
        employer:        @employer
        location:        @location
        contact:         @contact
        compensation:    @compensation
      }
    }
  ).property('title, description, employment_type, employer, location, contact, compensation')

  get_contact_phone: (->
    if @contact && @contact.phone
      phone = @contact.phone.split(",")[0]
      if phone.match(@phone_regexp)
        phone
      else
        null
    else
      null
  ).property('contact, contact.phone')

  update_attributes: (job_posting) ->
    @id = job_posting.id
    @checked = job_posting.checked

  save: ->
    console.log("SAVING")
    this_object = @
    app_controller = PickwickApp.__container__.lookup('controller:application')

    unless app_controller.user
      alert('cant save without sign in')

    if @id
      method = "PATCH"
      url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings/#{@id}"
    else
      method = "POST"
      url = "#{window.PickwickApp.user_url_point}/users/#{app_controller.user.id}/job_postings"
    
    this_object = @

    console.log(JSON.stringify(this_object.save_params))
    Ember.run ->
      $.ajax(
        method: method
        dataType: 'json'
        contentType: 'application/json'
        url: url
        processData: false
        data: JSON.stringify(this_object.save_params)
        headers: { 
          'Application-Token': window.PickwickApp.user_api_token
          'User-Token': app_controller.user.token
        }
        cache: false
      ).done( (data) ->
        this_object.update_attributes(data.job_posting)
      ).error (error)->
        console.log("ERROR WITH SAVING")

  valid_save: ( ->
    @valid_title && @valid_description && @valid_employer && @valid_contact && @valid_location_city && @valid_contact_name
  ).property('valid_title','valid_description', 'valid_employer', 'valid_contact','valid_location_city', 'valid_contact_name')

  valid_title:( ->
    if @title && @title.length > 6
      true
    else
      false
  ).property('title')

  valid_description:( ->
    if @description && @description.length > 6
      true
    else
      false
  ).property('description')

  valid_employer:( ->
    if @employer.name && @employer.name.length > 3
      true
    else
      false
  ).property('employer','employer.name')

  valid_contact_name:( ->
    if @contact && @contact.name && @contact.name.length > 3
      true
    else
      false
  ).property('contact', 'contact.name')

  valid_contact:( ->
    console.log(@contact.phone)
    if @contact.phone
      console.log(@contact.phone.match(@phone_regexp))
    console.log(@contact.email)
    if @contact.email
      console.log(@contact.email.match(@email_regexp))
    if @contact && ((@contact.phone && @contact.phone.match(@phone_regexp)) || (@contact.email && @contact.email.match(@email_regexp)))
      true
    else
      false
  ).property('contact', 'contact.phone', 'contact.email')

  valid_location_city:( ->
    if @location && @location.city && @location.city.length > 1
      true
    else
      false
  ).property('location','location.city')


  duplicate: ->
    new_job = {}
    new_job.id      = @id
    new_job.title   = @title
    new_job.employment_type = @employment_type
    new_job.description     = @description
    new_job.start_date      = @start_date

    new_job.employer = Ember.Object.create({})
    new_job.employer.type = @employer.type
    new_job.employer.name = @employer.name


    new_job.location = Ember.Object.create({})
    new_job.location.city   = @location.city
    new_job.location.street = @location.street
    new_job.location.zip    = @location.zip

    new_job.contact = Ember.Object.create({})
    new_job.contact.name  = @contact.name
    new_job.contact.phone = @contact.phone
    new_job.contact.email = @contact.email

    new_job.compensation = Ember.Object.create({})
    new_job.compensation.value    = @compensation.value
    new_job.compensation.type     = @compensation.type
    new_job.compensation.currency = @compensation.currency

    PickwickApp.UserJobPosting.create(new_job)


  #for select box in new/edit form
  employment_type_select:(->
    out = Em.A([])
    for key, value of @employment_type_translation
      out.push({'key': key, 'value': value})
    out
  ).property('employment_type_translation')

  #for select box in new/edit form
  compensation_type_select:(->
    out = Em.A([])
    for key, value of @compensation_type_translation
      out.push({'key': key, 'value': value})
    out
  ).property('compensation_type_translation')

  #for select box in new/edit form
  compensation_currency_select:(->
    out = Em.A([])
    for key, value of @compensation_currency_translation
      out.push({'key': key, 'value': value})
    out
  ).property('compensation_currency_translation')

  checked_text:( ->
    if @checked == "valid"
      "Schváleno administrátorem a zobrazuje se uživatelům ve výsledcích vyhledávání"
    else if @checked == "invalid"
      "Není schváleno administrátorem!"
    else
      "Čeká na schválení administrátora"
  ).property('checked')

  checked_badge_klass: ( ->
    if @checked == "valid"
      "new_badge green"
    else if @checked == "invalid"
      "new_badge red"
    else
      "new_badge gray"
  ).property('checked')

  checked_badge_text: ( ->
    if @checked == "valid"
      "<div class='icon-star badge-icon'></div>"
    else if @checked == "invalid"
      "<div class='icon-warning badge-icon'></div>"
    else
      "<div class='icon-time badge-icon'></div>"
  ).property('checked')