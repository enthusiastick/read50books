Read50books::Application.routes.draw do
  devise_for :users

  resources :books

  root 'pages#index'
end
