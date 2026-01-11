Rails.application.routes.draw do
  devise_for :users
  #devise cria varias rotas para o model que vai usá-lo
  devise_for :property_owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get 'my_profile', to: 'users#my_profile'
    resources :properties do 
    get 'my_properties', on: :collection
    resources :property_reservations, only: %i[create show], shallow: true do 
      post 'accept', on: :member
    end
  end

  resources :property_types
  resources :property_locations
  

end
