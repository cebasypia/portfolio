require 'action_view'
require 'action_view/helpers'

class Api::V1::ReadsController < ApiController
  include ActionView::Helpers::DateHelper

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
    reads = Read.limit(10).order(created_at: "DESC")
    reads.each do |read|
      @read = {}
      @read[:id] = read.id
      @read[:created_at] = time_ago_in_words read.created_at
      @read[:user] = read.user
      @read[:tweet] = read.tweet
      @reads.push(@read)
    end
    render json: @reads
  end

  def get_user_tweets
    @read_tweets = []
    reads = Read.where(user_id: params[:id]).order(created_at: "DESC")
    reads.each do |read|
      @read_tweets.push(read.tweet)
    end
    render json: @read_tweets
  end
end
