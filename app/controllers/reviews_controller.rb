class ReviewsController < ApplicationController

  def new
  end

  def create
    raise "Yay I'm here"
    @product = Product.find(params[:id])
    @review = @product.reviews.create(review_params)
    
  end

end
