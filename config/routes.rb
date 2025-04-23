Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      #PRODUCTS
      get "/products/interests" => "products#interests"
      get "/products/search" => "products#search"
      get "/products/:product_type" => "products#index"

      #CART
      get "/cart/index" => "cart_items#index"
      post "/cart/update" => "cart_items#update"
    end
  end
end
