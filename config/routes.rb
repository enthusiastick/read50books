Read50books::Application.routes.draw do
  devise_for :users

  resources :users, only: :show do
    resources :books
  end

  root 'pages#index'
end
