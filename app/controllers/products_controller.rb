class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.sort_by { |h| h[:created_at] }.reverse!
    @review = Review.new(@product_id)
  end

end
