CannedMeat::Engine.routes.draw do

  resources :lists
  resources :templates
  root to: 'dashboard#index'
end
