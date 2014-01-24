class JobPostingsController < ApplicationController
  before_action :set_job_posting, only: [:show, :edit, :update, :destroy]
  before_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  def flat_hash(hash, k = [])
    return {k => hash} unless hash.is_a?(Hash)
    hash.inject({}){ |h, v| h.merge! flat_hash(v[-1], k + [v[0]]) }
  end

  def join_keys(hash)
    hash.inject({}){|h,(k,v)| h.merge!({k.join("_") => v })}
  end


  # GET /job_postings
  def index
    from  = params[:from]  || 0
    limit = params[:limit] || 10

    #geo parsing
    geo = {:latitude=>"50.07908", :longitude=>"14.43323"}
    if params[:location] == "Aktuální pozice"
      #choose longtitude and latitude from request
      geo = {:latitude=>params[:latitude], :longitude=>params[:longitude]}
    elsif params[:location] != "Aktuální pozice" && JobPosting::LOCATIONS.has_key?(params[:location])
      #get geolocation from name of city
      geo = JobPosting::LOCATIONS[params[:location]]
    end

    if params[:query]
      @job_postings = JobPosting.where('title like ?', "%#{params[:query]}%")
    else
      @job_postings = JobPosting
    end

    test_output = '{
      "vacancies": [
          {
              "id": "30521ece051dab13dbdbc7c1ef8dc0c101551228",
              "title": "lakýrníci automobilů a jiných vozidel",
              "description": "Přijmeme lakýrníka na lakování železničních vagónů. \nJedná se o přesnou práci mokrou cestou - povrchový lak.\n\n Požadujeme \n-vyučení v oboru\n-praxe min. 2roky\n-pracovitost, spolehlivost\n-manuální zručnost\n\n Nabízíme\n-stabilní zaměstnání v prosperující firmě\n-hlavní pracovní poměr \n-nástup ihned\n-mzda 64,-/hod + 16,- prostředí\n-příplatky so+ne+ přesčasy 25%\n-denní diety 157,-\n-hrazené ubytování a cestovní náklady\n\n\n Nástup ihned/dohodou.\n Místo výkonu práce Šumperk.",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Žerotínova 1833/56",
                  "city": "Šumperk",
                  "region": null,
                  "zip": "787 01",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 49.955295,
                      "lon": 16.9765056
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Personal fabric - agentura práce, a.s."
              },
              "publisher": null,
              "contact": {
                  "email": "lucie.nytrova@personalfabric.cz",
                  "name": "Lucie Nytrová",
                  "phone": "+420 724 065 854"
              },
              "compensation": null,
              "start_date": "2014-01-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:10Z"
          },
          {
              "id": "d8f2f32faa58db5ef0dfffc778d22d7f27a1999d",
              "title": "sap konzultant/ka",
              "description": "Děkujeme za Váš zájem. Na pozici se můžete přihlásit prostřednictvím našich www stránek: www.siemens.cz nebo www.siemens.jobs.cz. Referenční číslo pozice:157389\n\nNáplň práce:\n* poskytování odborné technické podpory v oblasti konfigurace a business procesů při implementaci a podpoře SAP\n* komunikace s uživateli, sběr požadavků, analýza a návrh řešení\n* nastavování a customizace modulů\n* vývoj programů a aplikací v programu ABAP\n* identifikace, zajištění a realizace potřebného vývoje či změnových požadavků v SAP modulech\n* spolupráce s ostatními členy týmu, spolupráce v mezinárodním týmu",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Šedivská 339",
                  "city": "Letohrad",
                  "region": null,
                  "zip": "561 51",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 50.0374308,
                      "lon": 16.5086399
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "OEZ s.r.o."
              },
              "publisher": null,
              "contact": {
                  "email": null,
                  "name": "Eva Straková",
                  "phone": "+420 465 672 259"
              },
              "compensation": null,
              "start_date": "2014-01-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:02Z"
          },
          {
              "id": "0a4dc35437537bb2f18bacc8cbba76aaf19c4880",
              "title": "brusič kovů (převážně ruční)",
              "description": "Přijmeme samostatného brusiče na ruční broušení kovů. \n\nPožadujeme:\n-praxe s broušením kovů\n-vyučení ve strojírenském oboru\n-svědomitost, pečlivost \n\n\n Nabízíme:\n-mzda 75,-/hod + 6,-prostředí \n-so + ne příplatek 50%, přesčas 25%\n-pracovní smlouva na dobu neurčitou \n-práce ve směnném provozu\n-místo výkonu práce Ostrava\n\n Pozice určena pro místní, nástup ihned.",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "",
                  "city": "Benešov",
                  "region": null,
                  "zip": null,
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 49.7818921,
                      "lon": 14.6869121
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Personal fabric - agentura práce, a.s."
              },
              "publisher": null,
              "contact": {
                  "email": "lucie.nytrova@personalfabric.cz",
                  "name": "Lucie Nytrová",
                  "phone": "+420 724 065 854"
              },
              "compensation": null,
              "start_date": "2014-01-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:24:58Z"
          },
          {
              "id": "b087839ce508c2999e5ca0ebfcac6a715e0b8b54",
              "title": "kovář zápustkového stroje",
              "description": "Kovář s praxí se zápustkovým kováním.\n\n Požadujeme:\n-vyučení v oboru kovář\n-praxe min. 2roky\n-ochotu pracovat na turnusy\n\n\n Nabízíme:\n-hlavní pracovní poměr\n-dlouhodobé uplatnění\n-mzda 72,20 + 10,- osobní ohodnocení\n+příplatky za prostředí, 25%so +ne\n-denní diety 178,-\n-hrazené ubytování a cesta\n\n nástup ihned/dohodou\n",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "",
                  "city": "Studénka",
                  "region": null,
                  "zip": null,
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 49.7092756,
                      "lon": 18.059283
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Personal fabric - agentura práce, a.s."
              },
              "publisher": null,
              "contact": {
                  "email": "lucie.nytrova@personalfabric.cz",
                  "name": "Lucie Nytrová",
                  "phone": "+420 724 065 854"
              },
              "compensation": null,
              "start_date": "2014-01-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:06Z"
          },
          {
              "id": "3a38bfb8532a3ee512d13f0d397007ba332e23d5",
              "title": "kuchař/ka teplé kuchyně",
              "description": "Hotel v centru KV přijme kuchaře/ku teplé kuchyně. Vyučení v oboru a praxe 2 roky podmínkou. Uchazeče na pracoviště neposílat, podmínkou pro zařazení do výběrového řízení je zaslat profesní životopis na uvedaný email.",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Divadelní náměstí 253/17",
                  "city": "Karlovy Vary",
                  "region": null,
                  "zip": "360 01",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 50.2212062,
                      "lon": 12.8827087
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "OLYMP INTERNATIONAL, s.r.o."
              },
              "publisher": null,
              "contact": {
                  "email": "personalni@interhotel-central.cz",
                  "name": "Ivana Jirásková",
                  "phone": "+420 353 182 650"
              },
              "compensation": null,
              "start_date": "2013-12-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:08Z"
          },
          {
              "id": "5b261114ea3024fdfcd811108796359b46f8a357",
              "title": "účetní, mzdová účetní",
              "description": "Minimální praxe v oboru 5 let. Zkušenosti se správou a účtováním dotací výhodou. Účtování v programu POHODA.Anglický jazyk na pokročilé úrovni.\nE-mail s životopisem posílejte na adresu docekalova@kameno-komarek.cz. Nástup od 1.2.2014.",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Pražská 328/31",
                  "city": "Letovice",
                  "region": null,
                  "zip": "679 61",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 49.5640529,
                      "lon": 16.5708421
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "KAMENOPRŮMYSL KOMÁREK s.r.o."
              },
              "publisher": null,
              "contact": {
                  "email": "docekalova@kameno-komarek.cz",
                  "name": "Ing. Kateřina Dočekalová",
                  "phone": "+420 777 553 368"
              },
              "compensation": null,
              "start_date": "2014-01-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:24:56Z"
          },
          {
              "id": "75bb6d5b9dc7a31487857f9bda6d3539b06b7e93",
              "title": "hlavní účetní",
              "description": "Požadujeme: vzdělání ekonomického směru, praxi vedení účetnictví, znalost DPH, velmi dobrou znalost práci na PC\nVýhodou: znalost účetnictví PO, PAP",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Lázeňská 58",
                  "city": "Brandýs nad Orlicí",
                  "region": null,
                  "zip": "561 12",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 50.0037965,
                      "lon": 16.2812922
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Rehabilitační ústav Brandýs nad Orlicí"
              },
              "publisher": null,
              "contact": {
                  "email": "kutnarova@rehabilitacniustav.cz",
                  "name": "Radka Kutnarová",
                  "phone": "+420 465 544 206,465 544 207"
              },
              "compensation": null,
              "start_date": "2014-01-19T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:04Z"
          },
          {
              "id": "65f5fc563d60cdd3485aa783c20e4e15e2cc92b4",
              "title": "autoelektrikář",
              "description": "Praxe v oboru min. 3 roky (nejlépe nákladní automobily), požadujeme zodpovědný přístup a loajálnost. Životopis zašlete emailem na uvedenou emailovou adresu.",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Doubská 573",
                  "city": "Liberec",
                  "region": null,
                  "zip": "463 12",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 50.7419604,
                      "lon": 15.0559599
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Master Truck s.r.o."
              },
              "publisher": null,
              "contact": {
                  "email": "m.skrob@mastertruck.cz",
                  "name": "Michal Škrob",
                  "phone": "+420 724 111 122"
              },
              "compensation": null,
              "start_date": "2014-01-01T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:00Z"
          },
          {
              "id": "5d73c6e8eb693e4cf7f2a2c78f9af6da37f88c85",
              "title": "lektor jazyků",
              "description": "pouze rodilý mluvčí anglického jazyka",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "full-time",
              "remote": false,
              "location": {
                  "street": "Roháčova 1095/77",
                  "city": "Praha",
                  "region": null,
                  "zip": "130 00",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 50.0885802,
                      "lon": 14.4620175
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Wattsenglish Ltd., Czech Republic branch, organizační složka"
              },
              "publisher": null,
              "contact": {
                  "email": "michaela.pavlatova@wattsenglish.com",
                  "name": "Mgr. Michaela Pavlátová",
                  "phone": "+420 725 719 050"
              },
              "compensation": null,
              "start_date": "2013-12-31T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:12Z"
          },
          {
              "id": "7f1ed8f721c5e7a60802326a4997549ac50f4996",
              "title": "lektor(ka) angličtiny",
              "description": "Jsme menší jazyková, vzdělávací a grantová agentura působící po celé EU. Naším hlavním produktem je moderní a efektivní vzdělávání založené na tzv. Synergy Blended Learning. Dále se zabýváme překlady, coachingem, personalistikou a granty.\n\nPro doplnění našeho týmu hledáme vhodného kandidáta na pozici:\n\nLektor(ka) angličtiny\n\nVaším úkolem bude učit naše klienty přes Skype, klasicky (face-to-face) a aktivně se podílet na tvorbě studijním materiálů pro Synergy Blended Learning. \n\nNabízíme\n> unikátní metodiku \"virtuální\" synergické výuky\n> flexibilní pracovní dobu\n> odměnu ve výši 150 - 350,-/hod.\n> DoPP, ŽL\n> free office, firemní SIM s “unlimited”  tarifem i pro soukromé použití, smartphone\n> pracovní, tedy „lektorský“ kontakt s firemní klientelou \n\nOčekáváme\n> výborný hlasový a písemný projev\n> vstřícnou, přátelskou osobnost\n> kvalitní angličtinu\n> prezentační a komunikační nadání\n> min. 20 hod. měsíční úvazek\n> bydliště v Olomouci a okolí\n\nPokud Vás zaujala tato příležitost, zašlete nám: 1. CV, 2. krátký motivační dopis/email, 3. fotografii na  info@q-life.cz a do předmětu emailu prosím napište \"Lektor anglictiny _ Jmeno PRIJMENI _ 2014-01” (prosíme bez diakritiky).\n\nQ-LiFE Agency s.r.o.\nŠlechtitelů 813/21  \n(Vědeckotechnický park Univerzity Palackého Olomouc)\n779 00 Olomouc, Holice\nhttp://www.q-life.cz",
              "industry": null,
              "responsibilities": null,
              "number_of_positions": null,
              "employment_type": "part-time",
              "remote": false,
              "location": {
                  "street": "Šlechtitelů 813/21",
                  "city": "Olomouc",
                  "region": null,
                  "zip": "779 00",
                  "country": "Czech Republic",
                  "coordinates": {
                      "lat": 49.5760478,
                      "lon": 17.2815806
                  }
              },
              "experience": null,
              "employer": {
                  "name": null,
                  "company": "Q-Life Agency s.r.o."
              },
              "publisher": null,
              "contact": {
                  "email": "info@q-life.cz",
                  "name": "Adéla Pracná, Personalista",
                  "phone": "+420 730 890 064"
              },
              "compensation": null,
              "start_date": "2014-01-06T13:00:00Z",
              "expiration_date": "2014-02-13T06:24:54Z",
              "created_at": "2014-01-14T06:24:54Z",
              "updated_at": "2014-01-14T06:25:14Z"
          }
      ]
    }'
    output = JSON.parse(test_output)
    #render json: @job_postings.offset(from).limit(limit)

    render json: output["vacancies"].collect{|v| join_keys(flat_hash(v))}
  end

  # GET /job_postings/1
  def show
    render json: @job_posting
  end

  # GET /job_postings/new
  def new
    @job_posting = JobPosting.new
    render json: @job_posting
  end

  # GET /job_postings/1/edit
  def edit
  end

  # POST /job_postings
  def create
    @job_posting = JobPosting.new(job_posting_params)

    if @job_posting.save
      redirect_to @job_posting, notice: 'Job posting was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /job_postings/1
  def update
    if @job_posting.update(job_posting_params)
      redirect_to @job_posting, notice: 'Job posting was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /job_postings/1
  def destroy
    @job_posting.destroy
    redirect_to job_postings_url, notice: 'Job posting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting
      @job_posting = JobPosting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def job_posting_params
      params.require(:job_posting).permit(:title, :employment_type, :location, :description, :compensation, :contact, :url)
    end
end
