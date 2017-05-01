class ProjectRelationship < ApplicationRecord
	belongs_to :saver, class_name: 'User'
	belongs_to :saved, class_name: 'Project'
  	validates :saver_id, presence: true
  	validates :saved_id, presence: true
end
