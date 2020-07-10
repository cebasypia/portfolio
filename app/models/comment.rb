require 'action_view'
require 'action_view/helpers'

class Comment < ApplicationRecord
  include TwitterApi
  include ActionView::Helpers::DateHelper
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  def json
    comment = attributes
    comment["created_at"] = time_ago_in_words created_at
    comment["user"] = user.json
    comment["tweet"] = tweet # self.tweet
    comment
  end
end
