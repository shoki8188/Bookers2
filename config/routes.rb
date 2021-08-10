Rails.application.routes.draw do
  get 'home/about' => 'homes#about'
  devise_for :users
  root to: 'homes#top'
  resources :users, only: [:show,:edit,:index,:update]
  resources :books do
    resource :favorites, only: [:destroy,:create]
  end
  resource :relationships, only: [:create, :destroy]
#resources :users, only: [:edit,:]
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
