Rails.application.routes.draw do
  get 'weather/index'
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "weather#index"
  # post "weather", to: "weather#index"
  match "weather", to: "weather#index", via: [:get, :post]
  # match "/.well-known/*path", to: proc { [204, {}, [""]] }, via: :all
end
