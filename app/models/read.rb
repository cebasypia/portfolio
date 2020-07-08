class Read < ApplicationRecord
  include TwitterApi

  belongs_to :user
  validates :user_id, uniqueness: { scope: :tweet_id }
end
