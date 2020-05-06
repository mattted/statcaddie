Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'main#index'

  get '/rounds/factory', to: 'rounds#factory'

  resources :rounds, shallow: true do
    resources :scorecards
  end

  resources :courses, shallow: true do
    resources :tees
    resources :holes
  end

end
