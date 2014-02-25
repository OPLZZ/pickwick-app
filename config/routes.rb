PickwickApp::Application.routes.draw do


  root "root#index"

  match "*path" => "root#index", via: [:get, :post]

end
