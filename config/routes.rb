CannedMeat::Engine.routes.draw do

  resources :campaigns
  resources :lists
  resources :templates
  root to: 'dashboard#index'
end
