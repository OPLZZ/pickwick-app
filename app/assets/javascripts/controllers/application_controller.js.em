class PickwickApp.ApplicationController extends Em.Controller
  menuVisible:   false
  infoVisible:   false
  likedVisible:  false
  detailVisible: false
  search_query: ''
  search_location: "Aktuální pozice"
  locations: Em.A(["Aktuální pozice","Praha","Brno","Benešov","Beroun","Blansko","Bohumín","Brandýs nad Labem-Stará Boleslav","Bruntál","Bílina","Břeclav","Cheb","Chodov","Chomutov","Chrudim","Dvůr Králové nad Labem","Děčín","Frýdek-Místek","Havlíčkův Brod","Havířov","Hlučín","Hodonín","Hradec Králové","Hranice (okres Přerov)","Jablonec nad Nisou","Jihlava","Jindřichův Hradec","Jirkov","Jičín","Kadaň","Karlovy Vary","Karviná","Kladno","Klatovy","Klášterec nad Ohří","Kolín","Kopřivnice","Kralupy nad Vltavou","Krnov","Kroměříž","Krupka","Kutná Hora","Liberec","Litoměřice","Litvínov","Louny","Mariánské Lázně","Mladá Boleslav","Most","Mělník","Neratovice","Nový Jičín","Nymburk","Náchod","Olomouc","Opava","Orlová","Ostrava","Ostrov","Otrokovice","Pardubice","Pelhřimov","Plzeň","Poděbrady","Prostějov","Písek","Přerov","Příbram","Rakovník","Rokycany","Rožnov pod Radhoštěm","Slaný","Sokolov","Strakonice","Svitavy","Teplice","Trutnov","Turnov","Tábor","Třebíč","Třinec","Uherské Hradiště","Uherský Brod","Valašské Meziříčí","Varnsdorf","Vsetín","Vyškov","Zlín","Znojmo","Zábřeh","Ústí nad Labem","Ústí nad Orlicí","Česká Lípa","Česká Třebová","České Budějovice","Český Těšín","Říčany","Šternberk","Šumperk","Žatec","Žďár nad Sázavou"])

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
