# for more details see: http://emberjs.com/guides/models/defining-models/

class PickwickApp.JobPosting extends Ember.Object
  is_liked: false

  employment_type_translated:( ->
    translation = {
      "full-time": 'plný úvazek'
      "part-time": 'poloviční úvazek'
    }
    translation[@employment_type]
  ).property('employment_type')