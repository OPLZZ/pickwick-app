class PickwickApp.ApplicationController extends Em.Controller
  menuVisible:   false
  infoVisible:   false
  likedVisible:  false
  detailVisible: false
  search_query: ''
  search_location: "Aktuální poloha"
  locations: Em.A(["Aktuální poloha","Praha","Brno","Břeclav","Cheb","Chomutov","Děčín","Frýdek-Místek","Havlíčkův Brod","Havířov","Hodonín","Hradec Králové","Jablonec nad Nisou","Jihlava","Karlovy Vary","Karviná","Kladno","Kolín","Krnov","Kroměříž","Liberec","Litoměřice","Litvínov","Mladá Boleslav","Most","Nový Jičín","Olomouc","Opava","Orlová","Ostrava","Pardubice","Plzeň","Prostějov","Písek","Přerov","Příbram","Sokolov","Teplice","Trutnov","Tábor","Třebíč","Třinec","Uherské Hradiště","Valašské Meziříčí","Vsetín","Zlín","Znojmo","Ústí nad Labem","Česká Lípa","České Budějovice","Český Těšín","Šumperk"])

  person_about: ''
  person_education: ''
  educations: Em.A(['nechci uvádět', 'základní škola', 'střední škola s maturitou', 'vysoká škola'])

  currentPathDidChange:( ->
    path = @get('currentPath')

    $(".ember-application").removeClass "push-detail"
    $(".ember-application").removeClass "push-info"
    $(".ember-application").removeClass "push-liked"
    $(".ember-application").removeClass "push-menu"

    if path == "job_postings.index"
      @detailVisible = false
      @infoVisible = false
      @menuVisible = false
      @likedVisible = false

    if path == "job_postings.job_posting"
      @detailVisible = true

    if path == "job_postings.search"
      @menuVisible = true
      @infoVisible = false

    if path == "job_postings.info"
      @menuVisible = false
      @infoVisible = true

    if path == "job_postings.liked"
      @likedVisible = true

    if @menuVisible
      $(".ember-application").addClass("push-menu")
    if @detailVisible
      $(".ember-application").addClass("push-detail")
    if @infoVisible
      $(".ember-application").addClass("push-info")
    if @likedVisible
      $(".ember-application").addClass("push-liked")

    @pushBody()

  ).observes('currentPath')

  init: ->
    #fill search for first time
    if localStorage["search_query"] != undefined
      @search_query = localStorage["search_query"]
    if localStorage["search_location"] != undefined
      @search_location = localStorage["search_location"]
    if localStorage["person_about"] != undefined
      @person_about = localStorage["person_about"]
    if localStorage["person_education"] != undefined
      @person_education = localStorage["person_education"]
