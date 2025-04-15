Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/products/interests" => "products#interests"
      get "/products/search" => "products#search"
      get "/products/:product_type" => "products#index"
    end
  end
end
