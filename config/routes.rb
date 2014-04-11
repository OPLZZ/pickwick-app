PickwickApp::Application.routes.draw do

  match '/admin' => 'job_postings#admin_index', via: [:get], as: 'admin_index'
  match '/admin/:id/valid' => 'job_postings#admin_valid', via: [:get,:post], as: 'admin_valid'
  match '/admin/:id/invalid' => 'job_postings#admin_invalid', via: [:get,:post], as: 'admin_invalid'

  resources 'users', only:[:create, :show] do
    resources 'job_postings'
  end

  root "root#index"

  match "*path" => "root#index", via: [:get, :post]


end
