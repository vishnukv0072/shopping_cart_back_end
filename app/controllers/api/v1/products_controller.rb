module Api
  module V1
    class ProductsController < ApplicationController

      def index
        categories = Product.limit(200000).pluck(:category).uniq
        category_array = []
        categories.each do |cat|
          img = Product.where(category: cat).limit(4).pluck(:image_url)
          category_array << {name: cat, image: img}
        end
        render json: { categories: category_array }
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

    end
  end
end