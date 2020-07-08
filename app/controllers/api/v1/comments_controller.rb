class Api::V1::CommentsController < ApiController
  def create
    comment = current_user.comments.new(
      tweet_id: params[:tweet_id],
      content: params[:content]
    )
    if comment.save
      render json: Comment.where(tweet_id: params[:tweet_id])
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    comment.destroy
    head :no_content
  end

  def get_tweet_comments
    @comments = []
    comments = Comment.where(tweet_id: params[:id]).order(created_at: "DESC")
    comments.each do |comment|
      @comments.push(comment.json)
    end
    render json: @comments
  end

  def get_user_comments
    @comments = []
    comments = Comment.where(user_id: params[:id]).order(created_at: "DESC")
    comments.each do |comment|
      @comments.push(comment.json)
    end
    render json: @comments
  end
end
