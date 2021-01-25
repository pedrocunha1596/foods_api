Rails.application.routes.draw do
  resources :foods do
    get 'search', on: :collection
  end
end
