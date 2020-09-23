Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles #this will give all articles routes
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
