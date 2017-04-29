class Project < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :donations
  has_many :passive_project_relationships, class_name:  "ProjectRelationship",
                                foreign_key: "saved_id",
                                dependent:   :destroy
  has_many :savers, through: :passive_project_relationships, source: :saver

  def saver?(user)
  	savers.include?(user)
  end

end
