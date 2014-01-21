class PickwickApp.ApplicationController extends Em.Controller
  menuVisible: false
  detailVisible: false
  search_query: ''
  search_location: "Aktuální pozice"
  locations: Em.A(["Aktuální pozice","Praha","Brno","Ostrava","Plzeň","Liberec","Olomouc","Ústí nad Labem","Hradec Králové","České Budějovice","Pardubice","Havířov","Zlín","Kladno","Most","Karviná","Opava","Frýdek-Místek","Karlovy Vary","Jihlava","Teplice","Děčín","Chomutov","Přerov","Jablonec nad Nisou","Mladá Boleslav","Prostějov","Třebíč","Česká Lípa","Třinec","Tábor","Znojmo","Příbram","Cheb","Orlová","Kolín","Trutnov","Písek","Kroměříž","Šumperk","Vsetín","Valašské Meziříčí","Litvínov","Uherské Hradiště","Hodonín","Český Těšín","Břeclav","Krnov","Litoměřice","Sokolov","Nový Jičín","Havlíčkův Brod","Chrudim","Strakonice","Kopřivnice","Klatovy","Žďár nad Sázavou","Bohumín","Jindřichův Hradec","Vyškov","Blansko","Kutná Hora","Náchod","Jirkov","Mělník","Žatec","Hranice (okres Přerov)","Beroun","Louny","Otrokovice","Kralupy nad Vltavou","Kadaň","Brandýs nad Labem-Stará Boleslav","Ostrov","Svitavy","Bruntál","Uherský Brod","Rožnov pod Radhoštěm","Jičín","Rakovník","Neratovice","Benešov","Pelhřimov","Dvůr Králové nad Labem","Česká Třebová","Bílina","Varnsdorf","Slaný","Klášterec nad Ohří","Mariánské Lázně","Nymburk","Ústí nad Orlicí","Turnov","Chodov","Rokycany","Hlučín","Poděbrady","Zábřeh","Šternberk","Krupka","Říčany"])

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
