PlantingSeasonCoordinator::Application.routes.draw do
  root "welcome#index"
  resources :beds
  resources :welcome
end
