Rails.application.routes.draw do
  root to: "owners#index"

  resources :owners do
    resources :machines, only: [:index]
  end

  resources :machines, only: [:show] do
    post 'add_snack', on: :member # /machines/:id/add_snack
  end
end
