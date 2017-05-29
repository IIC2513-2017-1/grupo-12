class Picture < ApplicationRecord
  belongs_to :project
  has_attached_file :image, styles: { thumb: '40x40', small: '150x150>', medium: '200x200' }
  validates_attachment_presence :image
  validates_attachment_size :image, less_than: 5.megabytes
end
