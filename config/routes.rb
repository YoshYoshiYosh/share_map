# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  get '/mypage', to: 'home#mypage'
  post '/contact', to: 'contacts#create'

  devise_for :users

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  resources :maps do
    get :mymap, on: :collection
    get :admin, on: :member # それぞれのMapの管理画面みたいなもの、ここからauthorized_maps/newとかに遷移させる。もしくはeditアクションで対応？
    resources :authorized_maps, except: [:edit]
    resources :pins
  end
end
