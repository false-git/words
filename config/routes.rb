Rails.application.routes.draw do
  resources :users
  resources :wordsets, shallow: true do
    resources :words
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
