Rails.application.routes.draw do
  root 'home#index'
  resources :home, only: :index do
    collection do
      get 'candidates'
    end
  end
end
