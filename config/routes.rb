Rails.application.routes.draw do
  root 'home#index'
  get '/mypage', to: 'home#mypage'

  devise_for :users
  
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  resources :maps do
    get :mymap, on: :collection
    resources :authorized_maps, except: [:edit], as: 'authorize', path: 'authorizing'
    resources :pins
  end
  
end