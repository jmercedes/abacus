AbacusApp::Application.routes.draw do
  devise_for :admin_users
  devise_for :users, :controllers => { :registrations => "registrations" }

  devise_scope :user do
    get 'registrations/awaiting_confirmation' => 'registrations#awaiting_confirmation'
  end

  namespace :admin do 
    get '/', to: 'dashboard#index', as: 'dashboard'

    resources :users

    resources :loans do
      get :amortization, on: :member
    end

    resources :accounts

    resources :payments do
      collection do
        get :calculate_late_fee
        get :loans
        post :closure_loan
      end
    end

    resources :deposits
    resources :requests
  end

  resources :users, only: [:show, :edit, :update] do
    get 'profile', on: :collection, as: 'profile'
    resources :requests, except: [:destroy, :edit, :update]
    resources :loans, except: [:destroy, :edit, :update]
  end

  resources :loans
  resources :investment_contracts
  resources :contract_templates
  resources :fund_assignments

  root "home#index", as: "user_dashboard"
end