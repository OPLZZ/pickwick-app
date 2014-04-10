PickwickApp::Application.routes.draw do

  resource 'users', only:[:create, :show] do
    resource 'job_postings'
  end

  root "root#index"

  match "*path" => "root#index", via: [:get, :post]

end
