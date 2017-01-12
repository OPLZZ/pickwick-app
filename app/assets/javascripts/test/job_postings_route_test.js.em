JPRTest = {}
module "Job Postings Route tests",
  setup: ->
    Ember.run ->
      JPRTest.route = PickwickApp.__container__.lookup('route:job_postings')
    Ember.run ->
      JPRTest.controller = PickwickApp.__container__.lookup('controller:job_postings')
    Ember.run ->
      JPRTest.app_controller = PickwickApp.__container__.lookup('controller:application')

    JPRTest.data = {
      "links": {},
      "total": 2,
      "vacancies": [
        {
          "id": "1",
          "distance": 2.21561335479989,
          "score": 0.49951947,
          "title": "Fool, barl",
          "start_date": "2014-05-01T00:00:00Z",
          "expiration_date": "2014-04-09T18:00:01Z",
          "created_at": "2014-03-10T18:00:01Z",
          "updated_at": "2014-03-10T18:00:27Z"
        },
        {
          "id": "2",
          "distance": 10,
          "score": 0.49951947,
          "title": "fool barfoo",
          "start_date": "2014-05-01T00:00:00Z",
          "expiration_date": "2014-04-09T18:00:01Z",
          "created_at": "2014-03-10T18:00:01Z",
          "updated_at": "2014-03-10T18:00:27Z"
        }
      ]
    }
#    JPRTest.route.get_job_posting_from_url = (id)->
#      @load_job_posting(JPCTest.data)

test "get preferencies", ->
  JPRTest.app_controller.set('person_about', "Foo")
  JPRTest.app_controller.set('person_education', "Bar")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Foo Bar"

  JPRTest.app_controller.set('person_about', "")
  JPRTest.app_controller.set('person_education', "Bar")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Bar"

  JPRTest.app_controller.set('person_about', "Foo")
  JPRTest.app_controller.set('person_education', "")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Foo"

  JPRTest.app_controller.set('person_about', null)
  JPRTest.app_controller.set('person_education', "Bar")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Bar"

  JPRTest.app_controller.set('person_about', "Foo")
  JPRTest.app_controller.set('person_education', null)
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Foo"

  JPRTest.app_controller.set('person_about', 'null')
  JPRTest.app_controller.set('person_education', "Bar")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Bar"

  JPRTest.app_controller.set('person_about', "Foo")
  JPRTest.app_controller.set('person_education', 'null')
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Foo"

  JPRTest.app_controller.set('person_about', undefined)
  JPRTest.app_controller.set('person_education', "Bar")
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Bar"

  JPRTest.app_controller.set('person_about', "Foo")
  JPRTest.app_controller.set('person_education', undefined)
  preferencies = JPRTest.route.getPreferencies()
  equal preferencies, "Foo"


test "get getSimilarPreferencies", ->
  #load data to controller
  JPRTest.route.loadDataFromAjax(JPRTest.data)
  console.log(JPRTest.controller.length)
  preferencies = JPRTest.route.getSimilarPreferencies()
  equal preferencies, "fool barfoo barl"

test "get url for fetch", ->
  #undefined - return normal search url
  url = JPRTest.route.getUrlForFetch(false)
  equal url, "https://api.damepraci.cz/vacancies"

  #defined - return saved url
  saved_url = "http://saved.url"
  JPRTest.controller.set('urlForLoadMore', saved_url)
  url = JPRTest.route.getUrlForFetch(false)
  equal url, saved_url

  #normal search
  url = JPRTest.route.getUrlForFetch(true)
  equal url, "https://api.damepraci.cz/vacancies"

test "get search query", ->
  JPRTest.app_controller.set('search_query', "Foo")
  search = JPRTest.route.getSearchQuery()
  equal search, "Foo"

  JPRTest.app_controller.set('search_query', null)
  search = JPRTest.route.getSearchQuery()
  equal search, ""

  JPRTest.app_controller.set('search_query', undefined)
  search = JPRTest.route.getSearchQuery()
  equal search, ""

  JPRTest.app_controller.set('search_query', 'null')
  search = JPRTest.route.getSearchQuery()
  equal search, ""

test "get location - preddefined", ->
  JPRTest.app_controller.set('search_location', 'Opava')
  location = JPRTest.route.getLocation()
  equal location, "49.93943,17.9048"

test "get location - actual location - disabled and no localstorage", ->
  JPRTest.app_controller.set('search_location', 'Aktuální poloha')
  localStorage['last_geolocation'] = undefined
  JPRTest.route.set('geolocation_object', {latitude: -99999, longitude: -99999})
  location = JPRTest.route.getLocation()
  equal location, null

test "get location - actual location - enabled", ->
  JPRTest.app_controller.set('search_location', 'Aktuální poloha')
  JPRTest.route.set('geolocation_object', {latitude: 49.93943, longitude: 17.9048})
  location = JPRTest.route.getLocation()
  equal location, "49.93943,17.9048"

test "get location - localstorage", ->
  localStorage['last_geolocation'] = "12.2314,23.5321"
  JPRTest.route.set('geolocation_object', {latitude: -99999, longitude: -99999})
  JPRTest.app_controller.set('search_location', 'Aktuální poloha')
  location = JPRTest.route.getLocation()
  equal location, localStorage['last_geolocation']

test "get args for fetch", ->
  #location
  JPRTest.app_controller.set('search_location', 'Aktuální poloha')
  JPRTest.route.set('geolocation_object', {latitude: 49.93943, longitude: 17.9048})
  equal JPRTest.route.getArgsForFetch().location, "49.93943,17.9048"

  #search query
  JPRTest.app_controller.set('search_query', "Foo")
  equal JPRTest.route.getArgsForFetch().query, "Foo"

  #search preferencies
  JPRTest.app_controller.set('person_about', "Bar")
  equal JPRTest.route.getArgsForFetch().preference, "Bar"

  #similar
  equal JPRTest.route.getArgsForFetch(true).query, undefined, "Similar can't have search query"
  equal JPRTest.route.getArgsForFetch(true).location, "49.93943,17.9048", "Similar have location"
