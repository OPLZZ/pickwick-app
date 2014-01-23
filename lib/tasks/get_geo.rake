
task :get_geo do
  require 'net/http'
  require 'pp'
  output = {}
  places = ["Praha","Brno","Ostrava","Plzeň","Liberec","Olomouc","Ústí nad Labem","Hradec Králové","České Budějovice","Pardubice","Havířov","Zlín","Kladno","Most","Karviná","Opava","Frýdek-Místek","Karlovy Vary","Jihlava","Teplice","Děčín","Chomutov","Přerov","Jablonec nad Nisou","Mladá Boleslav","Prostějov","Třebíč","Česká Lípa","Třinec","Tábor","Znojmo","Příbram","Cheb","Orlová","Kolín","Trutnov","Písek","Kroměříž","Šumperk","Vsetín","Valašské Meziříčí","Litvínov","Uherské Hradiště","Hodonín","Český Těšín","Břeclav","Krnov","Litoměřice","Sokolov","Nový Jičín","Havlíčkův Brod","Chrudim","Strakonice","Kopřivnice","Klatovy","Žďár nad Sázavou","Bohumín","Jindřichův Hradec","Vyškov","Blansko","Kutná Hora","Náchod","Jirkov","Mělník","Žatec","Hranice (okres Přerov)","Beroun","Louny","Otrokovice","Kralupy nad Vltavou","Kadaň","Brandýs nad Labem-Stará Boleslav","Ostrov","Svitavy","Bruntál","Uherský Brod","Rožnov pod Radhoštěm","Jičín","Rakovník","Neratovice","Benešov","Pelhřimov","Dvůr Králové nad Labem","Česká Třebová","Bílina","Varnsdorf","Slaný","Klášterec nad Ohří","Mariánské Lázně","Nymburk","Ústí nad Orlicí","Turnov","Chodov","Rokycany","Hlučín","Poděbrady","Zábřeh","Šternberk","Krupka","Říčany"]

  places.each do |place|
    puts place
    begin
      url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text%3D%22#{URI.encode(place)}%22&format=json&diagnostics=false&callback="
      pr = JSON.parse(Net::HTTP.get(URI(url)))

      res = pr["query"]["results"]["Result"]
      if res.is_a?(Array)
        res = res.first
      end
      output[place] = {
        lat: res["latitude"],
        long: res["longitude"]
      }
    rescue Exception => e
      puts "Problem with getting: #{place}"
      pp pr
      puts e.message
    end
  end
  pp output
end