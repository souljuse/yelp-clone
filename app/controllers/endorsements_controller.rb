class EndorsementsController < ApplicationController

  def index
    redirect_to(:back)
  end

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end
end
