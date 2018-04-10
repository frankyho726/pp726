Rails.application.routes.draw do
#   get 'users/new' #still need or delete? 20180410

#  get 'example/user'  #still need or delete? 20180410

  root 'staticpages#home'
  
  get  '/help', to: 'staticpages#help'
  get  '/about', to: 'staticpages#about'
  get  '/contact', to: 'staticpages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  resources :users
end
