AbacusApp::Application.routes.draw do
  
  namespace :admin do
  get 'requests/index'
  end

  namespace :admin do
  get 'loans/index'
  end

  devise_for :admin_users
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get 'registrations/awaiting_confirmation' => 'registrations#awaiting_confirmation'
  end

  namespace :admin do 
    get '/', to: 'dashboard#index', as: 'dashboard'
    resources :users, controller: 'users'
    resources :requests
    resources :loans
    resources :accounts
    resources :deposits
  end


  resources :users, only: [:show, :edit, :update] do
    get 'profile', on: :collection, as: 'profile'
    resources :requests, except: [:destroy, :edit, :update]
  end

  resources :loans
  resources :investment_contracts
  resources :contract_templates
  resources :fund_assignments

  root "home#index", as: "user_dashboard"

end
