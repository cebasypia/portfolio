class Comment < ApplicationRecord
  include TwitterApi
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  def json
    comment = {}
    comment["id"] = id
    comment["content"] = content
    comment["user"] = user
    comment["tweet"] = tweet # self.tweet
    comment
  end
end
