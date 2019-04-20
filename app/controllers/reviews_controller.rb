class ReviewsController < ApplicationController

  def new
  end

  def create
    description = params[:review][:description]
    rating = params[:review][:rating].to_i
    product_id = params[:product_id]
    Review.create!({
        product_id: product_id,  
        user_id: current_user.id,
        description: description, 
        rating: rating
      })
    redirect_to :back
  end

end

