# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/mypage', to: 'home#mypage'
  post '/contact', to: 'contacts#create'

  devise_for :users

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :maps, except: [:edit], param: 'map_id' do
    get :mymap, on: :collection

    member do
      scope :admin do
        get '/', to: 'maps#admin', as: 'admin'
        get '/edit', to: 'maps#edit'
        resources :authorized_maps, except: [:edit]
      end
      resources :pins
    end
  end
end
