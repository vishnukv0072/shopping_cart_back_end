module Api
  module V1
    class ProductsController < ApplicationController

      def index
        render json: {page: "products/index"}
      end

      def show
      end

    end
  end
end