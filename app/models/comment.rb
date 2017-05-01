class Comment < ApplicationRecord
  validates :content, presence: true, allow_blank: false
  belongs_to :user
  belongs_to :project
end
