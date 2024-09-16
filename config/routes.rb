Rails.application.routes.draw do
devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
  namespace :api do
    namespace :v1 do
      resources :transactions
      resources :expenses, only: :index
      resources :incomes, only: :index
      resources :users do
        resources :transactions
      end
      resources :categories, only: :index
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
