Rails.application.routes.draw do
  get 'example/user'

  root 'staticpages#home'
  get  'staticpages/home'
  get  'staticpages/help'
  get  'staticpages/about'
  get  'staticpages/contact'
end
