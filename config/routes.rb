Rails.application.routes.draw do
  root 'static_pages#index'

  resources :tickets, only: [:new, :create, :show]
  get '/ticket_submitted' => 'static_pages#ticket_submitted'
  get '/organization_expectations' => 'static_pages#organization_expectations'
  post '/tickets/:id/capture', to: 'tickets#capture', as: 'capture_ticket'
  post '/tickets/:id/release', to: 'tickets#release', as: 'release_ticket'
  patch '/tickets/:id/close', to: 'tickets#close', as: 'close_ticket'

  devise_scope :user do
    get '/login' => 'users/sessions#new'
    delete '/logout' => 'users/sessions#destroy'
    get '/signup' => 'users/registrations#new'
    get '/edit_profile' => 'users/registrations#edit'
  end
  devise_for :users, controllers: { registrations: 'users/registrations' }

  authenticate :user do

    resources :tickets, only: :destroy

    resources :organizations do
      member do
        post :approve
        post :reject
        get :resources
      end
    end

    resources :resource_categories do
      member do
        patch :activate
        patch :deactivate
      end
    end

    resources :regions

    get '/dashboard' => 'dashboard#index'
    get '/new_organization_application' => 'organizations#new'
    get '/organization_application_submitted' => 'static_pages#organization_application_submitted'
  end
end
