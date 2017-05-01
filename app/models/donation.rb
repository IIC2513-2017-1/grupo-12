class Donation < ApplicationRecord
  validates :amount, presence: true, allow_blank: false
  belongs_to :user
  belongs_to :project
end
