class Project < ApplicationRecord
  validates :brief, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :funding_duration, presence: true, allow_blank: false
  validates :funding_goal, presence: true, allow_blank: false
  belongs_to :user
  has_many :comments
  has_many :donations
  has_many :passive_project_relationships, class_name:  "ProjectRelationship",
                                foreign_key: "saved_id",
                                validates :brief, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :funding_duration, presence: true, allow_blank: false
  validates :funding_goal, presence: true, allow_blank: false
                                dependent:   :destroy
  has_many :savers, through: :passive_project_relationships, source: :saver
  validates_associated :comments
  validates_associated :donations

  def saver?(user)
  	savers.include?(user)
  end

end
