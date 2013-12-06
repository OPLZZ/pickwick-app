PickwickApp::Application.routes.draw do

  resources :job_postings

  root "root#index"

end
