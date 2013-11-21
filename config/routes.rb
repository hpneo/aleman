Aleman::Application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end

  resources :loans
  resources :payments do
    member do
      get 'form'
    end
  end
  
  root :to => 'home#index'
end
