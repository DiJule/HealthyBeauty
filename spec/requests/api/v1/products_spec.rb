require "swagger_helper"

RSpec.describe "API::V1::Products", type: :request do
  path "/api/v1/products" do
    get "Отримати список продуктів" do
      tags "Products"
      produces "application/json"

      response "200", "успішно" do
        run_test!
      end
    end

    post "Створити продукт" do
      tags "Products"
      consumes "application/json"
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          price: { type: :number },
          category: { type: :string }
        },
        required: %w[name price]
      }

      response "201", "створено" do
        let(:product) { { name: "Test", price: 100 } }
        run_test!
      end
    end
  end
end
