Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'callbacks' }
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'main#index'

  get '/rounds/factory', to: 'rounds#factory'
  get '/my_courses', to: 'courses#index_created'
  get '/golfed_courses', to: 'courses#index_golfed'

  resources :rounds, shallow: true do
    resources :scorecards
  end

  resources :courses, shallow: true do
    resources :tees
    resources :holes
  end

end
