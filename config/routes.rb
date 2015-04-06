AbacusApp::Application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get 'registrations/awaiting_confirmation' => 'registrations#awaiting_confirmation'
  end

  resources :users
  resources :loans
  resources :profiles
  resources :investment_contracts
  resources :contract_templates
  resources :fund_assignments

  root 'dashboard#index'

end
