CannedMeat::Engine.routes.draw do

  resources :campaigns do
    member do
      patch :send, action: :send_campaign
    end
  end

  resources :lists

  resources :templates

  root to: 'dashboard#index'
end
