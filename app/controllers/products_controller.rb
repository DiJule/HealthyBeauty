class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :require_admin, only: [ :new, :create, :edit, :update, :destroy ]

  def index
    @products = Product.all

    if params[:search].present?
      search = params[:search].downcase
      @products = @products.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ?", "%#{search}%", "%#{search}%")
    end

    if params[:category].present?
      @products = @products.where(category_id: params[:category])
    end

    case params[:sort]
    when "price_asc"
      @products = @products.order(price: :asc)
    when "price_desc"
      @products = @products.order(price: :desc)
    when "name_asc"
      @products = @products.order(name: :asc)
    when "name_desc"
      @products = @products.order(name: :desc)
    else
      @products = @products.order(created_at: :desc)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: "Товар додано!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product, notice: "Оновлено!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Видалено"
  end

  def analyze_with_ai
    @product = Product.find(params[:id])
    require_admin

    # Call LocalAiService to analyze the product
    analysis = LocalAiService.analyze_product(@product.name, @product.description)

    # Log for debugging
    Rails.logger.info("Product: #{@product.name}, Desc: #{@product.description}")
    Rails.logger.info("Analysis: #{analysis.inspect}")

    # Update product with AI-generated content
    @product.update(
      characteristics: analysis["characteristics"]&.join("\n"),
      benefits: analysis["benefits"]&.join("\n"),
      usage: analysis["usage"]
    )
    redirect_to @product, notice: "✨ Товар успішно доповнено характеристиками!"
  end


  private

  def require_admin
    unless current_user&.admin?
      redirect_to products_path, alert: "Доступ дозволено лише адміністратору."
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category_id, :image, :characteristics, :benefits, :usage)
  end
end
