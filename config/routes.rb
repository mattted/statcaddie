Rails.application.routes.draw do
  resources :courses
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'main#index'

end
