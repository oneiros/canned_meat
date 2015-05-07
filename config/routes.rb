CannedMeat::Engine.routes.draw do

  resources :campaigns do
    member do
      patch :send, action: :send_campaign
      post :send_test_mail
    end
  end

  resources :lists

  resources :templates

  get '/u/:unsubscribe_token', to: 'subscriptions#unsubscribe', as: 'unsubscribe'

  root to: 'dashboard#index'
end
