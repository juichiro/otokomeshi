Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  get 'today_recipe', to: 'posts#today_recipe'
  get 'myfavorite', to: 'users#myfavorite'
  get 'login', to: 'sessions#new'
  get 'mypage', to: 'users#mypage'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create, :show] do
    member do
      get :favoriting
    end 
  end 
  
  resources :posts, only: [:new, :show, :create, :edit, :update, :destroy] do 
    member do 
      get :favorited
    end 
  end 
  resources :favorites, only: [:create, :destroy]
end
