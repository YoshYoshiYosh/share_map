Rails.application.routes.draw do
  resources :maps
  devise_for :users
  root 'home#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
