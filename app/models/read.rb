require 'action_view'
require 'action_view/helpers'

class Read < ApplicationRecord
  include TwitterApi
  include ActionView::Helpers::DateHelper

  belongs_to :user
  validates :user_id, uniqueness: { scope: :tweet_id }

  def json
    reads = attributes
    reads["created_at"] = time_ago_in_words created_at
    reads["user"] = user.json
    reads["tweet"] = tweet # self.tweet
    reads
  end
end
