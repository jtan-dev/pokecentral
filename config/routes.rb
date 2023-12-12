Rails.application.routes.draw do
  devise_for :customers
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post 'product/add_to_cart/:id', to: 'product#add_to_cart', as: 'add_to_cart'
  delete 'product/remove_from_cart/:id', to: 'product#remove_from_cart', as: 'remove_from_cart'
  post 'product/add_remove_quantity', to: 'product#add_remove_quantity', as: 'add_remove_quantity'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end


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
