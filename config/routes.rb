Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"

  resource :session, only: [:new, :create, :destroy]
  resource :account, only: [:show]
  resources :favorites, only: [:create, :destroy], param: :vehicle_id
  resources :booking_cancellations, only: [:update], param: :reservation_id

  resources :vehicles, only: [:index, :show] do
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:show], param: :id do
    collection do
      get :lookup
      post :find
    end
  end

  namespace :admin, path: "admin-portal" do
    resource :session, only: [:new, :create, :destroy]
    root "dashboard#index"
    resources :vehicles, except: [:show]
    resources :customers, only: [:index]
    resources :payments, only: [:index]
    resources :maintenance_logs, only: [:index, :create]
    resources :support_tickets, only: [:index]
    resources :coupons, only: [:index, :create]
    resources :content_blocks, only: [:index, :create]
    resources :team, only: [:index] do
      collection do
        post :invite
        patch :update_permissions
      end
    end
    resources :reservations, only: [:index, :show, :update] do
      member do
        patch :approve
        patch :deny
      end
      resources :rental_documents, only: [:create, :update, :destroy]
    end
    resources :leads, except: [:show]
  end
end
