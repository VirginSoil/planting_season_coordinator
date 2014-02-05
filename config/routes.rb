PlantingSeasonCoordinator::Application.routes.draw do
  root "welcome#index"
  resources :beds
  get "/new", to: "beds#create"
end
