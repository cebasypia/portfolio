require 'action_view'
require 'action_view/helpers'

class Api::V1::ReadsController < ApiController
  include ActionView::Helpers::DateHelper
  before_action :authenticate_user, only: [:create, :destroy, :is_read]

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
    render json: current_user.reads.where(tweet_id: params[:id]).present?
  end

  def get_recent_reads
    @reads = []
    reads = Read.limit(20).order(created_at: "DESC")
    tweet_ids = reads.map { |read| read.tweet_id }
    tweets = Read.tweets(tweet_ids)
    reads.each do |read|
      @read = read.json
      tweets.each do |tweet|
        if @read["tweet_id"] == tweet[:id]
          @read["tweet"] = tweet
        end
      end
      @reads.push(@read)
    end
    render json: @reads
  end

  def get_user_tweets
    @tweets = []
    reads = Read.where(user_id: params[:id]).order(created_at: "DESC")
    tweet_ids = reads.map { |read| read.tweet_id }
    @tweets = Read.tweets(tweet_ids)
    render json: @tweets
  end
end
