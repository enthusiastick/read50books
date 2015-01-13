Read50books::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :update] do
    resources :books
  end

  root 'pages#index'
end
