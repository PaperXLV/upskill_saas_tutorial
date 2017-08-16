Rails.application.routes.draw do
  
  # Determines routes 
  # Use rails routes in console to find prefixes to use in routing for links
  devise_for :users
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
