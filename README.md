# Pickwick::APP


This repository represents main frontend for damepraci.eu project.

Frontend currently implements search, pagination, and geoposition location.

After user sign in by `facebook connect` can create new vacancies, edit them and delete them.

There is a simple admin frontend, for validating uses vacancies.

## Instalation

clone repo
`git clone git@github.com:OPLZZ/pickwick-app.git`

install gems
`bundle install`

create SQLLite database
`rake db:create`

migrate into database
`rake db:migrate`

For starting app you need to get token from api.damepraci.cz
and then start it by
`PICKWICK_TOKEN=xxxxxxx bundle exec rails s`

open browser at http://127.0.0.1:3000

## Build of Web, iOS, Android apps

### Web application

web application will be generated to build/web/index.html 
`RAILS_ENV=production rake build_web`

### Building Web application with release

web application will be generated to build/web/index.html then packed into release.tar.gz. 
In github repo is created new release and release.tar.gz is uploaded as asset.

`RAILS_ENV=production rake build_web u=GITHUB_USERNAME p=GITHUB_PASSWORD`

### Building iOS App

```
cd build
phonegap create build_ios cz.damepraci.app "DamePraci"
cd build_ios
phonegap build ios
phonegap plugin add org.apache.cordova.geolocation

bundle exec rake build_ios RAILS_ENV=build_ios

open platforms/ios/DamePraci.xcodeproj
```

then you need to update:

General -> Bundle Identifier to `cz.damepraci.app`
Build Settings -> (click on show all) -> Valid Achitectures to `armv7 armv7s`

### Building Android App

```
cd build
mkdir build_android
bundle exec rake build_android RAILS_ENV=build_android
```

## Testing and development

Good tool for testing Ember.js
https://github.com/tildeio/ember-extension

### Used Icons
http://icomoon.io/
Brankic 1979

### Super bootstrap of Ember.js with animations
http://blangslet.com/post/55590279372/ember-js-mobile-animations-and-touch-gestures
https://github.com/blangslet/ember.js-mobile-animations-gestures

