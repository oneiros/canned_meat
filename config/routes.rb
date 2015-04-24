CannedMeat::Engine.routes.draw do

  resources :lists
  root to: 'dashboard#index'
end
