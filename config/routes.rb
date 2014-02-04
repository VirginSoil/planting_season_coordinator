PlantingSeasonCoordinator::Application.routes.draw do
  root "welcome#index"
  post "/", to: "welcome#create", as: :post_bed_form
end
