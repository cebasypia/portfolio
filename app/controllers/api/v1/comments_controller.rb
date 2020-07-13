class Api::V1::CommentsController < ApiController
  before_action :authenticate_user, only: [:create, :destroy]

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
    comments = Comment.where(tweet_id: params[:id]).order(created_at: "DESC")
    @comments = add_tweets(comments)
    render json: @comments
  end

  def get_user_comments
    comments = Comment.where(user_id: params[:id]).order(created_at: "DESC")
    @comments = add_tweets(comments)
    render json: @comments
  end

  def get_recent_comments
    comments = Comment.limit(20).order(created_at: "DESC")
    @comments = add_tweets(comments)
    render json: @comments
  end

  private

  def add_tweets(comments)
    @comments = []
    tweet_ids = comments.map { |comment| comment.tweet_id }
    tweets = Comment.tweets(tweet_ids)
    comments.each do |comment|
      @comment = comment.json
      tweets.each do |tweet|
        if @comment["tweet_id"] == tweet[:id]
          @comment["tweet"] = tweet
        end
      end
      @comments.push(@comment)
    end
    @comments
  end
end
