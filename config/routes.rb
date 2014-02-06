PlantingSeasonCoordinator::Application.routes.draw do
  scope "my-gardens" do
    post "/", to: "welcome#create", as: :post_bed_form
  end
  root "welcome#index"
  resources :beds
  resources :welcome
end
