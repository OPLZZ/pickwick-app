class PickwickApp.ApplicationController extends Em.Controller
  menuVisible:   false
  infoVisible:   false
  likedVisible:  false
  detailVisible: false
  search_query: ''
  search_location: "Aktuální pozice"
  locations: Em.A(["Aktuální pozice","Praha","Brno","Břeclav","Cheb","Chomutov","Děčín","Frýdek-Místek","Havlíčkův Brod","Havířov","Hodonín","Hradec Králové","Jablonec nad Nisou","Jihlava","Karlovy Vary","Karviná","Kladno","Kolín","Krnov","Kroměříž","Liberec","Litoměřice","Litvínov","Mladá Boleslav","Most","Nový Jičín","Olomouc","Opava","Orlová","Ostrava","Pardubice","Plzeň","Prostějov","Písek","Přerov","Příbram","Sokolov","Teplice","Trutnov","Tábor","Třebíč","Třinec","Uherské Hradiště","Valašské Meziříčí","Vsetín","Zlín","Znojmo","Ústí nad Labem","Česká Lípa","České Budějovice","Český Těšín","Šumperk"])

  person_about: ''
  person_education: ''
  educations: Em.A(['nechci uvádět', 'základní škola', 'střední škola s maturitou', 'vysoká škola'])

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

  pushBody: ->
    $(".ember-application").removeClass "push-detail"
    $(".ember-application").removeClass "push-info"
    $(".ember-application").removeClass "push-liked"
    $(".ember-application").removeClass "push-menu"
    if @get("menuVisible")
      $(".ember-application").addClass("push-menu")
    if @get("detailVisible")
      $(".ember-application").addClass("push-detail")
    if @get("infoVisible")
      $(".ember-application").addClass("push-info")
    if @get("likedVisible")
      $(".ember-application").addClass("push-liked")
