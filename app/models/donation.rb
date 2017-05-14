class Donation < ApplicationRecord
  validates :amount, presence: true, allow_blank: false, numericality: { :greater_than => 0 }
  belongs_to :user
  belongs_to :project
end
