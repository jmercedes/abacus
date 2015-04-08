AbacusApp::Application.routes.draw do
  
  devise_for :admin_users
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get 'registrations/awaiting_confirmation' => 'registrations#awaiting_confirmation'
  end

  namespace :admin do 
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :users, controller: 'users'
  end


  resources :users, only: [:show, :edit, :update] do
    get 'profile', on: :collection, as: 'profile'
  end

  resources :loans
  resources :investment_contracts
  resources :contract_templates
  resources :fund_assignments

  root 'users#profile'

end
