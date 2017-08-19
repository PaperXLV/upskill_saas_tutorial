Rails.application.routes.draw do
  
  # Determines routes 
  # Use rails routes in console to find prefixes to use in routing for links
  root to: 'pages#home'
  # Makes the controller for registrations users/registrations
  # We have additional code there to handle the different plans
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
  end
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
