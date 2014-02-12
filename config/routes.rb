PlantingSeasonCoordinator::Application.routes.draw do
  scope "dashboard" do
    post "/", to: "bed#create", as: :post_bed_form
    root "beds#show"
    get "/", to: "beds#show", as: :bed_show_path
    resources :beds, except: [:destroy]
    resources :welcome, only: :new
  end
end
