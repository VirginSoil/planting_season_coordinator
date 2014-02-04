PlantingSeasonCoordinator::Application.routes.draw do
  scope "my-gardens" do
    root "welcome#index"
  end
end
