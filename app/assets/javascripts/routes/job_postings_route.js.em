class PickwickApp.JobPostingsRoute extends Em.Route with InfiniteScroll.RouteMixin

  locations: {
    "Praha":{latitude:"50.07908", longitude:"14.43323"},
    "Brno":{latitude:"49.19729", longitude:"16.6037"},
    "Ostrava":{latitude:"49.83928", longitude:"18.2885"},
    "Plzeň":{latitude:"49.74654", longitude:"13.38188"},
    "Liberec":{latitude:"50.77019", longitude:"15.05857"},
    "Olomouc":{latitude:"49.59242", longitude:"17.24903"},
    "Ústí nad Labem":{latitude:"50.66172", longitude:"14.04546"},
    "Hradec Králové":{latitude:"50.211288", longitude:"15.83093"},
    "České Budějovice":{latitude:"48.97541", longitude:"14.47938"},
    "Pardubice":{latitude:"49.889854", longitude:"16.11507"},
    "Havířov":{latitude:"49.77347", longitude:"18.44251"},
    "Zlín":{latitude:"49.2256", longitude:"17.66969"},
    "Kladno":{latitude:"50.14462", longitude:"14.10979"},
    "Most":{latitude:"50.5148", longitude:"13.63788"},
    "Karviná":{latitude:"49.85561", longitude:"18.53932"},
    "Opava":{latitude:"49.93943", longitude:"17.9048"},
    "Frýdek-Místek":{latitude:"49.67757", longitude:"18.341459"},
    "Karlovy Vary":{latitude:"50.22836", longitude:"12.86498"},
    "Jihlava":{latitude:"49.39372", longitude:"15.59152"},
    "Teplice":{latitude:"50.64807", longitude:"13.8284"},
    "Děčín":{latitude:"50.78092", longitude:"14.2134"},
    "Chomutov":{latitude:"50.4611", longitude:"13.41448"},
    "Přerov":{latitude:"49.45483", longitude:"17.4489"},
    "Jablonec nad Nisou":{latitude:"50.72468", longitude:"15.17333"},
    "Mladá Boleslav":{latitude:"50.41322", longitude:"14.90889"},
    "Prostějov":{latitude:"49.47369", longitude:"17.11531"},
    "Třebíč":{latitude:"49.2161", longitude:"15.87968"},
    "Česká Lípa":{latitude:"50.68349", longitude:"14.53482"},
    "Třinec":{latitude:"49.68609", longitude:"18.66422"},
    "Tábor":{latitude:"49.41102", longitude:"14.67679"},
    "Znojmo":{latitude:"48.8557", longitude:"16.05441"},
    "Příbram":{latitude:"49.688831", longitude:"14.00952"},
    "Cheb":{latitude:"50.07637", longitude:"12.37314"},
    "Orlová":{latitude:"49.8414", longitude:"18.41781"},
    "Kolín":{latitude:"50.02667", longitude:"15.20333"},
    "Trutnov":{latitude:"50.56135", longitude:"15.91611"},
    "Písek":{latitude:"48.31079", longitude:"-97.71053"},
    "Kroměříž":{latitude:"49.29717", longitude:"17.39082"},
    "Šumperk":{latitude:"49.96511", longitude:"16.97402"},
    "Vsetín":{latitude:"49.33999", longitude:"17.99338"},
    "Valašské Meziříčí":{latitude:"49.47613", longitude:"17.9707"},
    "Litvínov":{latitude:"50.59982", longitude:"13.60135"},
    "Uherské Hradiště":{latitude:"49.07278", longitude:"17.45895"},
    "Hodonín":{latitude:"48.851711", longitude:"17.12739"},
    "Český Těšín":{latitude:"49.685631", longitude:"18.272921"},
    "Břeclav":{latitude:"48.7597", longitude:"16.8813"},
    "Krnov":{latitude:"50.0902", longitude:"17.70457"},
    "Litoměřice":{latitude:"50.53389", longitude:"14.13109"},
    "Sokolov":{latitude:"50.1799", longitude:"12.64627"},
    "Nový Jičín":{latitude:"49.59328", longitude:"18.00923"},
    "Havlíčkův Brod":{latitude:"49.606918", longitude:"15.57944"},
    "Chrudim":{latitude:"49.951591", longitude:"15.79422"},
    "Strakonice":{latitude:"49.26073", longitude:"13.90081"},
    "Kopřivnice":{latitude:"49.59408", longitude:"18.14396"},
    "Klatitudeovy":{latitude:"49.39589", longitude:"13.29419"},
    "Žďár nad Sázavou":{latitude:"49.5635", longitude:"15.93971"},
    "Bohumín":{latitude:"49.90349", longitude:"18.35358"},
    "Jindřichův Hradec":{latitude:"49.15147", longitude:"15.01008"},
    "Vyškov":{latitude:"49.276279", longitude:"16.99964"},
    "Blansko":{latitude:"49.36383", longitude:"16.64446"},
    "Kutná Hora":{latitude:"49.94915", longitude:"15.26608"},
    "Náchod":{latitude:"50.415192", longitude:"16.16791"},
    "Jirkov":{latitude:"50.49717", longitude:"13.4491"},
    "Mělník":{latitude:"50.35636", longitude:"14.48697"},
    "Žatec":{latitude:"49.20641", longitude:"15.50896"},
    "Hranice (okres Přerov)":{latitude:"49.549734", longitude:"17.738349"},
    "Beroun":{latitude:"45.909199", longitude:"-92.959351"},
    "Louny":{latitude:"50.35535", longitude:"13.79775"},
    "Otrokovice":{latitude:"49.20898", longitude:"17.53488"},
    "Kralupy nad Vltavou":{latitude:"50.24253", longitude:"14.31131"},
    "Kadaň":{latitude:"50.378601", longitude:"13.27112"},
    "Brandýs nad Labem-Stará Boleslav":{latitude:"50.18565", longitude:"14.66008"},
    "Ostrov":{latitude:"50.31063", longitude:"12.94394"},
    "Svitavy":{latitude:"49.755791", longitude:"16.4694"},
    "Bruntál":{latitude:"49.98917", longitude:"17.46424"},
    "Uherský Brod":{latitude:"49.02489", longitude:"17.64712"},
    "Rožnov pod Radhoštěm":{latitude:"49.45965", longitude:"18.13312"},
    "Jičín":{latitude:"50.43661", longitude:"15.35227"},
    "Rakovník":{latitude:"50.10283", longitude:"13.7294"},
    "Neratovice":{latitude:"50.25692", longitude:"14.52025"},
    "Benešov":{latitude:"49.785419", longitude:"14.67672"},
    "Pelhřimov":{latitude:"49.4327", longitude:"15.2234"},
    "Dvůr Králové nad Labem":{latitude:"50.43255", longitude:"15.81347"},
    "Česká Třebová":{latitude:"49.901661", longitude:"16.448111"},
    "Bílina":{latitude:"50.550121", longitude:"13.77334"},
    "Varnsdorf":{latitude:"50.91183", longitude:"14.61943"},
    "Slaný":{latitude:"50.2319", longitude:"14.08397"},
    "Klášterec nad Ohří":{latitude:"50.38296", longitude:"13.16955"},
    "Mariánské Lázně":{latitude:"49.97423", longitude:"12.70484"},
    "Nymburk":{latitude:"50.18589", longitude:"15.04109"},
    "Ústí nad Orlicí":{latitude:"49.97428", longitude:"16.39454"},
    "Turnov":{latitude:"50.58736", longitude:"15.15739"},
    "Chodov":{latitude:"50.24023", longitude:"12.74755"},
    "Rokycany":{latitude:"49.7424", longitude:"13.59522"},
    "Hlučín":{latitude:"49.89604", longitude:"18.19007"},
    "Poděbrady":{latitude:"50.14259", longitude:"15.11798"},
    "Zábřeh":{latitude:"49.881699", longitude:"16.876419"},
    "Šternberk":{latitude:"49.7307", longitude:"17.29705"},
    "Krupka":{latitude:"50.68217", longitude:"13.87159"},
    "Říčany":{latitude:"49.991821", longitude:"14.65729"}
  }

  model: ->
    @set('job_posting_cache', Em.A([]))
    @fetchPage(true)
    @get('job_posting_cache')

  actions:
    getMore: ->
      @fetchPage(false)

    fetchPage: ->
      @fetchPage(false)

    tryAgain: ->
      if @controllerFor('job_postings').get('urlForLoadMore') == undefined
        @fetchPage(true)
      else
        @fetchPage(false)

    search: ->
      @controller.set('loadingMore', true)
      @controller.set('noMoreItems', false)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      @fetchPage(true)

    show_liked: ->
      @set('cache_for_search', Em.A([]))
      for item in @get('job_posting_cache')
        @get('cache_for_search').pushObject(item)

      @controller.set('loadingMore', true)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))
      for id, item of JSON.parse(localStorage["liked_jobs"])
        item.id = id
        #push object to list of liked jobs
        @get('job_posting_cache').pushObject(PickwickApp.JobPosting.create(item))

    back_from_liked: ->
      @controller.set('loadingMore', false)
      @get('job_posting_cache').replace(0, @get('job_posting_cache').get('length'), Em.A([]))

      #get liked status from local storage
      if localStorage["liked_jobs"] == undefined
        liked_jobs    = {}
      else
        liked_jobs    = JSON.parse(localStorage["liked_jobs"])

      if @get('cache_for_search') != undefined
        for item in @get('cache_for_search')
          #fix liked jobs
          if liked_jobs[item.id] != undefined
            item.set("is_liked", true)
          else
            item.set("is_liked", false)
          @get('job_posting_cache').pushObject(item)



  fetchPage: (search) ->
    app_controller = @controllerFor('application')
    cont = @controllerFor('job_postings')
    ccc  = @

    #hide error
    cont.set('loadingError', false)

    if search
      cont.set('urlForLoadMore', undefined)

      #build arguments for search
      args = {
        token: "59a3b1a51c80c8db71c9a881d8b23c6e2b41727c"
        per_page: cont.get('perPage')
      }

      if app_controller.search_query.length > 0
        args.query = app_controller.search_query

      args.preference =  "#{app_controller.search_query} #{app_controller.person_about} #{app_controller.person_education}"

      #has location setted to geo
      if app_controller.search_location == "Aktuální pozice"
        if @get('geolocation_object') == undefined
          @set('geolocation_object', Em.GeoLocation.create({autoUpdate: true}))

        if @get('geolocation_object') != undefined
          if @get('geolocation_object').latitude != -99999
            args.location = "#{@get('geolocation_object').latitude},#{@get('geolocation_object').longitude}"
            #remeber last geolocation into local storage :D
            localStorage['last_geolocation'] = args.location

          #if there is no data for loaction try cached location
          else if localStorage['last_geolocation'] != undefined && localStorage['last_geolocation'] != "undefined"
            args.location = localStorage['last_geolocation']

      #has location setted to city
      else
        loc = @locations[app_controller.search_location]
        args.location = "#{loc.latitude},#{loc.longitude}"

      url = "http://pickwick-api.dev.vhyza.eu/vacancies"
    else
      url = cont.get('urlForLoadMore')

    $.ajax(
      method: 'GET'
      dataType: 'json'
      url: url
      data: args
    ).done( (data) ->
      postings = data.vacancies.map (job_data) -> PickwickApp.JobPosting.create(job_data)
      if data.links && data.links.next
        cont.set('urlForLoadMore', data.links.next)
      else
        cont.set('noMoreItems', true)

      #set liked status from local storage
      if localStorage["liked_jobs"] == undefined
        liked_jobs    = {}
      else
        liked_jobs    = JSON.parse(localStorage["liked_jobs"])
      for job_posting in postings
        if liked_jobs[job_posting.id] != undefined
          job_posting.set("is_liked", true)

      #add downloaded job postings to array
      ccc.get('job_posting_cache').pushObjects(postings)

      #stop loading more
      cont.set('loadingMore', false)

    ).error (error)->

      #show loading error
      cont.set('loadingError', true)
