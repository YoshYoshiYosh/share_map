Rails.application.routes.draw do
  resources :pins
  
  resources :maps do
    get :mymap, on: :collection
  end

  devise_for :users
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end