PlantingSeasonCoordinator::Application.routes.draw do
  scope "my-gardens" do
    root "welcome#index"
    post "/", to: "welcome#create", as: :post_bed_form
  end
end
