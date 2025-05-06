    class Api::V1::ProductsController < ApplicationController

      def index
        limit = params[:limit].present? ? params[:limit] : 10
        offset = params[:offset].present? ? params[:offset] : 0
        sort_order = params[:sort_order].present? ? params[:sort_order] : "created_at"
        order_map = {
          "price-asc" => "price ASC",
          "price-desc" => "price DESC",
          "newest" => "created_at DESC",
          "ratings" => "rating DESC",
          "created_at" => "created_at ASC"
        }
        products = Product
        products = products.where(category: params[:product_type])
        products = products.or(Product.where("category ilike ?", "%#{params[:product_type]}%")) if products.length < limit
        products = products.or(Product.where(title: params[:product_type])) if products.length < limit
        products = products.or(Product.where("title ilike ?", "%#{params[:product_type]}%")) if products.length < limit
        min_max = get_min_max(products)
        products = products.order(order_map[sort_order])
        max_pages = products.length / limit
        max_pages += 1 if products.length % limit > 0
        products = products.offset(offset.to_i * limit).limit(limit).as_json
        cart_items = {}
        cart_items = current_user.get_cart_items if current_user
        render json: {products: products, minMax: min_max, maxPages: max_pages, cartItems: cart_items}
      end

      def interests
        user_id = current_user ? current_user.id : nil
        categories = Interest.where(user_id: user_id).pluck(:category, :image_urls).to_h
        render json: { categories: categories }
      end

      def search
        limit = params[:limit].present? ? params[:limit] : 100
        offset = params[:offset].present? ? params[:offset] : 0
        products = Product
        products = products.where(category: params[:category]) if params[:category].present?
        if params[:q].present? && params[:category].blank?
          query = params[:q]
          products = products.where(category: query)
          products = products.or(Product.where("category ilike ?", "%#{query}%")) if products.length < limit
          products = products.or(Product.where(title: query)) if products.length < limit
          products = products.or(Product.where("title ilike ?", "%#{query}%")) if products.length < limit
        end
        products = products.limit(limit).offset(offset)
        render json: { data: products }
      end

      private

      def get_min_max(products)
        min = products.order(price: :asc).limit(1).last&.price
        max = products.order(price: :desc).limit(1).last&.price
        [min, max]
      end


end