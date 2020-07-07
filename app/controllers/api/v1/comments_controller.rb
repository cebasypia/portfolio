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
    tweet_id = comment.tweet.id
    comment.destroy
    render json: Comment.where(tweet_id: tweet_id)
  end

  def get_comments
    comments = Comment.where(tweet_id: params[:id]).order(created_at: "DESC")
    render json: comments
  end
end
