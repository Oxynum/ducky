Ducky::Application.routes.draw do
  resources :configuration_files, only: [:show, :update, :index]
end
