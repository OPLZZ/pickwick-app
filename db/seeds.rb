
[
  {
    :title=>"Programátor PHP/MySQL",
    :employment_type=>"Práce na částečný úvazek",
    :location => "Praha 2",
    :description=> "Náplň práce programování portálu - nové sociální sítě programování modulů této sociální sítěPožadujeme znalost PHP, MySQL, HTML, CSS výhodou znalost Javascript, jQuery, AjaxNabízíme 25 000 - 40 000,-/měsíc možnost full time i zkrácený úvazek (20 hod. týdně) práce v týmu schopných developerů",
    :compensation=> "25000-40000 Kč",
    :contact=>"Mezinárodní Společnost"
  },
  {
    :title=>"Administrátor databáze - brigáda",
    :employment_type=>"Dohoda o provedení práce",
    :location => "Ústí nad Labem",
    :description=>"Administrátor databáze - brigáda Popis pozice:• zadávání/testování dat Požadujeme:• HTML (XHTML, XML)• CSS (nebo alespoň znalost, jak něco rychle najit)• JavaScript výhodou (bez frameworku) nebo zkušenost s libovolným jazykem• PHP a SQL výhodou• nadšenou a tvůrčí osobnost se zájmem o ITNabízíme:• práci ve stabilní rozvíjející se mezinárodní společnosti• odpovídající platové ohodnocení• možnost spolupráce na ŽL formou mandátní smlouvy nebo na Dohodu o provedení práce",
    :compensation=> "150 Kč/hod.",
    :contact=>"CCS S.r.o.",
  },
  {
    :title=>"Internship - SW / HW Development",
    :employment_type=>"Práce na částečný úvazek",
    :location => "Brno",
    :description=>"Description Honeywell Aerospace is a leading global provider of integrated avionics, propulsion engines, aircraft and engine systems and full-service solutions for airliners, business and general aviation aircraft, military aircraft and spacecraft. Developing innovative safety products, driving the modernization of global air traffic management, revolutionizing combat technology and committed to improving operational efficiencies. Rational Method Composer (RMC) support for the Electronic Hardware Center of Excellence. RMC is an IBM tool that we use to capture and publish our Hardware Development Processes (we call it our Integrated Engineering Process- IEP). The successful candidate will: take information that our electronic hardware team has captured in templates and translate them into RMC help the hardware team generate Process documents created in RMC work with our team and other RMC experts outside of our immediate team to improve our efficiency in translating templates into RMC and generating Process documents to develop our electronic products Qualifications Attributes/Skills Required: Comfortable working with a variety of SW packages A desire to learn Rational Method Composer Ability and desire to work in virtual team environment Good English written and verbal communication skills Experience/Education Required: Bachelors Degree in technical field (Engineering, IT or related fields)",
    :compensation=>"15000Kč za měsíc",
    :contact=>"Honeywell Praha"
  },
  {
    :title=>"Programování Joomla",
    :employment_type=>"Dohoda o provedení práce",
    :location => "Ostrava",
    :description=>"Pro úpravu jednoho fungujícího webu a vytvoření a následně údržbu nového projektu v Joomla hledám šikovného programátora, který má s weby v Joomla zkušenosti. Půjde o projekt informačního webu s částečně placeným přístupem k obsahu, půjde o implementaci šablony, vytvoření či použití a úpravu pro placení prohlížení článků - nstavení přístupových práv a úrovní, propojení s platebními systémy, sledování délky předplatného u uživatele a spoustu dalších \"drobných\" úprav. V odpovědi pošlete mimo kontaktu i nějaké reference na již vytvořené a fungující weby.",
    :compensation=> "80-120 Kč/hod.",
    :contact=>"Ing. Pavel Bradáč"
  }
].each do |jp|
  puts "Creating Job Posting: #{jp[:title]}"
  JobPosting.create(jp)
end