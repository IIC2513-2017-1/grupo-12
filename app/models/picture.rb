class Picture < ApplicationRecord
  belongs_to :project
  has_attached_file :image, styles: { thumb: '40x40', small: '150x150>', medium: '200x200' }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]
end
