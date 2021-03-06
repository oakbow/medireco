# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'home#index'

  resources :medical_bills

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/policy', to: 'home#policy'
  get '/disclaimer', to: 'home#disclaimer'

  resources :users do
    resources :family_members
    resources :payees
  end
end
