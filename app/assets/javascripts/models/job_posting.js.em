# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends DS.Model
  #internal
  is_liked:                 DS.attr 'boolean'

  #data
  title:                    DS.attr 'string'
  description:              DS.attr 'string'
  industry:                 DS.attr 'string'
  responsibilities:         DS.attr 'string'
  number_of_positions:      DS.attr 'string'
  employment_type:          DS.attr 'string'
  remote:                   DS.attr 'string'
  location_street:          DS.attr 'string'
  location_city:            DS.attr 'string'
  location_region:          DS.attr 'string'
  location_zip:             DS.attr 'string'
  location_country:         DS.attr 'string'
  location_coordinates_lat: DS.attr 'string'
  location_coordinates_lon: DS.attr 'string'
  experience:               DS.attr 'string'
  employer_name:            DS.attr 'string'
  employer_company:         DS.attr 'string'
  publisher:                DS.attr 'string'
  contact_email:            DS.attr 'string'
  contact_name:             DS.attr 'string'
  contact_phone:            DS.attr 'string'
  compensation:             DS.attr 'string'

  #dates
  start_date:               DS.attr 'date'
  expiration_date:          DS.attr 'date'
  created_at:               DS.attr 'date'
  updated_at:               DS.attr 'date'