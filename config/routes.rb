PlantingSeasonCoordinator::Application.routes.draw do
  scope "dashboard" do
    post "/", to: "welcome#create", as: :post_bed_form
    root "beds#show"
    get "/", to: "beds#show", as: :bed_show_path
    resources :beds
    resources :welcome
  end
end
