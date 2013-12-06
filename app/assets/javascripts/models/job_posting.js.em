# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends DS.Model
  title:           DS.attr 'string'
  employment_type: DS.attr 'string'
  location:        DS.attr 'string'
  description:     DS.attr 'string'
  compensation:    DS.attr 'string'
  contact:         DS.attr 'string'
  url:             DS.attr 'string'
