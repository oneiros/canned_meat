CannedMeat::Engine.routes.draw do

  resources :campaigns do
    member do
      patch :send, action: :send_campaign
      post :send_test_mail
    end
  end

  resources :lists

  resources :templates

  root to: 'dashboard#index'
end
