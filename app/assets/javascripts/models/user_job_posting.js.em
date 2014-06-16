# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.UserJobPosting extends PickwickApp.JobPosting

  date_day_text:(->
    out = {}
    for i in [1..31]
      out[''+i] = i
    out
  )

  date_month_text: {
    "1": "leden",
    "2": "únor",
    "3": "březen",
    "4": "duben",
    "5": "květen",
    "6": "červen",
    "7": "červenec",
    "8": "srpen",
    "9": "září",
    "10": "říjen",
    "11": "listopad",
    "12": "prosinec"
  }
 
  date_year_text:(->
    out = {}
    current_year = parseInt(moment().format('YYYY'))
    out[''+(current_year)] = current_year
    out[''+(current_year+1)] = current_year+1
    out
  )

  employer_type_select: [
    {'key': 'company', 'value': 'Firma'},
    {'key': 'private', 'value': 'Soukromá osoba'},
  ]

  set_defaults_for_new: ->
    @start_date = moment().add('days', 14).format('YYYY-MM-DD')
    @update_form_dates()

    app_controller = PickwickApp.__container__.lookup('controller:application')
    @contact.name =  app_controller.user.name
    @employer.type = "company"


  update_start_date:( ->
    console.log("#{@start_date_day}-#{@start_date_month}-#{@start_date_year}")
    date = "#{@start_date_day}-#{@start_date_month}-#{@start_date_year}"
    @start_date = moment(date, "D-M-YYYY").format('YYYY-MM-DD')
  ).observes('start_date_day', 'start_date_month', 'start_date_year')

  update_form_dates: ->
    date = moment(@start_date, "YYYY-MM-DD")
    @start_date_day = date.format("D")
    @start_date_month = date.format("M")
    @start_date_year = date.format("YYYY")

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
    #just for showing warning message
    new_job.checked         = @checked

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
    new_job.compensation.compensation_type     = @compensation.compensation_type
    new_job.compensation.currency = @compensation.currency

    new_job_object = PickwickApp.UserJobPosting.create(new_job)
    new_job_object.update_form_dates()
    new_job_object


  #for select box in new/edit form
  date_day_select:(->
    out = Em.A([])
    for key, value of @date_day_text()
      out.push({'key': key, 'value': value})
    out
  ).property('date_day_text')

  #for select box in new/edit form
  date_month_select:(->
    out = Em.A([])
    for key, value of @date_month_text
      out.push({'key': key, 'value': value})
    out
  ).property('date_month_text')

  #for select box in new/edit form
  date_year_select:(->
    out = Em.A([])
    for key, value of @date_year_text()
      out.push({'key': key, 'value': value})
    out
  ).property('date_year_text')

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

  show_info_message_for_edit:( ->
    @checked == "valid"
  ).property('checked')

  checked_text:( ->
    if @checked == "valid"
      "Inzerát byl schválen. Uživatelům se bude zobrazovat do uplynutí data nástupu, pokud jej dříve sami nesmažete."
    else if @checked == "invalid"
      "Inzerát nebyl schválen správcem."
    else
      "Inzerát čeká na schválení správcem."
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