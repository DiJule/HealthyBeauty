module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        products = Product.select(:id, :name, :price, :category)
        render json: products
      end

      def create
        product = Product.new(product_params)

        if product.save
          render json: product, status: :created
        else
          render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:product).permit(:name, :price, :category, :description)
      end
    end
  end
end
