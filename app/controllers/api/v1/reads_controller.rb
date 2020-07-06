class Api::V1::ReadsController < ApiController
  def create
    read = current_user.reads.new(tweet_id: params[:tweet_id])
    read.save
    render json: current_user.reads.where(tweet_id: params[:tweet_id]).present?
  end

  def destroy
    read = current_user.reads.find_by(tweet_id: params[:id])
    read.destroy
    render json: current_user.reads.where(tweet_id: params[:id]).present?
  end

  def is_read
    render json: current_user.reads.where(tweet_id: params[:tweet_id]).present?
  end
end
