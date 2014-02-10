PlantingSeasonCoordinator::Application.routes.draw do
  scope "dashboard" do
    post "/", to: "welcome#create", as: :post_bed_form
    root "beds#index"
    resources :beds
    resources :welcome
  end
end
