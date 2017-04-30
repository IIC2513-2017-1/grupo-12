class Category < ApplicationRecord
  has_many :categorizations
  has_many :projects, through: :categorizations
end
