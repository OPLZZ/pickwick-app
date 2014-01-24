class PickwickApp.ApplicationController extends Em.Controller
  menuVisible:   false
  infoVisible:   false
  detailVisible: false
  search_query: ''
  search_location: "Aktuální pozice"
  locations: Em.A(["Aktuální pozice","Praha","Brno","Benešov","Beroun","Blansko","Bohumín","Brandýs nad Labem-Stará Boleslav","Bruntál","Bílina","Břeclav","Cheb","Chodov","Chomutov","Chrudim","Dvůr Králové nad Labem","Děčín","Frýdek-Místek","Havlíčkův Brod","Havířov","Hlučín","Hodonín","Hradec Králové","Hranice (okres Přerov)","Jablonec nad Nisou","Jihlava","Jindřichův Hradec","Jirkov","Jičín","Kadaň","Karlovy Vary","Karviná","Kladno","Klatovy","Klášterec nad Ohří","Kolín","Kopřivnice","Kralupy nad Vltavou","Krnov","Kroměříž","Krupka","Kutná Hora","Liberec","Litoměřice","Litvínov","Louny","Mariánské Lázně","Mladá Boleslav","Most","Mělník","Neratovice","Nový Jičín","Nymburk","Náchod","Olomouc","Opava","Orlová","Ostrava","Ostrov","Otrokovice","Pardubice","Pelhřimov","Plzeň","Poděbrady","Prostějov","Písek","Přerov","Příbram","Rakovník","Rokycany","Rožnov pod Radhoštěm","Slaný","Sokolov","Strakonice","Svitavy","Teplice","Trutnov","Turnov","Tábor","Třebíč","Třinec","Uherské Hradiště","Uherský Brod","Valašské Meziříčí","Varnsdorf","Vsetín","Vyškov","Zlín","Znojmo","Zábřeh","Ústí nad Labem","Ústí nad Orlicí","Česká Lípa","Česká Třebová","České Budějovice","Český Těšín","Říčany","Šternberk","Šumperk","Žatec","Žďár nad Sázavou"])

  person_about: ''
  person_education: 'nechci uvádět'
  educations: Em.A(['nechci uvádět', 'základní škola', 'střední škola s maturitou', 'vysoká škola'])

  pushBody: ->
    $("body").removeClass "push-right"
    $("body").removeClass "push-left"
    if @get("menuVisible")
      return $(".ember-application").addClass("push-right")
    else if @get("detailVisible")
      return $(".ember-application").addClass("push-left")
