AbacusApp::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }, path_prefix: 'crediclub'

  devise_scope :user do
    get 'registrations/awaiting_confirmation' => 'registrations#awaiting_confirmation'
  end

  resources :users, controller: 'users'
  resources :loans
  resources :investment_contracts
  resources :contract_templates
  resources :fund_assignments

  root 'dashboard#index'

end
