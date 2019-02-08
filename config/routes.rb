Rails.application.routes.draw do
  root 'main#index'
  post '/main/login', to: 'main#login', as: 'login'
  get '/main/logout', to: 'main#logout', as: 'logout'
  get '/main/play/:id', to: 'main#play', as: 'play_wordset'
  post '/main/play', to: 'main#play', as: 'play'
  post '/main/play_random', to: 'main#play_random', as: 'play_random'
  post '/main/question', to: 'main#question', as: 'question'
  resources :users
  resources :wordsets, shallow: true do
    resources :words
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
