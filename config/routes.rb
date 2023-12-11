Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'product/add_to_cart/:id', to: 'product#add_to_cart', as: 'add_to_cart'
  delete 'product/remove_from_cart/:id', to: 'product#remove_from_cart', as: 'remove_from_cart'

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'product#index'
  resources :product do
    collection do
      get 'search'
    end
  end

  resources :categories

  get ':title', to: 'contact_about_pages#show', as: 'custom_contact_about_page'
end
