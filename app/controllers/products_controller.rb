class ProductsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_product, only: %i[ show edit update destroy]

  def index
    @products = Product.all
    @ilove = "my mom"
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = product_params[:is_book] == "1" ? Book.new : Product.new
    @product.assign_attributes(product_params.except(:is_book))

    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # Convert to Book or Product if type is changing
    if product_params[:is_book] == "1" && !@product.is_a?(Book)
      @product = @product.becomes(Book)
      @product.type = "Book"
    elsif product_params[:is_book] == "0" && @product.is_a?(Book)
      @product = @product.becomes(Product)
      @product.type = nil
    end

    @product.assign_attributes(product_params.except(:is_book))

    if @product.save  # Just save, don't re-assign
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
      p "\n*****\nthis is a pp in set_product for #{@product.name}\n******\n"
    end

    def product_params
      params.expect(product: [ :name, :description, :featured_image, :inventory_count, :is_book, :author ])
    end
end
