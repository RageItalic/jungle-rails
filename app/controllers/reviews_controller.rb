class ReviewsController < ApplicationController
  before_filter :authorize
  before_action :set_product

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product)
    else

      render template: 'products/show'#, locals: {product: @product}
    end

  end


  def destroy

    @review = current_user.reviews.find(params[:id]) if current_user

    @review.destroy

    render template: 'products/show'

  end



private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end

end
