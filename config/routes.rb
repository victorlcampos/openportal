Rails.application.routes.draw do
  namespace :tiles do
    get 'hello_world/index'
  end

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords:      'users/passwords',
    sessions:      'users/sessions',
    unlocks:       'users/unlocks',
    registrations: 'users/registrations'
  }

  resources :users

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :devices, only: [:create], controller: 'users/devices'
      end
    end
  end

  namespace :tiles do
    resources 'hello_world', only: [:index]
  end

  resources :admin, only: [:index]

  resources :permissions_groups
  resources :custom_fields
  resources :settings, only: [:edit, :update]

  get 'home' => 'home#index', as: 'home'
end
