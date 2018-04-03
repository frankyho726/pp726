Rails.application.routes.draw do
<<<<<<< HEAD
 
 
  root 'staticpages#home'
  get 'staticpages/home'
  get 'staticpages/help'
  get 'staticpages/about'
  get 'staticpages/contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
##root 'application#hello'
=======
  get 'staticpages/home'

  get 'staticpages/help'
  get 'staticpages/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
>>>>>>> static-pages

end
